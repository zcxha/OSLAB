# 漏洞演示文档 (Demo Documentation)

本文档描述了针对该微内核 OS Shell 的漏洞分析、演示程序说明以及测试步骤。

## 1. 漏洞分析 (Vulnerability Analysis)

基于 `command.md` 和 `fix.md` 的分析，我们识别出以下主要安全漏洞：

### 1.1 数据残留 (Data Remanence) / 信息泄露
- **漏洞描述**: `remove` 命令（底层 `unlink`）在释放磁盘扇区时，未清空扇区内容。
- **后果**: 新创建的文件如果复用了旧文件的扇区，可以直接读取到旧文件的残留数据。
- **涉及文件**: `fs/link.c`, `command/remove.c`
- **对应演示**: `leak`

### 1.2 拒绝服务 (DoS) / 系统卡死
- **漏洞描述**: 连续调用 `remove` (或 `unlink`) 删除多个文件时，会导致系统卡死（Freeze）。
- **原因**: 文件系统或磁盘驱动在处理连续释放请求时存在竞态条件或死锁。
- **对应演示**: `crash`

### 1.3 缓冲区溢出 (Buffer Overflow)
- **漏洞描述**: `mm/exec.c` 在执行 `do_exec` 时，直接使用 `strcpy` 将用户传入的路径名复制到进程表 (`proc_table`) 的 `name` 字段，未检查长度。
- **后果**: 如果执行一个路径名超过 16 字节的程序，将覆盖进程表中相邻进程的数据（如 `p_flags`, `p_parent` 等），导致 `ps` 命令显示异常，甚至引发提权或系统崩溃。
- **对应演示**: `overflow`

---

## 2. 演示程序说明 (Demo Programs)

所有演示程序源码位于 `exploits/` 目录下。

### 2.1 leak (信息泄露演示)
- **功能**:
    1. 创建 `secret` 文件并写入 "TOP_SECRET_DATA"。
    2. 删除 `secret` 文件。
    3. 创建 `dummy` 文件（系统倾向于复用刚释放的扇区）。
    4. 读取 `dummy` 文件内容。
- **预期结果**: 程序输出 `[SUCCESS] Secret data LEAKED!`，并打印出读取到的旧数据。

### 2.2 crash (DoS 演示)
- **功能**:
    1. 创建 5 个临时文件。
    2. 循环连续调用 `unlink` 删除这 5 个文件（不加延时）。
- **预期结果**: 系统在删除过程中**卡死**，无法打印最后的 "If you see this..." 消息。

### 2.3 overflow (缓冲区溢出演示)
- **功能**:
    1. 构造一个超长的路径名（例如 `././././.../echo`），长度超过 16 字节。
    2. 调用 `execv` 执行该路径。
- **预期结果**: `exec` 调用成功（执行 `echo`），但在执行后运行 `ps` 命令，会发现进程名称显示异常（乱码或被覆盖），验证了内核数据结构被破坏。

---

## 3. 编译与运行步骤 (Build & Run)

### 步骤 1: 编译演示程序
进入 `exploits` 目录并编译：

```bash
cd exploits
make
```

这将生成 `leak`, `crash`, `overflow` 三个可执行文件。

### 步骤 2: 安装到文件系统
为了在 OS 中运行这些程序，需要将它们添加到安装包 (`inst.tar`) 中并写入磁盘映像。最简单的方法是利用 `command` 目录现有的构建流程。

1.  **复制可执行文件**:
    将编译好的程序复制到 `command` 目录：
    ```bash
    cp leak crash overflow ../command/
    ```

2.  **更新安装包**:
    进入 `command` 目录，手动打包所有命令（包括原有的和新的 demos）并写入磁盘。
    
    *注意：以下命令假设你已经处于 `command/` 目录下，并且该目录已有编译好的系统命令（ls, ps 等）。*

    ```bash
    cd ../command
    # 重新打包 inst.tar (包含 kernel.bin, 原有命令, 和漏洞演示程序)
    tar vcf inst.tar kernel.bin echo pwd ls touch remove edit cat ps kill leak crash overflow
    
    # 写入磁盘映像 (命令取自 command/Makefile)
    # 注意：请确保 ../80m.img 存在
    dd if=inst.tar of=../80m.img seek=`echo "obase=10;ibase=16;(\`egrep -e '^ROOT_BASE' ../boot/include/load.inc | sed -e 's/.*0x//g'\`+\`egrep -e '#define[[:space:]]*INSTALL_START_SECT' ../include/sys/config.h | sed -e 's/.*0x//g'\`)*200" | bc` bs=1 count=`ls -l inst.tar | awk -F " " '{print $5}'` conv=notrunc
    ```
    
    *(或者，你可以直接修改 `command/Makefile` 中的 `BIN` 变量，加入 `leak crash overflow`，然后运行 `make install`)*

### 步骤 3: 运行测试
1.  启动 Bochs (运行 `sh test.sh` 或直接启动)。
2.  进入 Shell。
3.  **测试 leak**:
    ```bash
    $ leak
    ```
    观察是否输出了 "TOP_SECRET_DATA"。
4.  **测试 overflow**:
    ```bash
    $ overflow
    $ ps
    ```
    观察 `ps` 输出的进程名是否异常。
5.  **测试 crash** (建议最后测试，因为会卡死):
    ```bash
    $ crash
    ```
    观察系统是否停止响应。

