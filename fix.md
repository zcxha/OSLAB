# Bug 修复报告：cat 命令显示乱码问题

## 1. 问题描述
在使用 `cat` 命令查看文件内容时，会在文件实际内容之后显示出大量乱码字符（如图形符号、非预期字符等）。

## 2. 根本原因分析
这个问题是由两个层面的原因共同导致的，涉及到了**信息泄露（Information Leakage）**和**越界读取（Out-of-Bounds Read）**类漏洞。

### A. 内核文件系统层面的 Bug (主要原因)
在 `fs/read_write.c` 的 `do_rdwt` 函数中存在逻辑错误。

- **问题代码**：
  ```c
  int bytes_left = len; // len 是用户请求读取的长度（例如 1024）
  // ...
  // 在循环读取扇区时：
  int bytes = min(bytes_left, chunk * SECTOR_SIZE - off);
  ```
- **漏洞分析**：
  当用户请求读取的长度（`len`，如 1024 字节）大于文件实际大小（如 5 字节）时，`do_rdwt` 没有将 `bytes_left` 限制为文件剩余的实际大小。
  这导致文件系统会继续读取该文件所在扇区中**文件内容之后的数据**。这些数据是磁盘上未被清除的残留数据（Dirty Data），即之前的“脏数据”。
  这属于**未初始化内存读取**或**残留信息泄露**漏洞。文件系统把不属于该文件的数据返回给了用户空间。

### B. 用户空间 cat 命令的实现缺陷 (次要原因)
虽然主要责任在内核，但原 `cat` 命令的实现也缺乏健壮性。

- **问题代码**：
  ```c
  int bytes_read = read(file_desc, buffer, sizeof(buffer)); // 只读一次
  if (bytes_read > 0) {
      write(1, buffer, bytes_read);
  }
  ```
- **分析**：
  如果文件大小超过缓冲区大小（1024字节），原代码只能显示前 1024 字节。虽然这不会导致乱码，但功能不完整。

## 3. 修复方案

### A. 修复内核文件系统 (已在代码中修改)
在 `fs/read_write.c` 中，修正 `bytes_left` 的计算逻辑，确保只读取文件范围内的有效数据。

**修改内容**：
```c
// fs/read_write.c
// 修改前：int bytes_left = len;
// 修改后：
int bytes_left = pos_end - pos; // 限制为实际剩余文件大小
```

### B. 修复 cat 命令 (已在代码中修改)
修改 `command/cat.c`，使用循环读取，并确保只处理 `read` 返回的有效字节数。

**修改内容**：
```c
// command/cat.c
int bytes_read;
// 使用循环读取处理大文件
while ((bytes_read = read(file_desc, buffer, sizeof(buffer))) > 0) {
    write(1, buffer, bytes_read); // 只输出实际读取到的字节
}
```

## 4. 涉及的安全漏洞分类
1.  **CWE-200: Exposure of Sensitive Information to an Unauthorized Actor** (信息泄露)：文件系统返回了磁盘上残留的脏数据。
2.  **CWE-125: Out-of-bounds Read** (越界读取)：逻辑上读取了超过文件边界的数据。

---

# Bug 修复报告：remove 命令数据残留问题

## 1. 问题描述
用户发现 `remove` 命令存在数据残留 bug。当删除一个文件后，如果创建一个新文件并分配到相同的磁盘扇区，即使不写入任何内容，新文件也会显示出旧文件的内容。
这表明 `remove` (底层调用 `unlink`) 并没有真正清除磁盘上的数据，只是标记了扇区可用。

## 2. 根本原因分析
在 `fs/link.c` 的 `do_unlink` 函数中，原本的逻辑如下：
1.  清除 inode 位图（i-map）中的对应位。
2.  清除扇区位图（s-map）中的对应位。
3.  清除 inode 表中的数据。
4.  清除目录项。

**缺陷**：代码完全跳过了“清除数据块内容”的步骤。它直接将扇区标记为“空闲”，但扇区内的磁记录仍然保持原样。
这是一个典型的 **数据残留（Data Remanence）** 问题。

## 3. 修复方案
在释放扇区位图之前，先遍历文件占用的所有扇区，并将其内容填充为 0。

