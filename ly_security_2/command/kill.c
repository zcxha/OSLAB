// 此程序用于通过PID终止进程
#include "../include/ls.h"

/**
 * 将字符串转换为整数
 * @param str 要转换的字符串
 * @return 转换后的整数值
 */
int my_atoi(const char* str) 
{
    int result = 0;
    int sign = 1;

    // 跳过空白字符
    while (*str == ' ' || *str == '\t' || *str == '\n') {
        str++;
    }

    // 检查符号
    if (*str == '-') {
        sign = -1;
        str++;
    } else if (*str == '+') {
        str++;
    }

    // 转换数字
    while (*str >= '0' && *str <= '9') {
        result = result * 10 + (*str - '0');
        str++;
    }

    return sign * result;
}

/**
 * 打印帮助信息
 */
void print_help() {
    printf("kill - terminate a process\n\n");
    printf("Usage: kill [PID]\n\n");
    printf("Options:\n");
    printf("  --help    display this help and exit\n\n");
    printf("PID must be between 0 and %d\n", NR_TASKS + NR_PROCS - 1);
}

/**
 * 主函数
 * @param argc 参数数量
 * @param argv 参数数组
 * @return 执行结果
 */
int main(int argc, char* argv[]) 
{
    if (argc < 2) {
        printf("Error: No PID specified\n\n");
        print_help();
        return -1;
    }

    if (strcmp(argv[1], "--help") == 0) {
        print_help();
        return 0;
    }

    int pid = my_atoi(argv[1]);

    // 检查PID是否在有效范围内
    if (pid < 0 || pid >= NR_TASKS + NR_PROCS) {
        printf("Error: Invalid PID %d\n", pid);
        printf("PID must be between 0 and %d\n", NR_TASKS + NR_PROCS - 1);
        return -1;
    }

    // 发送终止进程消息
    MESSAGE msg;
    msg.PID = pid;
    msg.type = END_WHICH_PROC; 

    // 发送消息并检查结果
    int result = send_recv(BOTH, TASK_SYS, &msg);
    if (result != 0) {
        printf("Error: Failed to send kill message (result: %d)\n", result);
        return -1;
    }

    // 检查kill操作是否成功
    if (msg.RETVAL != 0) {
        printf("Error: Failed to kill process %d (RETVAL: %d)\n", pid, msg.RETVAL);
        return -1;
    }

    // 验证进程是否真的被终止
    struct proc p;
    MESSAGE check_msg;
    check_msg.PID = pid;
    check_msg.type = GET_PROC_INFO;
    check_msg.BUF = &p;
    
    result = send_recv(BOTH, TASK_SYS, &check_msg);
    if (result == 0) {
        if (p.p_flags == FREE_SLOT) {
            printf("Process %d killed successfully\n", pid);
        } else {
            printf("Warning: Process %d still exists with flags 0x%04X\n", pid, p.p_flags);
            printf("Kill command reported success but process is still present\n");
        }
    } else {
        printf("Process %d kill command sent successfully, but cannot verify status\n", pid);
    }

    return 0;
}
