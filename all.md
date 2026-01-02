# OrangeOS 操作系统全景深度分析报告

这份报告基于 OrangeOS 源代码，详细剖析了系统的启动流程、核心架构、关键子系统实现及用户态扩展。

---

## 1. 系统文件组织结构 (System File Organization)

OrangeOS 的代码组织遵循职责分离原则，将引导、内核、系统服务和应用层清晰划分。

### 1.1 目录树状图
```text
OrangeOS/
├── boot/                   # 引导与加载相关
│   ├── include/            # 引导专用头文件 (fat12hdr.inc, load.inc, pm.inc)
│   ├── boot.asm            # MBR 引导扇区 (512B)
│   └── loader.asm          # 内核加载器 (Loader)
├── kernel/                 # 内核核心层 (Ring 0)
│   ├── main.c              # 内核入口、初期进程初始化
│   ├── kernel.asm          # 中断处理入口、低级汇编逻辑
│   ├── proc.c              # 进程调度、IPC (send_recv)、系统调用
│   ├── global.c            # 全局变量定义 (proc_table, task_table)
│   ├── i8259.c             # 中断控制器驱动
│   ├── keyboard.c          # 键盘驱动
│   ├── tty.c               # 终端驱动任务
│   ├── console.c           # 控制台显示管理
│   ├── hd.c                # 硬盘驱动任务
│   ├── clock.c             # 时钟中断处理
│   ├── systask.c           # 系统任务 (获取 tick 等)
│   └── protect.c           # 保护模式初始化 (GDT, IDT)
├── fs/                     # 文件系统服务 (Ring 1)
│   ├── main.c              # FS 任务主循环、硬盘消息处理
│   ├── open.c              # 文件打开、关闭逻辑
│   ├── read_write.c        # 扇区级与文件级读写
│   ├── link.c              # 文件删除 (unlink) 与链接
│   ├── misc.c              # Stat, Search 等辅助功能
│   └── disklog.c           # 磁盘日志记录
├── mm/                     # 内存管理服务 (Ring 1)
│   ├── main.c              # MM 任务主循环、内存分配算法
│   ├── forkexit.c          # Fork, Exit, Wait 逻辑实现
│   └── exec.c              # Exec 逻辑、ELF 解析与重定位
├── lib/                    # 系统库与 API (Ring 3)
│   ├── syscall.asm         # 系统调用汇编接口 (int 0x90)
│   ├── printf.c / vsprintf.c # 格式化输出
│   └── [open, read, write...].c # 系统调用封装函数
├── command/                # 用户态内置命令 (Ring 3)
│   ├── ls.c, cat.c, ...    # 各类 Shell 命令
│   └── Makefile            # 命令编译配置
└── include/                # 系统全局头文件
    ├── sys/                # 内核与服务专用 (config.h, fs.h, proc.h)
    ├── stdio.h             # 标准 I/O 定义
    └── type.h              # 基础数据类型 (u8, u32, MESSAGE)
```