**修改内容**：
```c
// fs/link.c :: do_unlink()
// 在释放 s-map 之前添加：

/*************************************************/
/* clear the data bytes (overwrite with zeros)   */
/*************************************************/
int sect_i;
memset(fsbuf, 0, SECTOR_SIZE); // 准备全0缓冲区
for (sect_i = 0; sect_i < pin->i_nr_sects; sect_i++) {
    // 遍历并覆盖每个扇区
    WR_SECT(pin->i_dev, pin->i_start_sect + sect_i);
}
```

## 4. 涉及的安全漏洞分类
1.  **CWE-226: Sensitive Information in Resource Not Removed Before Reuse** (资源复用前未清除敏感信息)：
    系统在释放资源（磁盘扇区）时没有清除其中的敏感信息，导致后续使用者（新文件）可以读取到旧数据。

---

# Bug 修复报告：ps 命令显示异常及 kill 命令逻辑缺陷

## 1. 问题描述
1.  **ps 显示乱码/截断**：使用 `ps` 命令时，部分进程名称显示不全（如 "TestA" 显示为 "staA"），且格式对齐混乱。
2.  **kill 命令异常**：使用 `kill` 命令终止进程后，进程虽然停止，但未经过正常的退出流程，导致资源可能未完全释放，且 `ps` 状态显示可能不正确。

## 2. 根本原因分析

### A. 进程名称缓冲区溢出 (Buffer Overflow)
在 `mm/exec.c` 的 `do_exec` 函数中，设置进程名称时使用了 `strcpy`，且未检查源字符串长度。
- **问题代码**：
  ```c
  strcpy(proc_table[src].name, pathname);
  ```
- **分析**：`proc_table[src].name` 是固定长度（16字节）的数组。如果 `pathname` 超过15个字符，`strcpy` 会导致缓冲区溢出，覆盖相邻进程表项的数据（如 `p_flags` 或下一个进程的 `regs`），导致 `ps` 显示乱码甚至系统崩溃。这是典型的 **CWE-120: Buffer Copy without Checking Size of Input**。

### B. 进程终止流程缺失 (Improper Termination)
`kill` 命令通过发送 `END_WHICH_PROC` 消息给系统任务（TASK_SYS），系统任务直接将进程标记为 `FREE_SLOT`。
- **问题代码** (kernel/systask.c)：
  ```c
  case END_WHICH_PROC:
      proc_table[msg.PID].p_flags = FREE_SLOT; // 直接标记为空闲
      // ...
  ```
- **分析**：这种方式跳过了内存管理任务（TASK_MM）的 `do_exit` 流程。正常的退出流程应该通知父进程（发送 SIGCHLD）、释放内存映像、关闭文件描述符等。直接标记 `FREE_SLOT` 会导致资源泄漏和僵尸进程状态管理混乱。这是 **CWE-404: Improper Resource Shutdown or Release**。

## 3. 修复方案

### A. 修复进程名称溢出 (已在代码中修改)
在 `mm/exec.c` 中，使用 `strncpy` 替代 `strcpy`，并强制添加字符串结束符。

**修改内容**：
```c
// mm/exec.c
// 修改前：strcpy(proc_table[src].name, pathname);
// 修改后：
strncpy(proc_table[src].name, pathname, 16);
proc_table[src].name[15] = 0; // 确保截断
```

### B. 修复 kill 命令流程 (已在代码中修改)
修改 `kernel/systask.c`，在收到 `END_WHICH_PROC` 时，不再直接操作进程表，而是向 TASK_MM 发送 `EXIT` 消息，由 MM 接管清理工作。
同时修改 `mm/forkexit.c` 的 `do_exit` 以支持从系统任务调用的情况（如果需要）。

**修改内容**：
```c
// kernel/systask.c
case END_WHICH_PROC:
    {
        MESSAGE msg2mm;
        msg2mm.type = EXIT;
        msg2mm.STATUS = 0;
        msg2mm.PID = msg.PID;
        send_recv(SEND, TASK_MM, &msg2mm); // 转发给 MM 处理
    }
    // ...
```

## 4. 涉及的安全漏洞分类
1.  **CWE-120: Buffer Copy without Checking Size of Input** (缓冲区溢出)：`strcpy` 导致的进程表破坏。
2.  **CWE-404: Improper Resource Shutdown or Release** (资源释放不当)：绕过正常退出流程导致的潜在资源泄漏。
