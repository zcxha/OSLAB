// rm命令实现
// 用于删除一个或多个文件
#include "stdio.h"
#include "string.h"
#include "sys/fs.h"

/**
 * rm命令的主函数
 * 删除指定的一个或多个文件
 * 
 * @param args 命令参数个数
 * @param argv 命令参数数组
 * @return 执行结果，0表示成功，非0表示失败
 */
int main(int args, char* argv[])
{
    // 检查命令参数
    if (args < 2)
    {
        printf("rm: Missing file operand\n");
        printf("Usage: rm [OPTION]... FILE...\n");
        printf("Try 'rm --help' for more information\n");
        return 1;
    }
    
    // 处理帮助选项
    if (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0)
    {
        printf("rm - Remove files\n");
        printf("Usage: rm [OPTION]... FILE...\n");
        printf("Remove specified files\n");
        printf("\n");
        printf("Options:\n");
        printf("  --help     Display this help and exit\n");
        printf("  -h         Same as --help\n");
        printf("\n");
        printf("Examples:\n");
        printf("  rm file.txt          Remove a single file\n");
        printf("  rm file1.txt file2.txt  Remove multiple files\n");
        return 0;
    }
    
    // 初始化统计变量
    int success_count = 0;
    int failure_count = 0;
    
    // 处理每个文件参数
    for (int i = 1; i < args; i++)
    {
        // 跳过帮助选项（已经处理过）
        if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0)
        {
            continue;
        }
        
        // 尝试删除文件
        printf("rm: Removing '%s'...\n", argv[i]);
        
        // 直接调用unlink删除文件
        int result = unlink(argv[i]);
        if (result == -1)
        {
            printf("rm: Cannot remove '%s': No such file or directory\n", argv[i]);
            failure_count++;
        }
        else
        {
            printf("rm: Successfully removed '%s'\n", argv[i]);
            success_count++;
        }
        
        // 混合延时策略：结合系统调用切换和CPU循环
        // 目的：防止连续快速的 unlink 调用导致文件系统或磁盘驱动处理不过来（特别是在仿真器中）
        volatile int delay_i, delay_j;
        for (delay_i = 0; delay_i < 200; delay_i++) {
            getpid(); // 触发上下文切换，让出 CPU 给 FS/HD 进程
            for (delay_j = 0; delay_j < 5000; delay_j++); // 插入微小延时
        }
    }
    
    // 输出操作总结
    if (failure_count == 0)
    {
        printf("rm: Successfully removed %d file(s)\n", success_count);
    }
    else
    {
        printf("rm: Removed %d file(s), %d failed\n", success_count, failure_count);
    }
    
    // 返回执行结果
    return failure_count > 0 ? 1 : 0;
}
