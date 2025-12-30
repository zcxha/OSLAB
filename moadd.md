# OrangeOS 任务三：扩展系统日志能力 —— 详细设计与实现报告
## 1. OrangeOS 系统架构概览
在深入日志系统之前，必须先理解 OrangeOS 的运作架构。OrangeOS 采用 微内核 (Microkernel) 架构，其核心特征是模块化和特权级隔离。

### 1.1 特权级分层 (Privilege Rings)
系统分为三个主要的层级：

- Ring 0 (内核层) :
  - Kernel : 包含 kernel.asm , proc.c , protect.c 等。
  - 职责 : 处理中断、异常、进程调度 ( schedule )、底层 IPC (消息传递)。它是唯一能直接执行特权指令的部分。
- Ring 1 (任务与服务层) :
  - System Tasks : Task TTY (终端), Task SYS (系统调用辅助), Task HD (硬盘驱动)。
  - Servers : FS (文件系统), MM (内存管理)。
  - 职责 : 提供操作系统服务。它们拥有独立的地址空间（在 Flat 模式下即独立的段），通过消息传递 ( send_recv ) 与其他部分通信。
- Ring 3 (用户层) :
  - User Processes : Shell, init , 以及我们编写的命令 ( log , ls , TestA ).
  - 职责 : 运行用户程序。
### 1.2 通信机制
- IPC : 不同特权级的进程不能直接调用对方的函数。它们通过 System Call (系统调用) 和 Message Passing (消息传递) 进行交互。
- INT 0x90 : 这是 OrangeOS 系统调用的入口中断号。
## 2. 日志系统架构设计
为了实现“统一记录、分层产生、用户查看”的需求，我们设计了 “内核集中存储 + 分布式探针” 的架构。

### 2.1 核心设计理念
1. 集中存储 (Centralized Storage) : 所有日志（无论是内核产生的，还是文件系统产生的）最终都汇聚到内核的一个全局缓冲区中。
2. 环形缓冲 (Ring Buffer) : 为了防止日志无限增长撑爆内存，使用固定大小（16KB）的环形缓冲区。新日志会自动覆盖最旧的日志。
3. 系统调用网关 (Syscall Gateway) : 新增一个系统调用 sys_logcontrol ，作为日志系统的总控制台，负责开关设置、日志写入（来自 Ring 1）和日志读取（来自 Ring 3）。
### 2.2 数据流向图
```
[用户层?Ring?3]??????[服务层?Ring?1]???????????[内核层?Ring?0]
???Command?????????????File?System???????????????Kernel
??(log?show)???????????(do_rdwt)???????????????(schedule)
??????|????????????????????|???????????????????????|
??????v????????????????????v???????????????????????v
?int?0x90?(Read)??????int?0x90?(Write)????????直接内存访问
??????|????????????????????|???????????????????????|
??????+--------------------+-----------------------+
???????????????????????????|
???????????????????????????v
?????????????????+-------------------+
?????????????????|??sys_logcontrol???|?<---?控制中心
?????????????????+-------------------+
???????????????????????????|
???????????????????????????v
?????????????????+-------------------+
?????????????????|?Global?Log?Buffer?|?<---?核心数据区
?????????????????+-------------------+
```
## 3. 详细修改说明 (Implementation Details)
为了实现上述架构，我们对源码进行了如下关键修改：

### 3.1 核心数据与控制 (Kernel Layer)
文件 : kernel/global.c , include/sys/global.h

- 新增变量 :
  - logbuf[LOGBUF_SIZE] : 16KB 的字符数组，作为日志容器。
  - logbuf_pos : 指向缓冲区当前写入位置的游标。
  - log_process , log_syscall , log_file , log_device : 4 个整型开关，控制不同类型日志的开启/关闭。
### 3.2 核心逻辑实现 (Kernel Layer)
文件 : kernel/proc.c

这是日志系统的“大脑”，主要包含三个部分：

1. sys_logcontrol (系统调用实现) :
   
   - 功能 : 处理所有日志相关的请求。
   - 逻辑 :
     - what == 999 (READ): 使用 phys_copy 将内核缓冲区的数据安全地拷贝到用户进程的内存空间。
     - what == 888/8882/8884 (WRITE): 接收来自 FS 或其他 Ring 1 服务的日志字符串，校验对应的开关状态（如 log_file ），然后写入缓冲区。
     - what == 1/2/3/4 (SWITCH): 设置对应的全局开关变量。
2. klog_kernel (内核专用日志函数) :
   
   - 功能 : 类似于 printf ，但专门用于内核态。
   - 解决的问题 : 之前使用的 klog 存在与 printf 混用的风险，且需要适配 OrangeOS 特殊的变长参数处理（通过栈偏移计算 va_list ）。它格式化字符串后调用 append_log 。
3. append_log (缓冲区管理) :
   
   - 功能 : 将字符串写入 logbuf ，并处理环形回绕（Wrap around）。
