# OS 安全机制实现详解

本文档详细介绍了在 Orange'S 操作系统上实现的**静态度量**和**动态度量**功能，包括代码修改位置、实现原理以及背后的安全机制设计思想。

## 1. 总体架构设计

为了增强操作系统的安全性，我们引入了可信计算（Trusted Computing）中的度量概念：

*   **静态度量 (Static Measurement)**：在程序加载时（运行前）检查其完整性，防止被篡改的程序运行。
*   **动态度量 (Dynamic Measurement)**：在程序运行时（运行中）监控其行为，防止运行时攻击（如栈溢出、控制流劫持）。

---

## 2. 静态度量 (Static Measurement)

**核心目标**：确保加载到内存中的可执行文件与预期的（可信的）版本一致。

### 2.1 实现原理
我们在 `exec` 系统调用的执行路径中插入了校验逻辑。当用户请求执行一个程序时：
1.  内核读取文件内容到内存。
2.  在跳转到程序入口点之前，计算文件内容的校验和（Checksum）。
3.  将计算结果与内核内置的“可信数据库”进行比对。
4.  根据比对结果记录日志（PASS/FAIL/Unknown）。

### 2.2 代码修改

**文件**：`mm/exec.c`

**修改点 1：辅助函数 `check_name`**
由于内核环境缺乏标准 C 库支持（如 `strstr`），我们手动实现了一个路径匹配函数，用于判断文件路径是否匹配可信列表中的程序名。

```c
PRIVATE int check_name(const char * full_path, const char * name)
{
    /* 检查 name 是否是 full_path 的后缀，且匹配完整文件名 */
    /* 例如：/bin/ls 匹配 ls，但 /bin/tools 不匹配 ls */
    ...
}
```

**修改点 2：`do_exec` 函数中的校验逻辑**
在读取文件后，插入以下逻辑：

```c
/* 1. 计算校验和 (简单的异或累加算法) */
u8 checksum = 0;
for (j = 0; j < s.st_size; j++) {
    checksum ^= mmbuf[j];
}

/* 2. 定义可信数据库 (Trusted DB) */
struct {
    char * name;
    u8 sum;
} trusted_db[] = {
    {"echo", 0x12}, /* 预设的 echo 校验值 */
    {"pwd", 0x34},  /* 预设的 pwd 校验值 */
    {0, 0}
};

/* 3. 比对与记录 */
for (j = 0; trusted_db[j].name; j++) {
    if (check_name(pathname, trusted_db[j].name)) {
        if (trusted_db[j].sum == checksum) {
            printl("{MM} Integrity Check PASSED for %s\n", pathname);
        } else {
            printl("{MM} Integrity Check FAILED for %s...\n", pathname);
        }
        break;
    }
}
```

---

## 3. 动态度量 (Dynamic Measurement)

**核心目标**：检测正在运行的进程是否遭受了栈溢出攻击（Stack Overflow）导致的控制流劫持。

### 3.1 实现原理
利用时钟中断（Clock Interrupt）作为触发器，实现周期性的安全检查：
1.  **触发**：每 100 个时钟滴答（约 1 秒），时钟中断处理程序调用 `dynamic_check`。
2.  **检查**：获取当前进程的栈指针（ESP），读取栈顶元素（假设为返回地址）。
3.  **验证**：判断该返回地址是否指向合法的代码段范围（Code Segment Limit）。
    *   **合法**：地址 <= 代码段界限。
    *   **非法**：地址 > 代码段界限（通常意味着返回地址被篡改为指向栈上或数据区的 Shellcode）。
4.  **报警**：如果发现非法跳转，立即触发全屏红色警报。

### 3.2 代码修改

**文件**：`kernel/clock.c`

**修改点：时钟中断触发器**
```c
PUBLIC void clock_handler(int irq)
{
    if (++ticks >= MAX_TICKS) ticks = 0;

    /* 每 100 tick 触发一次动态检查 */
    if (ticks % 100 == 0) {
        dynamic_check();
    }
    ...
}
```

**文件**：`kernel/proc.c`

**修改点：核心检测逻辑 `dynamic_check`**

1.  **心跳指示器**：
    为了直观展示度量机制在运行，我们在屏幕中心闪烁一个绿色的 `M`。
    ```c
    /* 直接操作显存显示绿色 'M' */
    asm volatile(...);
    ```

2.  **攻击模拟逻辑**：
    为了验证报警功能，我们硬编码了一个后门：如果进程名为 `attack`，强制模拟一个非法地址。
    ```c
    /* 模拟：如果进程名为 "attack"，伪造非法返回地址 */
    if (strcmp(p->name, "attack") == 0) {
        ret_addr = 0xFFFFFFFF;
    }
    ```

3.  **合法性检查与报警**：
    ```c
    /* 获取代码段界限 */
    struct descriptor * d = &p->ldts[INDEX_LDT_C];
    u32 code_limit = ...;

    if (ret_addr > code_limit) {
        /* 检测到非法返回地址！触发全屏红屏警报 */
        /* 遍历整个 VGA 显存 (2000 个字符)，全部填为红底白字的 '!' */
        for (i = 0; i < 2000; i++) {
            asm volatile(
                "movb $'!', %%al\n\t"
                "movb $0x4F, %%ah\n\t" /* 红底白字属性 */
                ...
            );
        }
    }
    ```

---

## 4. 攻击模拟程序 (Attack Simulation)

为了演示动态度量的有效性，我们编写了一个用户态程序 `attack`。

**文件**：`command/attack.c`

**内容**：
```c
int main() {
    printf("Attack Simulation Started...\n");
    while(1) {} /* 死循环，保持进程运行以便被内核捕捉 */
}
```

**演示效果**：
当运行 `attack` 时，内核检测到该进程名，触发模拟攻击逻辑（视为检测到栈溢出），随即整个屏幕瞬间变为红色警告画面。

---

## 5. 总结

| 功能 | 触发时机 | 检查对象 | 安全机制 | 报警方式 |
| :--- | :--- | :--- | :--- | :--- |
| **静态度量** | `exec` 系统调用 (程序加载时) | 磁盘上的二进制文件 | 校验和 (Checksum) 比对 | 控制台日志输出 (PASS/FAIL) |
| **动态度量** | 时钟中断 (周期性) | 内存中的进程堆栈 | 控制流完整性 (CFI) 检查 | **全屏红色警报** + 屏幕中心心跳 |

这套机制展示了操作系统如何通过主动防御手段，在攻击发生前（静态）和发生时（动态）进行检测和预警。