### 1.2 目录用途说明
- **boot/**: 负责从 BIOS 接管控制权，切换至保护模式，并将内核从磁盘加载到内存。
- **kernel/**: 系统心脏。实现微内核的核心机制（调度、中断、消息）。
- **fs/ & mm/**: 运行在 Ring 1 的特权进程，分别管理持久化存储和动态地址空间。
- **lib/**: 为用户程序提供统一的 C 标准库风格接口。
- **command/**: 独立的二进制程序，通过 Shell 动态加载运行。

### 1.3 核心与辅助文件关系
- **核心文件**: `kernel/proc.c`, `fs/main.c`, `mm/main.c`。它们定义了系统的运行骨架。
- **辅助文件**: `lib/` 下的封装函数和 `command/` 下的工具。它们基于核心提供的服务实现具体功能。

---

## 2. 文件间调用关系与接口规范 (Interaction & Interfaces)

OrangeOS 采用微内核通信架构，模块间的交互主要通过消息传递 (IPC) 和系统调用。

### 2.1 模块交互流程图
```text
[用户态命令 (Ring 3)]
      | (调用 API: open, read, wait)
      v
[系统库 (lib/*.c)]
      | (触发中断: int 0x90)
      v
[内核核心 (kernel/proc.c)] <--- [中断处理 (kernel/kernel.asm)]
      | (消息分发: send_recv)
      +-----------------------+-----------------------+
      |                       |                       |
      v                       v                       v
[文件系统 (fs/*.c)]     [内存管理 (mm/*.c)]     [硬盘驱动 (kernel/hd.c)]
      | (磁盘读写)            | (进程控制)            | (端口 I/O)
      +-----------<-----------+-----------<-----------+
```

### 2.2 跨文件调用接口规范
- **系统调用接口**: 用户程序通过 `MESSAGE` 结构体传递参数。例如 `msg.type = OPEN`, `msg.PATHNAME = path`。
- **内核内部调用**: Ring 0 函数（如 `va2la`）直接通过 C 函数指针或符号调用。
- **跨层数据传输**: 必须使用 `phys_copy` 结合 `va2la` 进行。内核作为中介，将源进程的线性地址空间数据复制到目标进程。

### 2.3 异步通信与事件触发机制
- **时钟中断**: 每 10ms 触发一次 `clock_handler`，不仅用于更新 `ticks`，还通过 `inform_int` 唤醒等待任务。
- **消息阻塞**: `send_recv` 的 `RECEIVE` 操作是阻塞的。当进程请求服务时会进入 `SENDING` 或 `RECEIVING` 状态并交出 CPU。
- **硬件通知**: 硬盘中断触发后，`hd_handler` 发送消息唤醒 `TASK_HD`，实现异步 I/O 响应。

### 2.4 `MESSAGE` 结构、字段宏与“接口契约”
OrangeOS 的跨层接口本质上是“约定俗成的消息布局”。同一个 `MESSAGE` 结构，通过不同的字段宏复用为不同系统调用/服务请求的参数载体（见 `include/type.h:54-62` 与 `include/sys/const.h:195-213`）。

#### 2.4.1 结构体：统一消息容器
`MESSAGE` 的核心是 `source/type + union`（`include/type.h:54-62`）：
```c
typedef struct {
    int source;
    int type;
    union {
        struct mess1 m1;
        struct mess2 m2;
        struct mess3 m3;
    } u;
} MESSAGE;
```

#### 2.4.2 字段宏：把 `u.m3` 映射成“系统调用参数”
在 `include/sys/const.h:195-213`，大量宏把 `u.m3` 的成员起了“语义化名字”，形成跨文件的接口规范：
- `FD/FLAGS/NAME_LEN/BUF/CNT/RETVAL/STATUS/...` 等都落在 `u.m3` 的不同槽位。
- 这些宏决定了“谁往哪个字段写什么”，因此它们就是接口契约的一部分。

典型宏摘录（`include/sys/const.h:195-213`）：
```c
#define FD       u.m3.m3i1
#define PATHNAME u.m3.m3p1
#define FLAGS    u.m3.m3i1
#define NAME_LEN u.m3.m3i2
#define CNT      u.m3.m3i2
#define BUF      u.m3.m3p2
#define RETVAL   u.m3.m3i1
#define STATUS   u.m3.m3i1
```

#### 2.4.3 常见“消息接口”示例：从 lib 到 FS/SYS/MM
下面以用户态封装函数为“权威接口定义”，把每类调用的字段写法固定下来：

**A. `open()`：路径 + flags -> 返回 FD**
- 用户态封装：`lib/open.c:33-46`
- 写入字段：`msg.type=OPEN`，`msg.PATHNAME=pathname`，`msg.FLAGS=flags`，`msg.NAME_LEN=strlen(pathname)`
- 交互：`send_recv(BOTH, TASK_FS, &msg)`
- 返回：`msg.FD`（`lib/open.c:46`）

**B. `read()`：fd + buf + count -> 返回 CNT**
- 用户态封装：`lib/read.c:35-46`
- 写入字段：`msg.type=READ`，`msg.FD=fd`，`msg.BUF=buf`，`msg.CNT=count`
- 返回：`msg.CNT`（读到的字节数；`lib/read.c:45`）

**C. `write()`：fd + buf + count -> 返回 CNT**
- 语义与 `read()` 对称，区别在 `msg.type=WRITE`（对应 `include/sys/const.h:173`）
- 返回：`msg.CNT`（写入的字节数）

**D. `unlink()`：路径 -> 返回 RETVAL**
- 用户态封装：`lib/unlink.c:32-42`
- 写入字段：`msg.type=UNLINK`，`msg.PATHNAME=pathname`，`msg.NAME_LEN=strlen(pathname)`
- 返回：`msg.RETVAL`（0 成功，-1 失败；`lib/unlink.c:42`）

**E. `get_ticks()`：向 SYS 请求 ticks**
- 用户态接口：`kernel/main.c:139-145`
- 写入字段：`msg.type=GET_TICKS`，无额外参数
- 返回：`msg.RETVAL`（`kernel/main.c:145`）

**F. `fork()`：无参数 -> 返回子进程 PID**
- 用户态封装：`lib/fork.c:35-45`
- 写入字段：`msg.type=FORK`
- 交互：`send_recv(BOTH, TASK_MM, &msg)`
- 返回：`msg.PID`（父进程中为子 PID；子进程由 MM 主动回包 `RETVAL=0` 走“分叉返回”，见 `mm/forkexit.c:125-130`）

**G. `wait()`：等待子进程 -> 返回 PID 与退出码**
- 用户态封装：`lib/wait.c:32-42`
- 写入字段：`msg.type=WAIT`（用户侧不填写 `STATUS`）
- 交互：`send_recv(BOTH, TASK_MM, &msg)`
- 返回：`msg.PID`（`NO_TASK` 表示无子进程则用户态返回 -1）、`msg.STATUS`（子进程退出码；由 `mm/forkexit.c:223-232` 的 `cleanup()` 写入）

**H. `exit(status)`：终止当前进程 -> 无返回**
- 用户态封装：`lib/exit.c:31-39`
- 写入字段：`msg.type=EXIT`，`msg.STATUS=status`
- 交互：`send_recv(BOTH, TASK_MM, &msg)`
- 返回：无（实现里仅断言 `SYSCALL_RET`，语义上进程应终止）

**I. `logcontrol(what,status,buf)`：扩展系统调用（日志/时间/键盘）**
- 用户态调用点：`command/log.c:16`（读取日志）、`command/dino.c:29/44`（ticks/键盘轮询）
- 交互：`int 0x90` 直接进入 `sys_logcontrol`（`kernel/global.c:55-57` 的系统调用表，处理在 `kernel/proc.c:626-677`）
- 返回：按 `what` 复用：例如 `what=999` 返回写指针位置（供 `log show` 线性化环形缓冲），`what=100` 返回 ticks，`what=200` 返回键盘缓冲中的字符或 0

#### 2.4.4 “指针参数”的边界条件：为何必须 `va2la + phys_copy`
消息里经常携带指针（如 `PATHNAME/BUF`），但它们位于调用者地址空间：
- 在服务进程（FS/MM/SYS）或内核中，直接解引用会读到“别的进程的线性地址”，因此必须做地址转换并由拥有权限的一方执行拷贝。
- 这就是 `va2la()` 与 `phys_copy()` 频繁出现的原因（例如 `kernel/proc.c:292-308`、`fs/read_write.c:106-128`）。

### 2.5 典型跨文件调用链（按“真实路径”串起来）
本节把常见操作按“用户态 -> lib -> 内核 -> 服务进程 -> 设备/数据”的顺序串联，作为阅读代码时的快速索引。

#### 2.5.1 TTY 输入：`read(0,...)` 为什么会阻塞与如何被唤醒
```text
用户进程: read(0, buf, n)
  -> lib/read.c: msg.type=READ, msg.FD=0, msg.BUF=buf, msg.CNT=n
  -> send_recv(BOTH, TASK_FS, &msg)
     -> fs/read_write.c: do_rdwt()
        -> inode 类型是 I_CHAR_SPECIAL (TTY)
        -> 转换为 DEV_READ 消息发给 TTY 驱动任务
           -> kernel/tty.c 收到后，等待键盘输入填充 tty 缓冲
           -> 当满足 read 请求，TTY 发 RESUME_PROC 回到 FS (fs/main.c:67-69)
        -> FS 把 src 改写为真正等待的进程号并回包 SYSCALL_RET
  <- read() 返回实际字节数 msg.CNT
```
边界与语义：
- `read()` 返回时，用户缓冲区内容由 FS 通过 `phys_copy + va2la` 写入（`fs/read_write.c:106-128`）。
- 这条链路解释了“TTY 驱动是异步产生数据，但用户 read 是同步阻塞接口”的实现方式。

#### 2.5.2 程序执行：`execv()` 到 `do_exec()` 的“覆盖自身”语义
```text
用户进程: execv(path, argv)
  -> lib/exec.c: msg.type=EXEC, msg.PATHNAME=path, msg.NAME_LEN=strlen(path)
                msg.BUF=argv_stack, msg.BUF_LEN=argv_stack_len
  -> send_recv(BOTH, TASK_MM, &msg)
     -> mm/exec.c: do_exec()
        -> stat(path) 获取大小 -> open/read 读入 mmbuf
        -> 解析 ELF PHDR，逐段 PT_LOAD phys_copy 到调用者地址空间
        -> 复制参数栈，修正 argv 指针 delta，再写回到新栈位置
        -> 重置 regs.eip/regs.esp 与 argc/argv
  <- execv 返回 0（成功）或 -1（失败）
```
边界与语义：
- `exec` 不创建新进程：PID 不变，地址空间镜像被覆盖（`mm/exec.c:62-106`）。
- 参数栈“指针修正”是必须步骤，否则 `argv` 将指向旧栈地址并崩溃（`mm/exec.c:85-99`）。

#### 2.5.3 进程退出：`exit()`/`wait()` 与 HANGING/WAITING 状态机
```text
child: exit(status)
  -> lib/exit.c: msg.type=EXIT, msg.STATUS=status -> TASK_MM
     -> mm/forkexit.c: do_exit()
        -> 通知 FS 清理 fd (msg2fs.type=EXIT)
        -> free_mem(pid)
        -> 父进程 WAITING? 是则 cleanup(child) 回包并释放槽位；否则 child 标 HANGING

parent: wait(&st)
  -> lib/wait.c: msg.type=WAIT -> TASK_MM
     -> mm/forkexit.c: do_wait()
        -> 若找到 HANGING 子：cleanup(child)（写回 STATUS）并释放槽位
        -> 否则若有子：置父 WAITING；无子：回 NO_TASK
```
边界与语义：
- “僵尸”只保留 `proc_table` 表项以承载 `exit_status`，其余资源已释放（`mm/forkexit.c:163-170` 的术语说明）。
- `kill` 当前绕过这条路径（见 `all.md:8.11` 与 `kernel/systask.c:67-72`），因此与 `exit/wait` 语义不一致。

---

## 3. 系统启动 (System Boot)

系统启动是一个从实模式到保护模式，从汇编到 C 语言的接力过程。

注：本报告的部分子标题沿用了早期草稿的编号习惯，因此在本章下仍可能出现 `1.1/1.2/1.3` 这样的子节编号，这不影响内容的层次关系。

### 1.1 引导扇区 (Boot Sector)
**代码文件**: `boot/boot.asm`

这是系统上电后运行的第一段代码，被 BIOS 加载到内存 `0x7c00`。

```nasm
; boot/boot.asm 核心逻辑

; 1. 初始化段寄存器
mov ax, cs
mov ds, ax
mov es, ax
mov ss, ax
mov sp, BaseOfStack

; 2. 寻找 LOADER.BIN
; OrangeOS 使用 FAT12 文件系统。Boot Sector 需要读取软盘/硬盘的根目录，
; 逐个扇区查找名为 "LOADER  BIN" 的文件。
LABEL_SEARCH_IN_ROOT_DIR_BEGIN:
    ; ... 读取根目录扇区 ...
    cmp cx, 0
    jz  LABEL_FILENAME_FOUND ; 找到文件
    ; ... 继续查找下一个扇区 ...

; 3. 加载 LOADER.BIN 并跳转
; 找到文件后，根据 FAT 表读取文件内容到内存 0x9000:0x0100
jmp BaseOfLoader:OffsetOfLoader ; 移交控制权给 Loader
```

### 1.2 加载器 (Loader)
**代码文件**: `boot/loader.asm`

Loader 的任务是打破实模式的限制（1MB 寻址），为内核准备保护模式环境。

```nasm
; boot/loader.asm 核心逻辑

; 1. 开启地址线 A20
; 实模式下地址回卷，开启 A20 后才能访问 1MB 以上内存
in  al, 92h
or  al, 00000010b
out 92h, al

; 2. 加载 GDT (全局描述符表)
lgdt [GdtPtr]

; 3. 进入保护模式 (Protected Mode)
mov eax, cr0
or  eax, 1      ; 置 CR0 的 PE 位 (Protection Enable)
mov cr0, eax
jmp dword SelectorFlatC:(LOADER_PHY_ADDR+LABEL_PM_START)

; 4. 开启分页 (Paging)
; 建立页目录和页表，将线性地址映射到物理地址。
; OrangeOS 这里的映射是直接映射 (Linear == Physical)，
; 但开启分页是实现多任务虚拟内存的基础。
mov eax, PageDirBase
mov cr3, eax
mov eax, cr0
or  eax, 80000000h ; 置 CR0 的 PG 位
mov cr0, eax

; 5. 加载并重定位内核
; 解析 KERNEL.BIN 的 ELF 头，将代码段和数据段复制到正确的物理地址。
```

### 1.3 内核入口 (Kernel Entry)
**代码文件**: `kernel/kernel.asm`, `kernel/start.c`

内核从汇编入口 `_start` 开始，设置好堆栈后立即跳入 C 语言环境。

```c
// kernel/start.c
PUBLIC void cstart()
{
    // 将 Loader 建立的 GDT/IDT 复制到内核数据区
    // 这样内核就完全接管了系统描述符表
    memcpy(&gdt, ...);
    memcpy(&idt, ...);

    // 初始化中断描述符表 (IDT) 的门描述符
    // 设置异常处理函数 (如除零、页错误)
    init_prot(); 
}
```

---

## 4. 内核核心架构 (Kernel Core)

OrangeOS 采用微内核架构，内核只负责最核心的机制：进程调度、中断处理和 IPC。

### 4.1 进程管理与调度
**代码文件**: `kernel/proc.c`

调度器采用 **优先级 + 老化 (Aging)** 算法，确保高优先级任务响应快，低优先级任务不饥饿。

- **输入**: 全局进程表 `proc_table`。
- **输出**: 更新全局指针 `p_proc_ready`。
- **调度逻辑**:
    1.  **扫描**: 遍历所有进程，寻找处于 `READY` 状态且 `ticks` 最大的进程。
    2.  **老化**: 对所有处于 `READY` 状态但未被选中的进程，若其 `ticks` 小于 `priority * 2`，则 `ticks++`。这保证了即使是低优先级进程，在长时间等待后也会获得执行机会。
    3.  **重置**: 若所有就绪进程的 `ticks` 均为 0，则根据各进程的 `priority` 重新初始化其 `ticks`。
- **边界条件**: 若没有任何用户进程就绪，调度器会停留在内核态或运行 `idle` 任务。

```c
// kernel/proc.c :: schedule()
PUBLIC void schedule()
{
    struct proc* p;
    int greatest_ticks = 0;
    while (!greatest_ticks) {
        for (p = &FIRST_PROC; p <= &LAST_PROC; p++) {
            if (p->p_flags == 0 && p->ticks > greatest_ticks) {
                greatest_ticks = p->ticks;
                p_proc_ready = p;
            }
        }
        if (greatest_ticks > 0) { // Aging logic
            for (p = &FIRST_PROC; p <= &LAST_PROC; p++) {
                if (p->p_flags == 0 && p != p_proc_ready && p->ticks < p->priority * 2)
                    p->ticks++;
            }
        }
        if (!greatest_ticks) // Reset ticks
            for (p = &FIRST_PROC; p <= &LAST_PROC; p++)
                if (p->p_flags == 0) p->ticks = p->priority;
    }
}
```

#### 4.1.1 `ticks` 的来源与“何时会触发调度”
`schedule()` 本身只做“选谁跑”，真正触发它的时机来自时钟中断处理函数 `clock_handler()`：

- **入口**: `kernel/clock.c:32`
- **关键路径**:
  1. 全局 `ticks` 递增（系统时间基准）。
  2. 对当前进程 `p_proc_ready->ticks--`（消耗时间片）。
  3. 若 `k_reenter != 0`（中断重入/在内核栈中），直接返回，避免在不安全时机切换。
  4. 若当前进程仍有 `ticks > 0`，直接返回。
  5. 否则调用 `schedule()` 选择下一个可运行进程。

对应代码片段（`kernel/clock.c:32-53`）：
```c
if (++ticks >= MAX_TICKS) ticks = 0;
if (p_proc_ready->ticks) p_proc_ready->ticks--;
if (k_reenter != 0) return;
if (p_proc_ready->ticks > 0) return;
schedule();
```

#### 4.1.2 `ticks/priority` 的初始化位置
进程的初始 `ticks` 与 `priority` 在进程表初始化阶段设置。`kernel/main.c:106` 有明确赋值：

```c
p->ticks = p->priority = prio;
```

这意味着：
- `priority` 是静态“权重”，用于在时间片耗尽时重置 `ticks`（`kernel/proc.c:78-81`）。
- `ticks` 是动态“余额”，在运行时被 `clock_handler()` 递减，并被 `schedule()` 的 aging 机制上调。

### 4.2 进程间通信 (IPC)
**代码文件**: `kernel/proc.c` :: `sys_sendrec()`

微内核的核心。进程间不通过共享内存交互，而是通过同步的消息传递。

- **接口规范**: `int send_recv(int function, int src_dest, MESSAGE* msg)`。
- **发送逻辑 (SEND)**:
    - 检查目标是否在等待接收。若是，直接调用 `phys_copy` 搬运数据并唤醒目标。
    - 若否，将自己挂入目标的发送队列 `q_sending` 并进入阻塞状态。
- **接收逻辑 (RECEIVE)**:
    - 检查发送队列是否有名单。若有，取出一个进程并拷贝其消息，唤醒该进程。
    - 若否，将自己设为 `RECEIVING` 状态并阻塞。
- **安全性**: 包含死锁预防机制，防止 A 发给 B 且 B 发给 A 导致的永久挂起。

#### 4.2.1 Ring3 `send_recv()` 到 Ring0 `sys_sendrec()` 的参数落点
用户态库通过 `int 0x90` 进入内核（见 `lib/syscall.asm:10-76`），其中：
- `eax` 是系统调用号（`_NR_sendrec = 1`）。
- `ebx/ecx/edx` 分别承载 `function/src_dest/msg`（`lib/syscall.asm:32-36`）。

内核汇编入口 `kernel/kernel.asm:364-391` 做了三件关键事：
1. `call save` 保存现场（并处理 `k_reenter` 与内核栈切换）。
2. 通过 `call [sys_call_table + eax * 4]` 分发到 C 侧系统调用函数（表在 `kernel/global.c:55-57`）。
3. 把返回值写回当前进程栈帧的 `EAXREG`，最终 `iretd` 回到用户态。

#### 4.2.2 `sys_sendrec()`：消息体指针的地址空间转换
`sys_sendrec()` 的第一段是“安全护栏 + 地址转换”（`kernel/proc.c:103-138`）：
- `caller = proc2pid(p)` 获取调用者 PID。
- `mla = (MESSAGE*)va2la(caller, m)` 把调用者虚拟地址 `m` 转换到线性地址，保证内核访问的是正确的进程地址空间。
- `mla->source = caller` 写入消息源，形成统一消息语义。

`va2la()` 的实现（`kernel/proc.c:171-183`）依赖 LDT 段基址：
- 对任务/原生进程（`pid < NR_TASKS + NR_NATIVE_PROCS`），断言 `la == va`，因为它们采用平坦映射。
- 对普通用户进程，线性地址 = 段基址 + 虚拟偏移。

#### 4.2.3 `msg_send()`：直接交付 vs 发送队列
`msg_send()`（`kernel/proc.c:286-349`）分成两条路径：

**A. 目标正在接收（立即交付）**
- 判定条件（`kernel/proc.c:298-300`）：`dest` 处于 `RECEIVING` 且 `recvfrom` 匹配发送者或 `ANY`。
- 数据拷贝（`kernel/proc.c:304-306`）：`phys_copy(va2la(dest, p_dest->p_msg), va2la(sender, m), sizeof(MESSAGE))`
- 解除接收阻塞（`kernel/proc.c:308-310`）：清 `RECEIVING` 标志并 `unblock(dest)`。

**B. 目标未接收（排队阻塞发送者）**
- 设置发送者状态（`kernel/proc.c:322-326`）：`sender->p_flags |= SENDING; sender->p_sendto = dest; sender->p_msg = m;`
- 入队到 `dest->q_sending` 尾部（`kernel/proc.c:328-338`）。
- 调用 `block(sender)`（`kernel/proc.c:340`），其内部直接触发 `schedule()`（`kernel/proc.c:210-214`）。

**死锁检测**
在真正进入发送逻辑前，`deadlock(src, dest)` 会沿着 `p_sendto` 指针追链（`kernel/proc.c:245-270`），一旦发现环（例如 A->B->C->A），立即 `panic`。

#### 4.2.4 `msg_receive()`：中断消息、ANY、指定源
`msg_receive()`（`kernel/proc.c:366-518`）要解决三个问题：从谁收、是否有硬件中断、如何阻塞。

**中断消息优先级**
- `inform_int()`（`kernel/proc.c:528-551`）把“硬件事件”转成进程可见状态：若目标正 `RECEIVING` 且 `recvfrom` 是 `INTERRUPT/ANY`，就直接填充 `HARD_INT` 并唤醒；否则仅设置 `has_int_msg = 1`。
- `msg_receive()` 一进来先检查 `has_int_msg`，并在匹配 `ANY/INTERRUPT` 时构造一个临时 `MESSAGE msg`，再 `phys_copy` 给用户传入的 `m`（`kernel/proc.c:381-405`）。

**从队列选择发送者**
- `src == ANY`：取 `q_sending` 头部作为 `p_from`（`kernel/proc.c:409-427`）。
- `src` 是具体 PID：在 `q_sending` 链表中定位目标发送者（`kernel/proc.c:429-467`），并记录 `prev` 用于摘链（`kernel/proc.c:476-485`）。

**完成拷贝与解阻塞**
- 复制消息（`kernel/proc.c:491-493`），清理发送者状态（`kernel/proc.c:495-498`），`unblock(p_from)`。

**无人发送则阻塞接收者**
- 设置 `RECEIVING`、记录 `p_msg` 与 `p_recvfrom`（`kernel/proc.c:504-508`），然后 `block(p_who_wanna_recv)`。

### 4.3 中断与异常处理
**代码文件**: `kernel/i8259.c`, `kernel/protect.c`

1.  **硬件层**: 8259A 芯片将硬件信号转换为中断向量。
2.  **汇编层**: `kernel.asm` 中的 `hwint00-15` 捕获中断，保存当前寄存器现场（压栈）。
3.  **C 语言层**: 调用对应的 `handler`（如 `clock_handler`）。
4.  **返回**: `restart()` 恢复现场，交回控制权。

### 4.4 系统调用机制 (Syscall Path) 的完整落地
这部分把“用户态函数 -> 中断入口 -> C 侧实现 -> 返回”的链路按文件串起来：

1. **用户态封装（lib）**：`lib/syscall.asm:23-76`
   - 以 `logcontrol(what,status,buf)` 为例：`eax=2`，`ebx/ecx/edx` 携带参数，然后 `int 0x90`。
2. **内核入口（汇编）**：`kernel/kernel.asm:364-391`
   - `call save` 保存现场并处理 `k_reenter`，随后 `call [sys_call_table + eax * 4]` 分发。
3. **系统调用表（C）**：`kernel/global.c:55-57`
   - `sys_call_table = { sys_printx, sys_sendrec, sys_logcontrol }`
4. **具体实现（C）**：
   - `sys_sendrec`：`kernel/proc.c:103-139`
   - `sys_logcontrol`：`kernel/proc.c:626-677`
5. **返回值回写与返回**：`kernel/kernel.asm:388-410`
   - 把 eax 写回进程栈帧，`iretd` 恢复到用户态。

### 4.5 核心文件功能说明（按文件给出 I/O、特殊逻辑与边界）
本节把“核心文件”按目录拆开，给出每个文件在系统链路中的输入/输出、关键函数落点与容易踩的边界条件，便于把目录结构映射到真实运行路径。

#### 4.5.1 `kernel/`（Ring 0 核心机制层）
**`kernel/main.c`**
- **职责**：初始化进程表与 LDT、启动时钟/键盘、由 `Init()` 为多个 TTY 派生 Shell（`kernel/main.c:28-365`）。
- **输入**：`task_table/user_proc_table`（来自 `kernel/global.c`）、GDT/IDT（由 `cstart()` 准备）。
- **输出**：填充 `proc_table[]`、设置 `p_proc_ready`、启动中断驱动与调度循环（`kernel/main.c:42-130`）。
- **特殊逻辑**：`INIT` 进程使用单独的段描述符初始化路径（`kernel/main.c:74-94`）。
- **边界条件**：
  - 只对 `NR_TASKS + NR_NATIVE_PROCS` 范围内的表项做初始化，其余槽位标为 `FREE_SLOT`（`kernel/main.c:42-46`），这是后续 `fork()` 找空槽的基础。
  - `shabby_shell()` 在子进程里直接 `execv(argv[0], argv)`，若可执行文件名不在 FS 里，父进程仅打印 `{cmdline}`（`kernel/main.c:288-315`）。

**`kernel/proc.c`**
- **职责**：调度器、进程切换支撑、IPC 消息传递、系统调用 `sys_sendrec/sys_logcontrol`（多功能扩展）等。
- **输入**：来自用户态/服务层的 `send_recv()` 请求（经 `int 0x90` 进入），以及硬件中断触发的异步通知。
- **输出**：更新 `p_proc_ready`、阻塞/唤醒进程、在不同地址空间之间搬运 `MESSAGE` 与数据块。
- **特殊逻辑**：
  - `deadlock()` 追 `p_sendto` 链检测环并 `panic`（`kernel/proc.c:245-270`），属于“失败即停止”的强一致策略。
  - `inform_int()` 把硬件中断转换成可接收的 `HARD_INT` 语义（`kernel/proc.c:528-551`）。
  - `sys_logcontrol` 将“控制开关/读取/写入/时间/键盘”等需求复用到同一个系统调用号上（见 `all.md:10.1/10.2` 对应实现分析；代码落点 `kernel/proc.c:626-677`）。
- **关键函数与 I/O 约定（按真实签名）**：
   - `schedule(void)`（`kernel/proc.c:51-88`）
     - **输入**：全局 `proc_table[]` 中处于 READY 的条目（`p_flags==0`）与其 `ticks/priority`。
     - **输出**：更新 `p_proc_ready` 指向下一个被调度的进程；可选写入日志（`log_process` 打开且发生切换时）。
     - **边界**：若所有 READY 进程 `ticks==0` 则重置为 `priority`；并对“未被选中”的 READY 进程做 aging（`ticks < priority*2` 时 `ticks++`）。
   - `sys_sendrec(int function, int src_dest, MESSAGE* m, struct proc* p)`（`kernel/proc.c:103-139`）
     - **输入**：`function` 只能是 `SEND/RECEIVE`（`BOTH` 由用户态 `send_recv` 拆解，内核不接受 `BOTH`）；`src_dest` 支持 PID、`ANY`、`INTERRUPT`。
     - **输出**：成功返回 0；错误返回值为 `msg_send/msg_receive` 的错误码；同时会把 `m->source` 写为调用者 PID（`kernel/proc.c:111-115`）。
     - **边界**：要求 `k_reenter==0`（`kernel/proc.c:105`），避免在 Ring0 重入路径上执行会导致不可控的阻塞/调度。
   - `va2la(int pid, void* va)`（`kernel/proc.c:171-183`）
     - **输入**：`pid` 与该进程地址空间内的虚拟地址 `va`。
     - **输出**：对应线性地址（对用户进程为 LDT base + va；对任务/原生进程断言线性=虚拟）。
     - **边界**：任何跨进程指针（例如消息里的 `PATHNAME/BUF`）必须经 `va2la` 才能被内核/服务安全访问（见 `all.md:2.4.4`）。
   - `msg_send(struct proc* current, int dest, MESSAGE* m)`（`kernel/proc.c:286-349`）
     - **输入**：发送者进程结构、目标 pid、消息体指针（位于发送者地址空间）。
     - **输出**：立即交付时执行 `phys_copy` 并唤醒目标；否则把发送者挂入目标 `q_sending` 并阻塞发送者。
     - **边界**：发送前做 `deadlock` 检测；阻塞依赖 `block()` 触发 `schedule()`，因此它是同步 IPC（发送可能导致立刻让出 CPU）。
   - `msg_receive(struct proc* current, int src, MESSAGE* m)`（`kernel/proc.c:366-518`）
     - **输入**：接收者进程结构、指定源 `src`（可为 `ANY/INTERRUPT/具体 pid`）、消息缓冲指针（位于接收者地址空间）。
     - **输出**：若命中中断消息或队列中有发送者，执行 `phys_copy` 将消息拷到接收者缓冲；否则设置 `RECEIVING` 并阻塞。
     - **边界**：函数内部用 `disable_int()/enable_int()` 包裹关键区（`kernel/proc.c:368/516`），避免队列与标志位在中断上下文被破坏。
   - `sys_logcontrol(int what, int status, int buf_ptr, struct proc* p)`（`kernel/proc.c:626-677`）
     - **输入**：`what` 复用为多种子功能；`status` 复用为开关/长度；`buf_ptr` 指向用户缓冲（用户地址空间）。
     - **输出**：
       - `what==100`：返回 `ticks`（`kernel/proc.c:628-630`）。
       - `what==200`：返回非阻塞键值，并清空 `tty->last_key`（`kernel/proc.c:632-637`）。
       - `what==999`：把内核 `logbuf` 拷到用户缓冲并返回 `logbuf_pos`（`kernel/proc.c:639-650`）。
       - `what==888/8882/8884`：把用户缓冲拷到内核并追加到环形日志（`kernel/proc.c:652-667`）。
       - `what==1..4`：切换日志开关，非法返回 -1（`kernel/proc.c:669-675`）。
     - **边界**：
       - 写入日志长度被截断到 256（`kernel/proc.c:657-665`），读取日志大小被截断到 `LOGBUF_SIZE`（`kernel/proc.c:641-643`）。
       - `do_log_syscall()` 会跳过 `printx(0)` 与 `logcontrol(2)`，避免递归记录（`kernel/proc.c:684-689`）。

**`kernel/kernel.asm`**
- **职责**：异常/中断入口、系统调用入口、现场保存与恢复、`k_reenter` 重入处理。
- **输入**：CPU 触发的异常/外设 IRQ/`int 0x90`。
- **输出**：把控制权切换到对应 C 处理函数，并最终 `iretd` 回到被中断上下文。
- **边界条件**：`k_reenter != 0` 时不允许在中断里直接调度（对应 `clock_handler` 的返回条件，见 `all.md:4.1.1`）。

**`kernel/clock.c`**
- **职责**：时钟 IRQ 处理、更新 `ticks`、时间片递减、触发调度（见 `all.md:4.1.1`）。
- **输入**：IRQ0 周期中断。
- **输出**：系统时间基准 `ticks`、在安全点调用 `schedule()`。
- **边界条件**：在重入态或时间片未耗尽时提前返回，避免在不安全栈帧里切换（`all.md:4.1.1` 的 3/4 条）。

**`kernel/tty.c` + `kernel/console.c`**
- **职责**：TTY 任务与控制台显示，承担标准输入输出的“设备抽象”。
- **输入**：键盘扫描码（来自 `kernel/keyboard.c`）与用户进程对 `/dev_tty*` 的 `read/write` 请求（经 FS 转发）。
- **输出**：字符回显到显存、把输入字符投递给等待 `read()` 的进程（通过 `SUSPEND_PROC/RESUME_PROC` 机制，见 `fs/main.c:67-69`）。
- **边界条件**：组合键（如 `Shift+Up/Down`）当前用于滚屏（`all.md:7.3`），与“命令历史”行为存在键位复用冲突，需要在扩展设计中重新分配键位或做模式区分。

**`kernel/hd.c`**
- **职责**：硬盘驱动任务，处理 `DEV_*` 消息并通过端口 I/O 完成扇区读写。
- **输入**：来自 FS 的 `DEV_OPEN/DEV_READ/DEV_WRITE` 请求（`include/sys/const.h:188-193`）。
- **输出**：完成扇区级数据传输，并通过消息回包唤醒请求方，体现异步 I/O（见 `all.md:2.3`）。

**`kernel/systask.c`**
- **职责**：系统服务请求（ticks/pid/rtc/proc_table 查询等）。
- **输入**：用户态/服务层发来的 `GET_*` 与扩展消息（`include/sys/const.h:169-171`）。
- **输出**：`SYSCALL_RET` 回包，并在需要时用 `phys_copy` 把结构体拷贝回调用者（例如 `GET_PROC_INFO`：`kernel/systask.c:60-66`）。
- **边界条件**：`END_WHICH_PROC` 当前实现为直接把 `proc_table[pid].p_flags=FREE_SLOT`（`kernel/systask.c:67-72`），会绕过 MM 的正常退出/回收路径，这一点在 `command.md` 的分析中也被指出，会造成“ps 不显示但进程仍可能在运行”的语义割裂。

#### 4.5.2 `include/`（接口层：类型、常量、原型）
**`include/type.h`**
- **职责**：定义 `u8/u16/u32/u64` 与 `MESSAGE` 结构（`include/type.h:15-62`）。
- **边界条件**：`MESSAGE` 的 union 复用导致字段宏必须一致，否则“写错槽位”会变成难定位的跨进程数据损坏。

**`include/sys/const.h`**
- **职责**：定义进程状态位、任务号、IPC 操作码、消息类型 enum、消息字段宏（`include/sys/const.h:43-213`）。
- **边界条件**：任务号必须与 `kernel/global.c` 的表一致（`include/sys/const.h:132-143`），否则消息会发错目标。
 - **关键常量与“接口契约”细节**：
   - **任务号与特殊源**（`include/sys/const.h:131-143`）：`TASK_TTY/TASK_SYS/TASK_HD/TASK_FS/TASK_MM/INIT` 决定消息投递目标；`ANY/NO_TASK/INTERRUPT` 是协议关键字，不是普通 PID。
   - **进程状态位**（`include/sys/const.h:44-50`）：`SENDING/RECEIVING/WAITING/HANGING/FREE_SLOT` 既是调度条件也是 IPC/回收条件，任何直接改动（例如 `END_WHICH_PROC`）都会影响系统一致性。
   - **消息类型枚举**（`include/sys/const.h:162-193`）：把“系统服务请求”和“驱动请求”放在同一个 enum 中；其中 `DEV_*` 从 1001 起跳，用于与普通系统调用消息区分。
   - **字段宏的槽位复用**（`include/sys/const.h:195-213`）：例如 `FD/FLAGS/RETVAL/STATUS` 都映射到 `u.m3.m3i1`，`NAME_LEN/CNT/PID` 都映射到 `u.m3.m3i2`。这意味着：
     - 同一个 `MESSAGE` 在发起不同类型请求前应 `reset_msg()` 或显式填满所有必需字段，否则旧字段残留会导致“看似随机”的参数污染。
     - 读取返回值也必须按“该类型约定的宏”读，例如 `open()` 返回读 `FD`，`unlink()` 返回读 `RETVAL`，虽然它们实际上是同一个槽位。

---

## 5. 内存管理 (Memory Management)

内存管理 (`Task MM`) 运行在 Ring 1，负责物理内存的动态分配与回收。

### 5.1 内存分配算法 (First-Fit)
**代码文件**: `mm/main.c`

- **数据结构**: `mem_map[]` 数组记录内存块的起始地址、大小和占用 PID。
- **算法细节**:
    - 遍历 `mem_map`，寻找第一个满足 `size >= requested_size` 且 `pid == -1` 的空闲块。
    - **块分裂**: 若找到的块远大于需求，将其拆分为两个块：一个分配给请求者，另一个作为新的空闲块保留。
- **边界处理**: 内存不足时返回错误码，提示进程无法启动或无法扩展堆栈。

#### 5.1.1 `task_mm()` 的消息循环：谁在向 MM 请求什么
MM 作为 Ring1 服务进程运行在一个“收消息 -> 处理 -> 回包”的循环中（`mm/main.c:44-80`）：

```c
send_recv(RECEIVE, ANY, &mm_msg);
switch (mm_msg.type) {
case FORK: mm_msg.RETVAL = do_fork(); break;
case EXIT: do_exit(mm_msg.STATUS); reply = 0; break;
case EXEC: mm_msg.RETVAL = do_exec(); break;
case WAIT: do_wait(); reply = 0; break;
}
if (reply) { mm_msg.type = SYSCALL_RET; send_recv(SEND, src, &mm_msg); }
```

这里有一个实现细节：`EXIT` 和 `WAIT` 这两类消息在部分路径上会“延迟回复”（`reply=0`），因为它们可能需要等待某个条件（父进程等待子进程退出/子进程挂起）才真正完成语义。

#### 5.1.2 `init_mm()`：初始化可用内存区间
`init_mm()`（`mm/main.c:90-109`）通过 `get_boot_params()` 读取引导阶段写入的内存大小，并把 `mem_map[0]` 初始化为“从 `PROCS_BASE` 到内存末尾”的整块空闲区：

- `mem_map[i].pid == -1` 表示空闲
- `mem_map[i].size == 0` 表示该槽位未使用（用于容纳 split 后产生的新块）

#### 5.1.3 `alloc_mem()`：first-fit + split 的精确行为
`alloc_mem(pid, memsize)`（`mm/main.c:122-156`）的关键点不是“找到了就返回”，而是“找到后可能 split，并依赖空槽位”：

- **first-fit**：从低索引到高索引扫描，命中第一块满足的空闲块（`pid==-1 && size>=memsize`）。
- **split 条件**：`mem_map[i].size > memsize` 才尝试分裂（`mm/main.c:132-146`）。
- **split 依赖**：需要找到一个“空槽位”（`size==0 && pid==-1`）来存放剩余空闲块（`mm/main.c:135-142`）。
  - 如果找不到空槽位（`j == NR_MEM_BLOCKS`），则 **不会 split**，而是“整块分配给该 pid”（因为 `mem_map[i].size` 不会被缩小）。
- **失败策略**：这里不是返回 -1，而是直接 `panic("memory allocation failed...")`（`mm/main.c:154`），因此它是“不可恢复错误”。

#### 5.1.4 `free_mem()`：相邻合并的实现方式
`free_mem(pid)`（`mm/main.c:168-207`）做两步：
1. 找到属于该 `pid` 的块，把 `pid` 置回 `-1`（`mm/main.c:172-175`）。
2. 通过双层循环尝试与“相邻空闲块”合并（`mm/main.c:176-201`）：
   - 若 `i` 紧挨 `j`：`base_i + size_i == base_j`，把 `j` 并入 `i`，并清空 `j` 槽位。
   - 若 `j` 紧挨 `i`：`base_j + size_j == base_i`，把 `i` 并入 `j`，并把当前索引 `i` 切换为 `j` 继续尝试。

这种合并策略的直接效果是：释放后尽量恢复大块连续内存，降低后续 split 失败概率（因为 split 需要空槽位）。

### 5.2 进程控制 (Fork & Exec)
**代码文件**: `mm/forkexit.c`, `mm/exec.c`

*   **Fork**: 
    - 复制进程表项。
    - 分配新物理空间，通过 `phys_copy` 克隆父进程的所有数据。
    - 子进程返回 0，父进程返回子进程 PID。
*   **Exec**: 
    - 解析 ELF 文件。
    - 清除旧进程空间，将 ELF 的 `LOAD` 段加载到新分配的地址。
    - 设置初始堆栈，将 `argc` 和 `argv` 压入。

#### 5.2.1 `do_fork()`：为什么要分别处理 LDT 与进程镜像
`do_fork()`（`mm/forkexit.c:34-132`）可拆成 6 个阶段：

1. **找空槽位**：在 `proc_table` 找 `FREE_SLOT`（`forkexit.c:36-48`），决定 `child_pid`。
2. **复制进程表项**：`*p = proc_table[pid]`（`forkexit.c:53`），但要保留子进程原本的 `ldt_sel`（`forkexit.c:52-55`）。
3. **计算父进程镜像大小**：从父进程 LDT 描述符里“重组”出 `T` 与 `D/S` 段 base/limit，并推导 `caller_T_size`（`forkexit.c:61-97`）。
4. **分配子进程物理内存**：`child_base = alloc_mem(child_pid, caller_T_size)`（`forkexit.c:100`）。
5. **拷贝进程镜像**：`phys_copy(child_base, caller_T_base, caller_T_size)`（`forkexit.c:103`），实现“完整克隆”。
6. **重建子进程 LDT**：用 `init_desc()` 把子进程的代码段/数据段段基址改为 `child_base`（`forkexit.c:106-113`），这是子进程能“在自己的地址空间里跑起来”的关键。

另外两条跨服务链路非常重要：
- **通知 FS 复制文件描述符表**：`msg2fs.type=FORK; send_recv(BOTH, TASK_FS, &msg2fs)`（`forkexit.c:115-120`）。
- **唤醒子进程返回 0**：给 `child_pid` 发送 `SYSCALL_RET` 且 `RETVAL=0`（`forkexit.c:125-130`）。

#### 5.2.2 `do_exit()`/`do_wait()`：僵尸进程状态机落在 `p_flags`
`do_exit(status)`（`mm/forkexit.c:175-211`）把 POSIX 的“父进程回收子进程”语义映射到 `proc_table[].p_flags`：

- **先通知 FS 清理 fd 资源**：`msg2fs.type=EXIT`（`forkexit.c:182-187`）。
- **释放地址空间**：`free_mem(pid)`（`forkexit.c:188`）。
- **记录退出码**：`p->exit_status = status`（`forkexit.c:190`）。
- **父进程是否 WAITING**：
  - 若父进程在等待：清 WAITING，并 `cleanup(child)` 立即回包父进程并释放子进程槽位（`forkexit.c:192-195`）。
  - 否则：子进程打上 `HANGING` 标志，成为僵尸（`forkexit.c:197-198`）。
- **过继机制**：遍历所有进程，把子进程的孩子改由 `INIT` 领养；若 `INIT` 正 WAITING 且该孩子已 HANGING，则立即 `cleanup()`（`forkexit.c:200-210`）。

`do_wait()`（`mm/forkexit.c:253-281`）则反向实现父进程侧逻辑：
- 扫描 `proc_table` 找孩子（`forkexit.c:260-268`）。
- 若发现孩子 HANGING：直接 `cleanup(child)` 产生回包并释放槽位。
- 若有孩子但都未退出：设置父进程 `WAITING`。
- 若压根没有孩子：发送 `PID=NO_TASK` 的 `SYSCALL_RET`（`forkexit.c:274-280`）。

#### 5.2.3 `do_exec()`：ELF 加载 + 参数栈搬运（delta 修正）
`do_exec()`（`mm/exec.c:33-110`）的关键点在“参数栈指针修正”：

1. **复制 pathname**：从调用者地址空间拷到 MM 本地（`exec.c:40-45`）。
2. **读入 ELF 到 `mmbuf`**：`stat` 获取大小、`open/read/close`（`exec.c:47-60`）。
3. **加载 PT_LOAD 段**：遍历 program header，把文件段拷到调用者空间的 `p_vaddr`（`exec.c:65-76`）。
4. **搬运参数栈**：
   - `stackcopy[]` 先复制调用者原始参数块（`exec.c:79-84`）。
   - 计算 `orig_stack` 在新镜像中的位置：`PROC_IMAGE_SIZE_DEFAULT - PROC_ORIGIN_STACK`（`exec.c:85`）。
   - 计算 `delta = orig_stack - mm_msg.BUF`（`exec.c:87`），并把 `stackcopy` 里保存的 `argv[]` 指针逐个加上 `delta`（`exec.c:89-94`）。
   - 再把修正后的参数块拷回调用者 `orig_stack`（`exec.c:96-99`）。
5. **设置寄存器**：
   - `ecx=argc`、`eax=argv`（`exec.c:100-101`）
   - `eip = elf_hdr->e_entry`、`esp = ...`（`exec.c:104-105`）

因此 `exec` 的本质是：不创建新进程，而是在**同一个 PID 的地址空间里覆盖代码段/数据段**，并重置入口与栈。

### 5.3 MM 核心文件功能说明（输入/输出与关键边界）
#### 5.3.1 `mm/main.c`：MM 的消息分发与内存块管理
- **职责**：作为 Ring1 服务进程运行 `task_mm()` 消息循环（`all.md:5.1.1`），并维护 `mem_map[]` 实现 first-fit 分配与合并释放（`all.md:5.1.3-5.1.4`）。
- **输入**：来自内核转发的 `FORK/EXEC/EXIT/WAIT` 消息（`include/sys/const.h:179-183`）。
- **输出**：通过 `SYSCALL_RET` 回包，向调用者返回 `RETVAL/PID/STATUS` 等字段；在不可恢复错误时 `panic`（例如分配失败 `mm/main.c:154`）。
- **接口约定（按消息字段）**：
  - `source`：内核写入的发起者 PID（调用 `send_recv(BOTH, TASK_MM, ...)` 的用户进程或服务进程）。
  - `FORK`：回包写入 `mm_msg.PID = child_pid`（`lib/fork.c:44` 的返回值来源）。
  - `EXEC`：回包写入 `mm_msg.RETVAL`（用户态 `execv` 以此判断成功/失败）。
  - `EXIT`：用户态发送 `STATUS`（退出码），MM 内部通过 `cleanup()` 把退出码写回给父进程的 `STATUS` 字段（`mm/forkexit.c:223-232`）。
  - `WAIT`：回包写入 `PID/STATUS`，其中 `PID=NO_TASK` 表示“没有子进程可等待”（`mm/forkexit.c:274-280`，用户态据此返回 -1：`lib/wait.c:41-42`）。
- **边界条件**：
  - `alloc_mem` 的 split 依赖“空槽位”（`mem_map[j].size==0`），否则会整块分配导致内部碎片（`all.md:5.1.3`）。
  - 分配失败直接 `panic`，意味着在该实现里“内存不足”不是可恢复错误，会终止系统的继续运行语义。
  - `task_mm()` 仅对已知 `msg.type` 分支处理，未知类型会 `assert(0)`（`mm/main.c:70-73`），因此“发错消息类型”会直接把 MM 拉入不可恢复状态。

#### 5.3.2 `mm/forkexit.c`：fork/exit/wait 的资源回收与状态机
- **职责**：实现 `do_fork/do_exit/do_wait`，并把 POSIX 风格语义投影到 `proc_table[].p_flags`（`all.md:5.2.1-5.2.2`）。
- **输入**：`FORK/EXIT/WAIT` 消息中的 `source/STATUS` 等字段。
- **输出**：
  - fork：为子进程分配物理空间、克隆镜像、重建 LDT，并回包父子不同返回值（`all.md:5.2.1`）。
  - exit/wait：回收内存、维护 HANGING/WAITING 状态，并通过 `cleanup()` 最终释放进程槽位。
- **特殊逻辑**：与 FS 的联动通过 `FORK/EXIT` 消息完成 fd 状态复制/释放（`all.md:5.2.1` 的“通知 FS”与 `all.md:5.2.2` 的“通知 FS 清理”）。
- **边界条件**：若父进程未 wait，子进程会进入 HANGING（僵尸）；只有父进程 wait 或 INIT 领养回收后，槽位才会被真正释放。
- **状态机落点（便于对照 `ps` 输出）**：
  - `WAITING`：父进程在 `do_wait()` 中被置位（`mm/forkexit.c:270-273`），等待任一子进程进入 HANGING。
  - `HANGING`：子进程在 `do_exit()` 中被置位（`mm/forkexit.c:197-198`），等待父进程或 INIT 回收。
  - `FREE_SLOT`：最终由 `cleanup()` 写入（`mm/forkexit.c:231-232`），表示进程槽位真正释放。

#### 5.3.3 `mm/exec.c`：ELF 装载与 argv 指针修正
- **职责**：解析 ELF、把 `PT_LOAD` 段拷入目标地址空间，并重置入口点与用户栈（`all.md:5.2.3`）。
- **输入**：调用者传来的 `pathname` 指针与参数块 `BUF` 指针（来自系统调用消息）。
- **输出**：写回调用者的 `regs.eip/regs.esp/regs.eax/regs.ecx` 等寄存器值（通过消息回包语义）。
- **边界条件**：
  - `NAME_LEN < MAX_PATH` 是硬断言（`mm/exec.c:38`），超长路径会触发 assert。
  - 通过 `stat()` 获取文件大小后断言 `st_size < MMBUF_SIZE`（`mm/exec.c:58`），因此可执行文件必须小于 `MMBUF_SIZE` 上限，否则系统走不可恢复路径。
  - 加载 `PT_LOAD` 段时断言 `p_vaddr + p_memsz < PROC_IMAGE_SIZE_DEFAULT`（`mm/exec.c:69-70`），避免覆盖越界。
  - 必须对参数栈中的 `argv[]` 指针做 delta 修正，否则 `exec` 后 `argv` 会指向旧栈空间导致崩溃（`mm/exec.c:85-99`）。
  - `strcpy(proc_table[src].name, pathname)` 存在潜在溢出风险（`mm/exec.c:107`）：`proc_table[].name` 是定长数组，pathname 过长时会破坏相邻表项；该现象在 `command.md:62-105` 的 `ps` 异常分析中有对应复盘。

---

## 6. 文件系统 (File System)

文件系统 (`Task FS`) 负责管理磁盘上的数据组织与访问。

### 6.0 `task_fs()`：FS 的消息分发与设备层交互
**代码文件**: `fs/main.c`

FS 是典型的 Ring1 服务进程：`send_recv(RECEIVE, ANY, &fs_msg)` 收消息，然后按 `fs_msg.type` 分发到具体 `do_*()`（`fs/main.c:46-86`）。

**消息分发（核心 switch）**
- `OPEN` -> `do_open()`（`fs/main.c:54-56`）
- `CLOSE` -> `do_close()`（`fs/main.c:57-59`）
- `READ/WRITE` -> `do_rdwt()`（`fs/main.c:60-63`）
- `UNLINK` -> `do_unlink()`（`fs/main.c:64-66`）
- `STAT` -> `do_stat()`（`fs/main.c:79-81`）
- `FORK/EXIT` -> `fs_fork()/fs_exit()`（`fs/main.c:70-75`，用于配合 MM 维护进程 fd 状态）
- `RESUME_PROC`：这是 TTY 驱动完成输入后“恢复被挂起进程”的回调消息，FS 将 `src` 改成 `PROC_NR`，随后统一回包（`fs/main.c:67-69`）。

**初始化阶段**
`init_fs()`（`fs/main.c:136-170`）做了 4 类初始化：
1. 清空 `f_desc_table[]`（进程级 fd 关联的全局文件描述符表）。
2. 清空 `inode_table[]`（内存 inode 缓存）。
3. 初始化 `super_block[]`（内存 superblock 缓存）。
4. 打开 ROOT 设备（向 `TASK_HD` 发送 `DEV_OPEN`，`fs/main.c:154-159`），随后 `mkfs()` 在磁盘上写入 superblock、位图、根目录等结构（`fs/main.c:160-164`）。

### 6.1 文件读写与安全
**代码文件**: `fs/read_write.c` :: `do_rdwt()`

- **输入**: 消息中包含 `FD` (文件描述符), `BUF` (用户缓冲区), `LEN` (字节数)。
- **逻辑流程**:
    1.  **映射转换**: 将文件内的逻辑偏移转换为磁盘物理扇区号。
    2.  **边界检查**: 防止读取超出文件大小 `i_size` 的部分。
    3.  **缓冲区中转**: 使用 `fsbuf` 作为内核与驱动间的中转站。
- **接口**: 最终调用 `TASK_HD` 的 `DEV_READ/WRITE` 消息实现。

#### 6.1.1 `do_rdwt()` 的两条分支：字符设备 vs 普通文件
`do_rdwt()`（`fs/read_write.c:36-143`）会先通过 `pin->i_mode & I_TYPE_MASK` 判断 inode 类型（`read_write.c:64-66`）：

**A. 字符设备（`I_CHAR_SPECIAL`）**
这条路径把 `READ/WRITE` 转换成驱动消息 `DEV_READ/DEV_WRITE`（`read_write.c:66-82`）：
- `dev = pin->i_start_sect` 作为设备号承载处（TTY 设备在这里复用 inode 字段）。
- `MAJOR(dev)==4` 断言设备是 TTY（`read_write.c:71-72`）。
- 通过 `dd_map[MAJOR(dev)].driver_nr` 找到驱动任务号（`kernel/global.c:67-76`），然后 `send_recv(BOTH, driver, &fs_msg)` 让驱动完成实际 I/O。

这一分支的含义是：**open/read/write 在用户态看起来是文件操作，但在内核里会变成“向驱动任务发消息”。**

**B. 普通文件/目录（`I_REGULAR/I_DIRECTORY`）**
这条路径需要完成“文件偏移 -> 扇区范围 -> 分块读写 -> 拷贝到用户缓冲区”的完整流程（`read_write.c:83-143`）。

#### 6.1.2 边界与扇区计算：`pos_end/rw_sect_min/rw_sect_max/chunk`
普通文件读写的关键变量都在 `read_write.c:87-99`：

- `pos`：当前 fd 的文件偏移（`pcaller->filp[fd]->fd_pos`，`read_write.c:58`）。
- `pos_end`：
  - READ：`min(pos + len, pin->i_size)`，禁止越界读取（`read_write.c:88-90`）。
  - WRITE：`min(pos + len, pin->i_nr_sects * SECTOR_SIZE)`，禁止写过预分配扇区数量（`read_write.c:90-92`）。
- `off = pos % SECTOR_SIZE`：第一次读写可能从扇区中间开始（`read_write.c:93`）。
- `rw_sect_min/max`：把文件偏移换算为扇区号（`read_write.c:94-96`）。
- `chunk`：每次读写最多处理 `FSBUF_SIZE` 能容纳的扇区数（`read_write.c:97-99`），避免一次请求太大导致缓冲溢出。

#### 6.1.3 真正的数据搬运点：`rw_sector` + `phys_copy`
循环体（`read_write.c:103-133`）每次会先把扇区读入 `fsbuf`，再决定是“从 fsbuf 拷到用户”还是“从用户拷到 fsbuf 再写回磁盘”：

- READ：`rw_sector(DEV_READ, ...)` -> `phys_copy(va2la(src, buf+bytes_rw), va2la(TASK_FS, fsbuf+off), bytes)`（`read_write.c:106-117`）。
- WRITE：`phys_copy(va2la(TASK_FS, fsbuf+off), va2la(src, buf+bytes_rw), bytes)` -> `rw_sector(DEV_WRITE, ...)`（`read_write.c:118-128`）。

最后如果写入导致 `fd_pos > i_size`，就更新 inode 大小并 `sync_inode(pin)` 落盘（`read_write.c:135-140`）。

### 6.2 安全删除机制
**代码文件**: `fs/link.c` :: `do_unlink()`

#### 6.2.1 当前实现的真实语义：释放元数据（可恢复数据）
`do_unlink()` 的文件头注释明确指出：**当前实现不会清空数据区，因此理论上可恢复**（`fs/link.c:30-32`）。

实现上它做了 4 类“元数据回收”（`fs/link.c:35-210`）：
1. **参数与合法性检查**
   - 不能删除根目录 `/`（`link.c:48-51`）。
   - 找不到 inode 则返回失败（`link.c:53-58`）。
   - 只允许删除普通文件（`I_REGULAR`），目录等类型直接拒绝（`link.c:67-72`）。
   - 若 `pin->i_cnt > 1`（仍被打开），拒绝删除（`link.c:74-78`）。
2. **清 inode 位图（imap）**
   - 计算 `byte_idx/bit_idx`，读扇区 2，清位后写回（`link.c:85-93`）。
3. **清扇区位图（smap）**
   - 从 `pin->i_start_sect` 推导位图中的起始 bit（`link.c:109-149`），按“首字节/中间整字节/尾字节”三段清零，逐扇区读写位图。
4. **清 inode 与目录项**
   - 把 inode 的 mode/size/start_sect/nr_sects 清 0 并 `sync_inode()`（`link.c:154-160`）。
   - 在父目录数据块中找到对应 `dir_entry` 并 `memset(pde,0,DIR_ENTRY_SIZE)`（`link.c:178-202`）；如果删的是目录最后一个条目，还会压缩 `dir_inode->i_size`（`link.c:204-207`）。

#### 6.2.2 若需要“物理擦除”：应加在哪一段
若希望实现“不可恢复删除”，最直接的位置是在 **清 s-map 之后、清 inode 之前**：
- 已知 `pin->i_start_sect` 与 `pin->i_nr_sects`，可以循环把对应数据扇区写 0（复用 `WR_SECT` 和 `fsbuf`）。
- 当前代码没有这段逻辑，因此文档层面必须把“安全删除”理解为“安全释放元数据 + 防止错误删除”，而不是“覆写数据区”。

### 6.3 FS 核心文件功能说明（按文件给出 I/O 与边界）
#### 6.3.1 `fs/main.c`：FS 任务框架、初始化与消息回包
- **职责**：作为 Ring1 服务进程运行 `task_fs()`，按 `fs_msg.type` 分发到 `do_open/do_close/do_rdwt/do_unlink/do_stat` 等（`all.md:6.0`）。
- **输入**：来自用户态系统调用封装的 `OPEN/CLOSE/READ/WRITE/UNLINK/STAT` 消息，以及来自 TTY 的 `RESUME_PROC`（`fs/main.c:67-69`）。
- **输出**：统一设置 `msg.type=SYSCALL_RET` 并回包；必要时将 `src` 改写为 `PROC_NR`（TTY 恢复路径），保证回复给真正阻塞在 `read()` 的进程。
- **边界条件**：
  - FS 需要在初始化时向 `TASK_HD` 发送 `DEV_OPEN` 并 `mkfs()` 建立元数据（`all.md:6.0`），否则后续 open/read 都没有可用的超级块与位图。

#### 6.3.2 `fs/open.c`：`do_open()` 的路径解析、创建与 fd 分配
- **职责**：实现 `OPEN` 的服务端逻辑：解析路径、查找/创建 inode，并分配进程 fd 与全局 `f_desc_table` 项。
- **输入**：`PATHNAME/FLAGS/NAME_LEN`（见 `lib/open.c:37-46` 与 `include/sys/const.h:197-200`）。
- **输出**：回包 `msg.FD` 作为用户态 `open()` 返回值。
- **边界条件**：
  - `PATHNAME` 是调用者地址空间指针，服务端必须做拷贝才能安全解析，否则会受到调用者栈/缓冲区生命周期影响（参见 `all.md:2.4.4` 与 `command.md:49-51` 对 unlink 卡死的分析）。

#### 6.3.3 `fs/read_write.c`：`do_rdwt()` 的扇区映射与越界保护
- **职责**：把文件级 `READ/WRITE` 变换成扇区级 `DEV_READ/DEV_WRITE`，并在 `fsbuf` 中转后以 `phys_copy` 搬运数据（`all.md:6.1.1-6.1.3`）。
- **输入**：`FD/BUF/CNT`（`lib/read.c:38-46`）。
- **输出**：回包 `msg.CNT` 作为读写字节数。
- **边界条件**：
  - READ：强制 `pos_end <= i_size`（`all.md:6.1.2`），保证不会读取越过文件尾的垃圾数据。
  - WRITE：强制 `pos_end <= i_nr_sects * SECTOR_SIZE`（`all.md:6.1.2`），保证不会写越过预分配扇区，避免破坏相邻 inode/目录数据。
  - 每次 chunk 不超过 `FSBUF_SIZE` 可容纳的扇区数，防止 FS 缓冲溢出（`all.md:6.1.2`）。

#### 6.3.4 `fs/link.c`：`do_unlink()` 的元数据回收（非物理擦除）
- **职责**：实现删除语义：回收 inode 位图、扇区位图、inode 与目录项（`all.md:6.2.1`）。
- **输入**：`PATHNAME/NAME_LEN`（`lib/unlink.c:35-42`）。
- **输出**：回包 `msg.RETVAL` 表示成功/失败。
- **边界条件**：
  - 拒绝删除 `/`、拒绝删除非普通文件、拒绝删除仍被打开的文件（`all.md:6.2.1` 的检查条目），这些都是“保护性边界”。

#### 6.3.5 `fs/misc.c` 与 `fs/disklog.c`：辅助查询与日志
- **`misc.c`**：承担 `STAT`、目录查询等辅助能力，使得用户态命令（如 `ls`）能通过 `stat()` 获得 `st_mode/st_size`（`command/ls.c:110-134`）。
- **`disklog.c`**：用于记录磁盘访问日志/恢复相关辅助逻辑，配合扩展日志系统时可作为“FS 侧探针”的天然落点（与 `all.md:10.1` 的 FILE/DEVICE 日志链路相呼应）。

---

## 7. Shell 实现机制 (Shell Implementation)

`shabby_shell` 是用户交互的入口。

### 7.1 命令解析流程
1.  **读取输入**: `read(0, rdbuf, 70)` 阻塞等待用户在控制台输入。
2.  **令牌化**: 
    - 使用循环扫描 `rdbuf`，识别空格并将各段字符串地址存入 `argv[]`。
    - 将字符串末尾的空格替换为 `\0` 以截断。
3.  **并发处理**: 检查 `argv` 最后一个参数是否为 `&`。若是，则 `background = 1`，父进程（Shell）不调用 `wait()` 而是立即循环等待下一条输入。

#### 7.1.1 输入与分词：`rdbuf` 就地切分的细节
`shabby_shell()` 位于 `kernel/main.c:235-320`，它的“分词器”没有额外分配内存，而是直接在 `rdbuf` 上原地改写：

- 用 `word` 标志表示“是否正在一个 token 内部”（`kernel/main.c:259-270`）。
- 当从“非空白”进入 token 时，记录 token 起始指针 `s = p`。
- 当遇到空格/换行/结尾且 `word==1`，把当前位置写成 `0` 作为字符串结束符，并把 `s` 放入 `argv[argc++]`。

因此 `argv[]` 里的每个字符串都指向 `rdbuf` 的某个位置，生命周期仅限本次循环。

#### 7.1.2 前台/后台：`&` 的真实语义
后台执行的实现很直接（`kernel/main.c:276-310`）：
- 如果最后一个 token 是 `"&"`，就把它从参数列表删除（`argv[--argc]=0`），并设置 `background=1`。
- 父进程（Shell）只在 `background==0` 时调用 `wait(&s)`；否则直接打印提示并继续读取下一条命令。

注意：这里打印的 `pid` 是 `fork()` 在父进程中的返回值（子进程 PID），用于提示后台任务编号（`kernel/main.c:306-308`）。

#### 7.1.3 命令查找与执行：用 `open()` 探测可执行文件存在
执行路径（`kernel/main.c:288-315`）：
1. `open(argv[0], O_RDWR)` 用作“是否存在该命令文件”的探测；失败则打印 `{cmdline}`。
2. 成功后立即 `close(fd)`，随后 `fork()`：
   - 父进程：前台等待或后台提示。
   - 子进程：`execv(argv[0], argv)` 用新镜像覆盖自身。

这解释了为什么 `command/` 下的命令是独立文件：Shell 不是内置解释器，而是“按名字打开并 exec”。

#### 7.1.4 错误处理与边界条件：从“探测 open”到 `fork/exec` 的失败路径
现状代码的错误处理非常精简，但从系统行为角度，仍有若干必须在架构文档中明确的边界：
1. **输入长度边界**：`read(0, rdbuf, 70)`（`kernel/main.c:247-248`）意味着单次命令行最多 70 字节；超出部分要么留在 TTY 行编辑缓冲等待下次读，要么被用户交互层截断，Shell 侧不做拼接。
2. **参数个数边界**：`argv` 是固定数组（`char* argv[PROC_ORIGIN_STACK]`，`kernel/main.c:253`），因此 token 数有上限；超出会发生越界写入风险。文档层面应把“命令参数个数上限”视为系统约束的一部分。
3. **命令存在性探测的语义偏差**：使用 `open(path, O_RDWR)` 探测“是否存在”在语义上并不等价于“可执行”，它还隐含了“可读写打开”的要求。若某文件允许读但不允许写（或未来引入权限位），`O_RDWR` 可能导致“存在但被误判为不存在”。更稳妥的探测应是 `O_RDONLY` 或直接尝试 `execv()` 并根据返回值报错（这里只做文档说明，不改代码）。
4. **`fork()` 失败路径**：若进程表耗尽或 MM 分配失败，`fork()` 可能返回 -1。现状 Shell 未对 -1 做明确分支，会导致父子逻辑混淆；文档应把它列为“需补强的错误处理点”。
5. **`execv()` 失败路径**：`execv` 失败时子进程应打印错误并 `exit()`，否则会回到子进程内的 Shell 分支继续循环，形成“两个 Shell 同时读同一 TTY”的竞争读问题。现状代码没有显式处理，属于潜在一致性问题。

#### 7.1.5 从命令行到命令 `main()`：端到端控制流
把 `shabby_shell()` 的“分词 + fork/exec + wait”与内核服务链路拼在一起，可以得到一个更贴近真实系统的流程图：
```text
TTY 驱动收键盘 -> 行编辑 -> read(0,rdbuf,70) 返回
  -> shabby_shell 原地分词 rdbuf -> argv[]
  -> (可选) 解析 & / 重定向 / 管道 / 变量展开（均发生在 fork 前）
  -> open(argv[0],O_RDWR) 探测可执行文件存在性
  -> fork()
     -> parent:
          if foreground: wait(&status)  // 等子进程退出并回收
          if background: 立即回到 "$ " 提示符
     -> child:
          (可选) close/open 绑定 0/1/2 做重定向
          execv(path, argv)
             -> lib/exec.c: send_recv(BOTH,TASK_MM,&msg)  // EXEC 消息
             -> mm/exec.c: do_exec() 装载 ELF + 修正 argv 指针
             -> 返回后开始执行命令程序 start.asm -> main(argc,argv)
```
这个图有两个“跨特权级边界”：
- Shell/命令处于 Ring3，`execv/wait/open/read` 是用户态封装（`lib/*.c`），通过 `int 0x90` 进入内核。
- MM/FS 处于 Ring1，真正的装载与文件解析分别发生在 `mm/exec.c` 与 `fs/*.c`。

### 7.2 管道与重定向 (Design Specification)
当前 `shabby_shell()` 的代码并未解析 `|` 或 `>`，因此这部分属于“扩展设计落点”，可用于指导后续实现。

- **输出重定向 (`>`)**: 
    - Shell 在 fork 之后，exec 之前，关闭 FD 1，然后 `open` 目标文件。
    - 这样命令的所有 `printf` (即 `write(1, ...)` ) 都会写入该文件。
- **管道 (`|`)**: 
    - 实现为进程间的生产者-消费者模型。
    - Shell 创建两个子进程，通过文件系统中的临时文件作为“管道”中转数据。

### 7.3 命令历史记录
- 当前仓库代码中 `shabby_shell()` 未维护历史缓冲区，也未在 `kernel/tty.c:161-207` 对 Up/Down 做历史回填（Up/Down 当前仅用于 Shift+Up/Down 的滚屏）。
- 若要按现有结构加入历史功能，最自然的切入点是：
  1. 在 `shabby_shell()` 每次成功解析出 `argc>0` 后，把本次命令行复制进一个固定大小环形数组。
  2. 在 TTY 层 `in_process()` 捕获 Up/Down 并把“选择的历史命令字符串”注入 tty 输入缓冲（`put_key()`），从而复用 `read()` 读取路径。

#### 7.3.1 历史数据结构：环形缓冲 + 索引游标
在“只允许 Shell 内存内实现、不新增系统调用”的约束下，历史应完全由 Shell 维护：
```text
HIST_MAX = 16                 # 最多存 16 条
HIST_LINE_MAX = 80            # 单条最大长度（可取 >= 70 以覆盖 rdbuf）
history[HIST_MAX][HIST_LINE_MAX]
hist_count  # 当前已有条数（<=HIST_MAX）
hist_head   # 下一次写入位置（0..HIST_MAX-1）
hist_cursor # 用于 Up/Down 浏览的“当前选中条目”游标（可为 -1 表示未在浏览）
```
写入策略（插入一条新命令）：
- 仅在 `argc>0` 且命令不是空行时写入。
- 可选去重：若与上一条完全相同则不重复写入（避免连续 Enter 产生大量重复项）。
- `hist_head=(hist_head+1)%HIST_MAX` 形成环形覆盖，始终保留最近的命令。

#### 7.3.2 输入回填：为何应在 TTY 层做“注入式回显”
Shell 当前只能拿到 `read()` 完成后的整行字符串；要实现“按 Up/Down 就能看到上一条命令出现在输入行”，需要在行编辑阶段就改变 tty 输入缓冲。

按现有架构，最贴合的方案是：
- 在 `kernel/tty.c` 的按键处理入口（常见为 `in_process()`）捕获 Up/Down。
- 通过向 tty 的输入队列“重新注入字符”来重放一条历史命令：先注入若干退格清空当前行，再逐字符注入历史命令，再注入一个“不回车”的结束状态。

这种方案的优势是：
- 不需要改 `read()` 的语义，Shell 仍旧只负责读一行。
- 行内编辑（退格、左右移动若存在）可以复用 TTY 已有逻辑。

#### 7.3.3 键位冲突与边界
- 当前实现把 `Shift+Up/Down` 用于滚屏（`all.md:4.5.1`），因此“历史浏览”最好使用“无 Shift 的 Up/Down”，并保留 Shift 作为滚屏。
- 受 `read(0,rdbuf,70)` 限制，即使历史中存了更长命令，回填后也只能被读到前 70 字节；因此建议 `HIST_LINE_MAX` 不小于 70，但回填时应截断到 70。
- 历史只对当前 tty 的 Shell 生效；多控制台下每个 tty 的 Shell 应有各自的历史环（避免交叉污染）。

#### 7.3.4 后台任务与回收：为何当前 `&` 会产生“可见的僵尸槽位”
当前 Shell 对 `&` 的语义仅是“父进程不 wait”（`all.md:7.1.2`）。结合 MM 的 `HANGING/WAITING` 机制（`all.md:2.5.3`），可以推导出一个重要结论：
- 对于后台进程：父进程（Shell）不调用 `wait()`，那么子进程退出后会在 MM 中被标记为 `HANGING`，并持续占用 `proc_table` 槽位，直到其父进程某次调用 `wait()` 触发 `cleanup()`（`mm/forkexit.c:223-232`）或父进程本身退出（子进程被 INIT 接管后由 INIT 回收）。

因此，在“无信号/无 NOHANG”的接口集合下，后台作业在实现层面必须额外定义一种回收策略，否则会出现：
- 多次后台启动后 `proc_table` 被 `HANGING` 进程占满，`fork()` 失败，Shell 无法再启动新命令。

在不新增系统调用的前提下，文档层面可以给出两种“可落地”的策略作为后续实现指引：
1. **内置 `reap` 命令**：用户手动触发 Shell 反复调用 `wait(&st)` 回收所有已挂起子进程，直到返回 -1（`NO_TASK`）。
2. **前台命令后顺带回收**：每次前台 `wait()` 返回后，再额外循环调用一次 `wait()` 尝试多回收一个（或多个）已经 HANGING 的后台子进程；这种做法不需要 NOHANG，但会在“没有已退出后台子进程时”阻塞，因此必须只在确认存在 HANGING 子进程时调用（需要借助 `ps` 或 `GET_PROC_INFO` 能力，见 `command/ps.c` 的实现链路）。

### 7.4 环境变量处理机制（现状与扩展落点）
当前仓库的 `shabby_shell()` 并没有实现环境变量表，也没有 `export/unset` 之类的内置命令：命令执行时仅把 `argv[]` 传给 `execv()`（`kernel/main.c:311-314`），因此“环境变量”在现状中等价于“未实现”。

在不改动内核系统调用集合的前提下，最贴合当前结构的扩展方案是把环境变量视为“Shell 进程的用户态数据结构”，并通过两类途径对外生效：
- **命令行替换（变量展开）**：在分词后、fork 前对 token 进行 `$NAME` 替换，替换来源为 `ShellEnv[]`。
- **对命令生效的方式**：
  - **方式 1（最小侵入）**：仅做变量展开，不做“子进程继承环境”。例如 `echo $PWD` 展开为 `echo /`，子进程无需额外协议。
  - **方式 2（拟真继承）**：在 `execv` 前把 `KEY=VALUE` 形式的字符串追加到 `argv` 的尾部，并约定命令程序识别这些附加参数（这要求修改各命令，不符合“仅改 all.md”的约束，因此这里只作为设计说明）。

建议最小可用语义（不需要新增系统调用）：
```text
set NAME VALUE      # Shell 内置：写入/覆盖变量
unset NAME          # Shell 内置：删除变量
env                 # Shell 内置：列出变量
echo $NAME          # 变量展开：把 token 中的 $NAME 替换为 VALUE
```
边界与约束（与现有分词器一致）：
- 不支持引号与转义，因此 `VALUE` 里若包含空格会被拆成多个 token（`kernel/main.c:261-273`）。
- 展开在就地切分的 `rdbuf` 上进行时，必须避免扩展后超过缓冲区长度（当前 `read` 最多读 70 字节：`kernel/main.c:247-248`）。

#### 7.4.1 `ShellEnv[]`：键值对表的最小可用设计
最小实现可以是一个定长数组（避免动态分配）：
```text
ENV_MAX = 32
ENV_KEY_MAX = 16
ENV_VAL_MAX = 48
env[ENV_MAX] = { used, key, val }
```
查找/写入策略：
- `set`：先线性查找 key，存在则覆盖 val；不存在则找一个 `used==0` 的槽位写入。
- `unset`：查找后将 `used=0` 并清空 key/val。
- `env`：遍历打印所有 `used==1` 的 `key=val`。

#### 7.4.2 变量展开：发生时机与替换规则
变量展开应发生在“分词完成之后、fork 之前”，原因是：
- `argv[]` 指向 `rdbuf` 的片段（`all.md:7.1.1`），此时替换 token 最简单。
- fork 之后父子分离，若在子进程里展开则会导致父进程历史/回显与实际执行不一致。

替换规则建议采用“单 token 替换”（与当前分词器一致）：
- 仅当 token 以 `$` 开头时尝试展开：`$NAME` -> `VALUE`。
- 不处理 `${NAME}`、`$NAME_suffix`、`$$` 等复杂语法，避免引入解析器。
- 查不到变量时替换为空串或保留原样（两者都可；为了更贴近常见 Shell，建议替换为空串）。

#### 7.4.3 两种替换落地方式：就地替换 vs 二次构造 argv
由于 `rdbuf` 长度很小（70 字节）且 token 指针是“指向原始缓冲”的，变量展开可选两条路线：

**A. 就地替换（仅当 `VALUE` 不长于 `$NAME`）**
- 若 `strlen(VALUE) <= strlen(token)`，可把 token 区域直接覆盖成 VALUE 并补 `0`。
- 优点：不需要额外缓冲，不改变 argv 指针。
- 缺点：无法处理 VALUE 更长的情况。

**B. 二次构造 argv（更通用，推荐）**
- 额外准备一个 `expanded_buf[128]`，把原始 token 逐个复制进去；遇到 `$NAME` 就复制 VALUE。
- 用 `new_argv[]` 指向 `expanded_buf` 中的新 token 地址，最后用 `new_argv` 执行 fork/exec。
- 优点：可处理 VALUE 变长。
- 代价：需要额外内存与更严格的越界检查（必须保证 expanded_buf 不溢出）。

#### 7.4.4 变量名与安全边界
- 变量名建议限制为 `[A-Z0-9_]+`（或 `[A-Za-z0-9_]+`），并限制长度（例如 15 字节），避免覆盖固定数组。
- 任何拷贝都必须显式长度检查；特别是 `set` 时写入 `val`，以及展开时拼接到 `expanded_buf`。

### 7.5 管道与重定向（在现有系统调用集合下的可实现语义）
当前实现未解析 `|`、`>`、`<`，下述为“可在现有接口上落地”的设计说明，明确能力边界与实现步骤。

#### 7.5.0 最小语法（无引号/无转义）与解析顺序
在 `shabby_shell` 的现有分词器约束下，推荐把 `|`、`>`、`<` 当作“必须被空格分隔的独立 token”，例如：
```text
ls | cat
echo hello > out.txt
cat < in.txt
```
不推荐（因为会被当作普通字符串 token）：
```text
ls|cat
echo hello>out.txt
```

解析顺序建议为（从低成本到高成本）：
1. 解析 `&`（决定父进程是否 wait）。
2. 解析重定向 `<`/`>`（决定子进程如何绑定 FD 0/1）。
3. 解析管道 `|`（决定是否拆成两段命令并生成临时文件方案）。
4. 做变量展开（确保重定向目标文件名也能含变量，如 `> $OUT`）。

#### 7.5.1 输出重定向 `>`（可直接落地）
现有系统调用支持以“关闭标准输出再 `open`”的方式完成重定向（文件描述符最小可用语义：最小的可用 FD 会被分配为 1）。

实现步骤（Shell 侧，fork 后 exec 前）：
1. 解析命令行：识别 `cmd ... > out.txt`，从 `argv` 中移除 `>` 与目标文件名。
2. 子进程中执行：
   - `close(1)`
   - `open("out.txt", O_CREAT | O_RDWR)` 期望返回 FD 1
   - `execv(cmd, argv)`

边界条件：
- 当前 `touch/edit` 等命令会额外打印提示信息，它们同样会被重定向到文件。
- 若 `open` 失败（权限/路径非法），子进程应打印错误并 `exit`，否则会继续 `execv` 导致用户误判。

#### 7.5.2 输入重定向 `<`（可落地，但受命令形态限制）
输入重定向同样可通过 FD 0 重绑定实现：
1. 识别 `cmd ... < in.txt`
2. 子进程：`close(0); open("in.txt", O_RDWR)` 期望返回 0
3. `execv(cmd, argv)`

能力边界：
- 只有“从 FD 0 读取”的命令才能从 `<` 获益。但当前多数命令（如 `cat`）直接按文件名打开读取（`command/cat.c:28-62`），并不会读取 FD 0，因此 `<` 对它们不生效。

#### 7.5.3 管道 `|`（无 `pipe()` 系统调用时的“兼容语义”）
OrangeOS 现状没有 `pipe()`/`dup2()` 之类的系统调用，因此无法做真实匿名管道。若需要“可演示的管道效果”，最贴近现有接口的方案是“临时文件中转”：

示例语义（仅对支持文件名输入的命令有效）：
```text
ls | cat
```
可降级为：
```text
ls > /tmp/.pipe && cat /tmp/.pipe
```
实现步骤（Shell 侧）：
1. 解析 `|`，把命令分成 left/right 两段。
2. 先 fork 执行 left，并将其 stdout 重定向到临时文件（参考 `7.5.1`）。
3. 等 left 结束（前台）后，再 fork 执行 right，并把临时文件名作为参数追加到 right 的 `argv` 尾部（例如 `cat`）。

边界条件与代价：
- 这是“顺序管道”，不是并行流式；数据量大时临时文件开销显著。
- 对不接受文件名输入的命令无效。
- 需要约定一个临时文件路径，并处理并发 Shell/并发管道的冲突（可用 `pid` 参与命名）。

可执行细化（更贴近工程落地）：
- 临时文件名：可用 `".pipe.<pid>.<seq>"`，放在当前目录（避免依赖 `/tmp` 目录存在）。
- 生命周期：right 执行结束后由 parent 进程 `unlink(tmp)` 清理；若 left 执行失败也要清理。
- 错误处理：
  - left 的 `open(tmp,O_CREAT|O_RDWR)` 失败：直接报错并终止管道执行。
  - right 在追加参数时必须检查 `argv` 容量（当前 `argv` 上限受 `PROC_ORIGIN_STACK` 约束，见 `kernel/main.c` 的数组声明）。
  - 若 right 不接受文件名参数（例如 `echo`），则应提示“不支持该管道组合”而不是静默执行。

---

## 8. 内置命令实现细节 (Built-in Commands)

### 8.1 核心命令列表
- **ls**: 打开当前目录文件，解析目录项结构，按字母序对文件名进行排序（选择排序），并输出格式化的文件详情（大小、Inode、权限）。
- **cat**: 简单的流式读取。以 `O_RDWR` 打开文件，读取后写入 FD 1（实现里只读一次，见 `all.md:8.7`）。
- **echo**: 回显参数到标准输出。
- **pwd**: 打印当前路径（实现为固定输出 `/`）。
- **touch**: 创建文件或提示“更新时间戳”（不真正写 inode 时间字段）。
- **remove**: 调用 `unlink()` 删除文件（有连续删除卡死的已知问题与元数据删除语义，见 `all.md:8.9`）。
- **ps**: 向 `TASK_SYS` 请求 `GET_PROC_INFO`。内核遍历 `proc_table`，提取进程名、PID 和状态标志位（如 `HANGING`, `SENDING`）进行展示。
- **kill**: 接收 PID 参数，发送 `END_WHICH_PROC` 消息。系统任务将其标志位设为 `FREE_SLOT`。
- **edit**: “拼装型”编辑工具：既能编辑文本文件，也能在白名单内执行命令（内嵌实现，不走 `execv`）。
- **log**: 通过 `logcontrol()` 切换日志开关或读取内核环形缓冲。
- **dino**: 通过 `logcontrol()` 获取 ticks/按键的字符游戏。

### 8.2 错误处理机制
- **参数验证**: 每个命令首先检查 `argc` 是否符合预期，不符则打印 Usage 说明。
- **系统调用返回**: 检查 `open` 或 `read` 的返回值。若为 -1，则通过 `printf` 输出具体的错误原因（如 `File not found`）。

### 8.3 命令通用执行流程（从 Shell 到命令 `main()`）
所有命令都遵循同一条最短执行链：
```text
TTY 输入 -> shabby_shell 解析 argv -> open 探测 -> fork
    -> child: execv(argv[0], argv) -> 命令 main(argc, argv)
    -> parent: wait(前台) 或直接返回提示符(后台)
```
关键落点：`kernel/main.c:244-315`。

### 8.4 `echo`：回显参数
**代码文件**：`command/echo.c:1-11`

**语法**
```text
echo [ARG...]
```

**执行流程图**
```text
main(argc, argv)
  -> for i=1..argc-1: printf("%s%s", sep, argv[i])
  -> printf("\n")
  -> return 0
```

**I/O 与边界**
- **输入**：`argv[1..]`
- **输出**：标准输出（FD 1）
- **边界**：不解析 `-n` 等选项；空参数只打印换行。

### 8.5 `pwd`：打印当前路径（固定输出）
**代码文件**：`command/pwd.c:1-8`

**语法**
```text
pwd
```

**实现要点**
- 直接 `printf("/\n")`（`command/pwd.c:6`），不依赖 FS 查询，因此是“静态版本”的 `pwd`。

### 8.6 `ls`：列目录 + 排序 + stat 补全
**代码文件**：`command/ls.c:11-154`，并依赖 `stat()`（用户态封装 `lib/stat.c` -> FS `do_stat`）。

**语法**
```text
ls [DIRECTORY]
ls --help | -h
```

**执行流程图（按真实代码路径）**
```text
main
  -> 解析参数(默认 ".")
  -> fd=open(dir_path,O_RDWR) 失败则报错返回
  -> n=read(fd, dir_entries, sizeof(dir_entries)) 失败则报错返回
  -> 过滤 inode_nr!=0 得到 valid_entries[]
  -> 选择排序(valid_entries[].name)
  -> for each entry:
       stat(entry.name,&st) 成功则打印 type/size/perms
       stat 失败则打印 Unknown/Error
  -> 统计并 close(fd)
```

**特殊逻辑与边界**
- `struct dir_entry` 在命令内部自定义为 `{ int inode_nr; char name[12]; }`（`command/ls.c:46-51`），与 FS 的目录项布局保持一致（`include/sys/fs.h:108-112`）。
- `stat(valid_entries[i].name, ...)` 只用文件名而非“目录前缀 + 文件名”，因此当 `ls DIR` 时，`stat` 可能因为路径不完整而失败；这属于实现边界（`command/ls.c:110-141`）。

### 8.7 `cat`：读取文件并输出
**代码文件**：`command/cat.c:12-71`

**语法**
```text
cat FILE [FILE...]
```

**执行流程图**
```text
main
  -> argc<2: 打印用法并返回 1
  -> for each file:
       fd=open(file,O_RDWR) 失败则报错 continue
       清空 buffer[1024]
       bytes_read=read(fd,buffer,sizeof(buffer))
       bytes_read>0: write(1,buffer,bytes_read)
       bytes_read==0: printf("\n")
       bytes_read<0: 打印 Read failed
       printf("\n"); close(fd)
  -> return 0
```

**边界**
- 只读一次 `read`，不循环直到 EOF，因此对大文件只会输出前 1024 字节（`command/cat.c:44-48`）。
- `open` 使用 `O_RDWR` 而非 `O_RDONLY`，在只读介质/权限严格时可能失败（`command/cat.c:29`）。

### 8.8 `touch`：创建文件或更新时间戳（提示型实现）
**代码文件**：`command/touch.c:14-85`

**语法**
```text
touch FILE [FILE...]
touch --help | -h
```

**执行流程图**
```text
main
  -> 参数/--help 处理
  -> for each filename:
       fd=open(filename,O_RDWR)
       if fd!=-1: close(fd); printf("Updated..."); success++
       else:
          fd=open(filename,O_CREAT)
          if fd!=-1: close(fd); printf("Created..."); success++
          else: printf("Cannot create..."); failure++
  -> 打印汇总并按 failure_count 返回 0/1
```

**边界**
- “更新时间戳”仅以提示文本表示，并未写入 inode 时间字段（文件系统也未暴露此语义），属于功能简化。

### 8.9 `remove`：unlink 删除文件（含已知问题说明）
**代码文件**：`command/remove.c:15-91`

**语法**
```text
remove FILE [FILE...]
remove --help | -h
```

**执行流程图**
```text
main
  -> args<2: 打印用法返回 1
  -> --help: 打印帮助返回 0
  -> for each file:
       printf("rm: Removing '%s'...\n")  // 程序输出前缀使用 rm
       result=unlink(file)
       result==-1: 报错 failure++
       else: success++
       getpid(); getpid();  // 人为让出 CPU
  -> 打印汇总并返回 failure_count>0 ? 1 : 0
```

**已知边界与现象（来自 `command.md` 的问题复盘）**
- 连续 `unlink` 可能出现“卡死/无响应”现象。文档分析指出潜在原因是“FS 侧对 pathname 指针的处理不安全”，即跨进程传递的指针在下一次调用时可能失效，导致 FS 拷贝路径失败并进入异常状态（`command.md:49-51` 的分析）。
- 另外，FS 的 `do_unlink()` 只回收元数据，不覆写数据区（`all.md:6.2.1`），因此删除后新建空文件可能读到旧内容，这与 `command.md:52` 的现象一致。

### 8.10 `ps`：枚举 proc_table 并显示状态位
**代码文件**：`command/ps.c:13-84`，服务端实现为 `kernel/systask.c:33-78` 的 `GET_PROC_INFO` 分支。

**语法**
```text
ps
ps --help | -h
```

**执行流程图**
```text
main
  -> 处理 --help
  -> for pid in [0, NR_TASKS+NR_PROCS):
       msg.type=GET_PROC_INFO; msg.PID=pid; msg.BUF=&p
       send_recv(BOTH,TASK_SYS,&msg)
       if p.p_flags!=FREE_SLOT:
          解析 HANGING/WAITING/SENDING/RECEIVING 生成状态码
          printf 输出
```

**边界**
- 进程名来自 `proc_table[].name`，而部分 exec 路径可能把较长 pathname 直接写入固定长度数组，导致显示异常与表项被污染；这在 `command.md:62-105` 中有详细推测（根因属于实现层面的字符串拷贝边界问题）。

### 8.11 `kill`：向 SYS 发送终止请求（语义偏“释放槽位”）
**代码文件**：`command/kill.c:53-113`；服务端处理在 `kernel/systask.c:67-72`。

**语法**
```text
kill PID
kill --help
```

**执行流程图**
```text
main
  -> 参数校验与 PID 范围检查
  -> msg.type=END_WHICH_PROC; msg.PID=pid; send_recv(BOTH,TASK_SYS,&msg)
  -> 若 msg.RETVAL==0: 再 GET_PROC_INFO 验证 p_flags 是否为 FREE_SLOT
```

**边界与语义说明**
- 当前 `END_WHICH_PROC` 的实现是直接把目标表项标记为 `FREE_SLOT`（`kernel/systask.c:67-72`），并不等价于“让目标进程正常走 EXIT 流程释放资源”。因此会出现“ps 不显示但逻辑仍可能在运行/资源未回收”的割裂，这在 `command.md:110-157` 中给出了原因与改进建议。

### 8.12 `edit`：文本编辑 + 命令执行的组合工具
**代码文件**：`command/edit.c`（实现较长，属于“拼装型命令”）

**语法（按 `command.md` 归纳）**
```text
edit CMD [ARGS...]          # 执行命令（白名单内）
edit FILE                   # 查看或创建空文件
edit FILE CONTENT           # 覆盖写入
edit -a FILE CONTENT        # 追加写入
```

**关键实现策略**
- 用 `executable_files[]` 白名单判断 `argv[1]` 是命令还是文件（`command/edit.c:22-24`）。
- 若是命令：直接“内嵌复制”各命令实现并调用对应逻辑（例如内嵌 `cat/echo/kill/ls/ps` 的代码片段），因此它不是通过 `execv` 运行外部程序。

**边界**
- 由于复用/复制其他命令的实现，`edit` 的行为边界与各命令一致（例如 `cat` 只读 1024 字节等）。
- `O_TRUNC` 在本命令中自定义（`command/edit.c:16-19`），这与 FS 对 flags 的支持程度相关，属于兼容性风险点。

### 8.13 `log`：控制/查看内核环形日志
**代码文件**：`command/log.c:6-104`（用户态）+ `kernel/proc.c:626-677`（`sys_logcontrol`）

**语法**
```text
log show
log [process|file|syscall|device] [0|1]
```

**执行流程图**
```text
main(argc,argv)
  -> argc<2: 打印 Usage 与 "log show" 提示，返回 0
  -> argv[1]=="show":
       buf[4096]
       pos = logcontrol(999, 4096, buf)         // 拷贝内核环形缓冲 + 返回写指针
       linearize: linear[i]=buf[(pos+i)%4096]
       从 linear 末尾向前找最后 10 行起点 start_index
       printf("%s",&linear[start_index])
       return 0
  -> 否则要求 argc>=3:
       what = {process:1,file:2,syscall:3,device:4}
       status = {0|1}
       if logcontrol(what,status,0)==0: printf("enabled/disabled")
       else: printf("failed to set")
       return 0
```

**错误处理与边界**
- `argc<2` 或缺少第二参数：打印用法并返回 0（提示型错误，非严格失败）。
- 未知开关目标：打印 `Unknown target` 并返回 1（`command/log.c:85-88`）。
- status 不是 `0|1`：打印 `Invalid status` 并返回 1（`command/log.c:93-96`）。
- `log show` 的显示范围：代码只打印“线性化后最后 10 行”，并且缓冲未满时线性化前部存在 `0`，因此输出以“已有日志中靠近末尾的部分”为主（`command/log.c:29-69` 的扫描逻辑）。

### 8.14 `dino`：字符跑酷游戏（ticks + 键盘轮询）
**代码文件**：`command/dino.c:7-112`

**语法**
```text
dino
```

**执行流程图（按主循环）**
```text
main
  -> 打印提示行
  -> 读取 ticks 并忙等约 50 tick，让用户看见提示
  -> 外层 while(1): 每局重置 score/dino_y/obstacle_x/speed/last_tick
     -> 等待 SPACE 开始（logcontrol(200) 非阻塞轮询），q 退出
     -> 内层 while(1):
         do { 轮询 key 与 ticks } while (ticks-last_tick < speed)
         处理输入：SPACE 起跳（仅地面可触发），q 退出
         更新跳跃计时/障碍移动/得分/速度（每 5 分加速）
         碰撞检测：障碍到达 DINO_X 且未起跳 -> Game Over 并 break
         渲染：构造 line[] 并用 "\r" 覆盖式输出
```

**错误处理与边界**
- 无参数解析与显式错误码；主要边界来自系统接口：依赖 `logcontrol(100)` 返回 ticks 与 `logcontrol(200)` 返回按键（`command/dino.c:29-70`）。
- 采用忙等 + 轮询输入，会持续占用 CPU；其“帧率/速度”完全由 ticks 与 `speed` 控制，属于可预期但非省电的实现策略。

---

## 9. 设备驱动 (Device Drivers)

### 9.1 硬盘驱动 (HD)
**代码文件**: `kernel/hd.c`
- **逻辑**: 通过 I/O 端口 (`0x1F0-0x1F7`) 与硬盘控制器通信。支持 LBA 寻址模式。
- **分层**: 驱动层只处理扇区读写，不感知文件系统结构。

### 9.2 终端驱动 (TTY)
**代码文件**: `kernel/tty.c`
- **控制台**: 支持多控制台切换 (`Alt+F1/F2/F3`)。
- **回显**: 处理普通字符的屏幕打印，以及退格、换行等特殊字符的逻辑处理。

### 9.3 驱动与 FS 的消息接口：从 `do_rdwt()` 到 `rw_sector()`
驱动层的“接口面”不是系统调用，而是 FS 发给驱动任务的 `DEV_*` 消息（`include/sys/const.h:188-193`）。典型链路如下：
```text
用户进程 read/write -> lib/read.c or lib/write.c -> TASK_FS
  -> fs/read_write.c:do_rdwt()
     -> rw_sector(DEV_READ/DEV_WRITE, ...)
        -> send_recv(BOTH, driver_nr, &msg)
           -> kernel/hd.c (TASK_HD) 执行端口 I/O
           -> 回包唤醒 FS -> FS 回包用户进程
```
关键“数据搬运点”是 `phys_copy + va2la`（`fs/read_write.c:106-128`），它保证了驱动/FS 不直接访问用户进程地址空间。

---

## 10. 用户态扩展深度分析 (Deep Dive)

### 10.1 系统日志系统 (Log System)
**代码文件**: `kernel/proc.c`, `command/log.c`

- **环形缓冲区**: 内核分配 4KB 空间（`include/sys/global.h:53-55` 的 `LOGBUF_SIZE=4096`）。`append_log` 负责在游标到达末尾时回绕。
- **多维度监控**:
    - **进程切换**: 在 `schedule()` 中记录每次 CPU 的交接。
    - **系统调用**: 在汇编入口 `sys_call` 处拦截，记录 EAX 寄存器（调用号）。
    - **文件 I/O**: 在 `do_rdwt` 中记录访问的文件名和读写字节数。
- **防死锁设计**: 系统调用日志记录函数会过滤掉 `logcontrol` 自身的调用，防止产生无限递归。

### 10.2 Dino 字符游戏
**代码文件**: `command/dino.c`

一个无需图形界面的字符版恐龙跑酷游戏，展示了系统的高级交互能力。

```c
// command/dino.c 核心逻辑

// 1. 精确计时
// 通过 logcontrol(100) 获取内核 ticks，实现独立于 CPU 速度的帧率控制。
while (logcontrol(100, 0, (void*)0) - last_tick < speed) {}

// 2. 非阻塞输入
// 标准 scanf 会阻塞游戏循环。Dino 使用 logcontrol(200) 直接查询键盘缓冲区。
int key = logcontrol(200, 0, (void*)0);
if (key != 0) {
    // 处理跳跃 (Space) 或退出 (q)
}

// 3. 渲染
// 直接打印字符数组覆盖当前行 (\r)
printf("\r%s", line);
```

---

## 11. 总结

OrangeOS 展示了一个具备现代特性的微内核操作系统雏形：
1.  **分层清晰**: 引导 -> 内核 -> 系统服务 -> 用户进程。
2.  **动态性**: 实现了 First-Fit 内存分配和老化调度算法。
3.  **安全性**: 文件系统层实现了越界检查与元数据安全回收（默认不覆写数据区）。
4.  **扩展性**: 能够支持复杂的实时交互应用 (Dino) 和系统工具 (Log)。