### 3.3 埋点与探针 (Instrumentation)
我们在系统的关键路径上插入了代码（Hooks）来捕获行为：

1. 进程调度日志 :
   
   - 位置 : kernel/proc.c -> schedule()
   - 逻辑 : 每次 schedule 函数决定切换到新进程时，检查 log_process 开关。如果开启，调用 klog_kernel 记录 {SCHEDULE} 信息。
   - 优化 : 为了防止死机（HLT error），我们确保只在真正发生进程切换时才记录，且不在中断处理最敏感的区域调用。
2. 系统调用日志 :
   
   - 位置 : kernel/proc.c -> do_log_syscall()
   - 逻辑 : 在 kernel.asm 的 sys_call 入口处被调用。
   - 防递归设计 : 必须排除 eax == 0 (printx) 和 eax == 2 (logcontrol) 的调用。否则，记录日志这个动作本身又是一个系统调用，会导致无限递归，瞬间撑爆缓冲区。
3. 文件访问日志 :
   
   - 位置 : fs/read_write.c -> do_rdwt()
   - 逻辑 : 当发生文件读写时，FS 进程（Ring 1）构建 {FILE} 字符串。
   - 跨层写入 : FS 不能直接访问 logbuf 。它调用 logcontrol(8882, ...) ，这会触发一个系统调用，陷入内核，由内核代为写入。
4. 设备访问日志 :
   
   - 位置 : fs/main.c -> rw_sector()
   - 逻辑 : 类似于文件日志，当 FS 请求读写磁盘扇区时，通过 logcontrol(8884, ...) 记录 {DEVICE} 信息。
### 3.4 用户接口 (User Layer)
文件 : command/log.c , lib/syscall.asm

- command/log.c : 编写了一个新的 Shell 命令 log 。
  - 支持 log process 1 这种参数解析。
  - 支持 log show ：读取内核缓冲区，并只显示最后 10 行（避免刷屏）。
- lib/syscall.asm : 实现了 logcontrol 的汇编包装器，负责将参数压栈并触发 int 0x90 。
## 4. 运作流程案例分析 (Workflow)
让我们跟踪一个 文件读取日志 是如何产生的：

1. 触发 : 用户进程运行 edit file 。
2. 系统调用 : 用户进程调用 read() ，陷入内核，消息发送给 FS 进程。
3. FS 处理 : FS 进程接收消息，执行 do_rdwt() 。
4. 日志生成 (Ring 1) :
   - do_rdwt 检测到 log_file == 1 。
   - 使用 sprintf 格式化字符串 "{FILE} READ proc:TestA fd:3..." 。
   - 调用 logcontrol(8882, len, buf) 。
5. 陷入内核 (Ring 1 -> Ring 0) :
   - logcontrol 触发 int 0x90 。
   - CPU 切换到 Ring 0，执行 sys_call ，分发给 sys_logcontrol 。
6. 内核写入 (Ring 0) :
   - sys_logcontrol 验证 what == 8882 且 log_file 开启。
   - 使用 phys_copy 将字符串从 FS 进程内存拷贝到内核栈/缓冲区。
   - 调用 append_log 写入 logbuf 。
7. 查看 (Ring 3) :
   - 用户输入 log show 。
   - log 命令调用 logcontrol(999, ...) 。
   - 内核将 logbuf 内容拷贝回用户缓冲区，打印到屏幕。
## 5. 遇到的挑战与解决方案
在开发过程中，我们解决了以下关键问题：

1. HLT Instruction with IF=0 (系统死机) :
   
   - 原因 : 日志量过大，且在中断关闭的情况下进行了耗时的 IO 或缓冲区操作，导致时钟中断积压或堆栈溢出。
   - 解决 : 优化 schedule 日志逻辑，仅在必要时记录；实现轻量级的 klog_kernel 替代复杂的 printf 。
2. 递归日志 (Recursive Logging) :
   
   - 原因 : 记录“系统调用”的动作本身就是一个系统调用。
   - 解决 : 在 do_log_syscall 中显式过滤掉 logcontrol 对应的系统调用号。
3. C99 语法兼容性 :
   
   - 原因 : for (int i=0...) 写法在旧标准编译器下报错。
   - 解决 : 将变量声明移至函数块顶部。
4. Windows 环境兼容性 :
   
   - 原因 : Makefile 执行 shell 命令时，Windows 的 \r\n 换行符导致 dd 命令解析失败。
   - 解决 : 在 Makefile 中添加 tr -d '\r' 过滤换行符。
## 6. 总结
本次实验成功地在 OrangeOS 中集成了一个 全栈式 的日志系统。它不仅验证了我们对微内核架构（特权级、IPC、系统调用）的理解，还锻炼了在受限环境下（Ring 0）进行调试和开发的能力。现在的 OrangeOS 具备了自我观测能力，为后续的调试和优化提供了强大的工具。