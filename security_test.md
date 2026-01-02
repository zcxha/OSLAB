# OS 安全机制测试文档

本文档详细说明了如何在 OS 实验项目中验证**静态度量**和**动态度量**功能的实现与效果。

## 1. 编译与环境准备

在开始测试之前，请确保已重新编译内核并启动模拟器。

### 1.1 编译内核
在项目根目录下执行以下命令：
```bash
sh test.sh
```
或者手动执行：
```bash
make clean
make image
```
确保编译过程无错误，且最终生成了更新后的 `80m.img` 或 `a.img`。

### 1.2 启动模拟器
执行以下命令启动 Bochs：
```bash
bochs -q -f bochsrc
```

---

## 2. 静态度量 (Static Measurement) 测试

**功能描述**：
系统在加载可执行文件（`exec`）时，会计算文件内容的校验和（Checksum），并与内核内置的“可信数据库”进行比对。

### 2.1 测试用例 1：完整性通过 (PASS)
**操作**：
在 OS Shell 中输入以下命令（假设 `echo` 已在可信列表中）：
```bash
$ echo hello
```

**预期结果**：
1.  程序正常执行，输出 `hello`。
2.  观察控制台日志（或 `bochsout.txt`），应包含：
    ```
    {MM} Static Measurement: Checking echo...
    {MM} Integrity Check PASSED for echo
    ```

### 2.2 测试用例 2：完整性失败 (FAIL)
**操作**：
如果 `echo` 的二进制内容发生变化（例如重新编译了 command 但没更新内核 DB），校验和将不匹配。
```bash
$ echo hello
```

**预期结果**：
日志显示失败信息：
```
{MM} Integrity Check FAILED for echo (Expected: 0x..., Got: 0x...)
```
*注：本系统仅做记录报警，未强制拦截执行。*

### 2.3 测试用例 3：未知程序 (Unknown)
**操作**：
运行一个不在可信数据库中的程序，例如 `ls`：
```bash
$ ls
```

**预期结果**：
日志显示未知警告：
```
{MM} Integrity Check: Unknown binary ls (Not in trusted DB). Calculated Checksum: 0x...
```

---

## 3. 动态度量 (Dynamic Measurement) 测试

**功能描述**：
系统内核通过时钟中断（`clock_handler`），周期性地（每 10ms）检查当前运行进程的堆栈状态。如果发现栈顶的返回地址超出了该进程代码段的合法范围（Code Segment Limit），则视为“栈溢出攻击”或“控制流劫持”。

### 3.1 测试用例 1：正常运行 (Normal)
**操作**：
启动系统后，保持空闲或运行普通命令（如 `ps`, `ls`）。

**预期结果**：
*   系统运行稳定，无异常报警。
*   屏幕保持正常显示。

### 3.2 测试用例 2：攻击模拟 (Attack Simulation)
为了验证检测机制的有效性，我们编写了一个专门的攻击模拟程序 `attack`。

**操作**：
在 OS Shell 中输入：
```bash
$ attack
```

**原理**：
1.  `attack` 程序启动并进入死循环。
2.  内核的 `dynamic_check` 函数检测到进程名为 "attack" 时，会**强制模拟**一个非法的返回地址（`0xFFFFFFFF`），从而触发报警逻辑。

**预期结果**：
*   **全屏红色警报**：屏幕瞬间被**红底白字**的感叹号 `!` 填满。
*   这是系统检测到严重安全违规（控制流完整性被破坏）时的最高级别视觉警报。

---

## 4. 故障排查

*   **如果看不到全屏红屏**：
    *   确认是否执行了 `sh test.sh` 重新编译。
    *   确认是否输入了 `attack` 命令并回车。
    *   确认 `kernel/proc.c` 中的 `dynamic_check` 函数包含全屏覆盖显存的逻辑。

*   **如果看不到静态度量日志**：
    *   可能是日志被屏幕滚动冲刷掉了。建议配置 `bochsrc` 开启 `log: bochsout.txt`，然后在文件中查看历史日志。
    *   或者使用 `Shift + PageUp` 在 Bochs GUI 中向上翻页查看。
