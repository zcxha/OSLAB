// ps命令实现
// 用于显示当前系统中的进程信息
#include "../include/ls.h"

/**
 * ps命令的主函数
 * 显示当前系统中的进程信息
 * 
 * @param argc 命令参数个数
 * @param argv 命令参数数组
 * @return 执行结果，0表示成功，非0表示失败
 */
int main(int argc, char* argv[]) 
{
    // 处理帮助选项
    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0) {
            printf("ps - Report a snapshot of the current processes\n");
            printf("Usage: ps [OPTION]...\n");
            printf("Display information about the currently running processes\n");
            printf("\n");
            printf("Options:\n");
            printf("  --help     Display this help and exit\n");
            printf("  -h         Same as --help\n");
            printf("\n");
            printf("Output format:\n");
            printf("  PID   NAME       STATUS  FLAGS\n");
            printf("  Process ID, process name, process status, process flags\n");
            printf("\n");
            printf("Status codes:\n");
            printf("  R  Running\n");
            printf("  S  Sleeping\n");
            printf("  W  Waiting\n");
            printf("  Z  Zombie\n");
            printf("\n");
            return 0;
        }
    }
    
    MESSAGE msg;
    struct proc p;
    
    // 打印表头
    printf("PID   NAME       STATUS  FLAGS\n");
    printf("--------------------------------\n");
    
    // 遍历所有进程槽位
    int i;
    for (i = 0; i < NR_TASKS + NR_PROCS; i++) 
    {
        msg.PID = i;
        msg.type = GET_PROC_INFO;
        msg.BUF = &p;
        
        // 发送消息获取进程信息
        int ret = send_recv(BOTH, TASK_SYS, &msg);
        if (ret != 0) {
            printf("Error: Failed to get process information for PID %d\n", i);
            continue;
        }
        
        // 检查进程槽位是否被使用
        if (p.p_flags != FREE_SLOT) 
        {
            // 确定进程状态
            char status = '?';
            if (p.p_flags & HANGING) {
                status = 'Z'; // Zombie
            } else if (p.p_flags & WAITING) {
                status = 'W'; // Waiting
            } else if (p.p_flags & SENDING || p.p_flags & RECEIVING) {
                status = 'R'; // Running/Active
            } else {
                status = 'S'; // Sleeping/Idle
            }
            
            // 打印进程信息，使用固定宽度格式
            printf("%5d %10s %c       0x%04X\n", 
                   i, p.name, status, p.p_flags);
        }
    }
    
    return 0;
}
