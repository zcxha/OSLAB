// touch命令实现
// 用于创建新文件或更新现有文件的时间戳
#include "stdio.h"
#include "string.h"

/**
 * touch命令的主函数
 * 支持创建新文件或更新现有文件的时间戳
 * 
 * @param argc 命令参数个数
 * @param argv 命令参数数组
 * @return 执行结果，0表示成功，非0表示失败
 */
int main(int argc, char *argv[]) 
{
    // 检查命令参数
    if (argc < 2) 
    {
        printf("touch: Missing file operand\n");
        printf("Usage: touch [OPTION]... FILE...\n");
        printf("Try 'touch --help' for more information\n");
        return 1;
    }
    else if (argc == 2 && (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0)) 
    {
        // 显示帮助信息
        printf("touch - Create empty files or update file timestamps\n");
        printf("Usage: touch [OPTION]... FILE...\n");
        printf("Options:\n");
        printf("  --help, -h  Display this help message\n");
        printf("\n");
        printf("Examples:\n");
        printf("  touch file.txt     Create an empty file named file.txt\n");
        printf("  touch f1 f2 f3     Create multiple files\n");
        return 0;
    }
    
    int success_count = 0;
    int failure_count = 0;
    
    // 处理每个文件参数
    for (int i = 1; i < argc; i++) 
    {
        const char *filename = argv[i];
        
        // 尝试以读写模式打开文件
        int fd = open(filename, O_RDWR);
        if (fd != -1) 
        {
            // 文件已存在，更新时间戳
            close(fd);
            printf("Updated timestamp for '%s'\n", filename);
            success_count++;
        }
        else 
        {
            // 文件不存在，创建新文件
            fd = open(filename, O_CREAT);
            if (fd != -1) 
            {
                close(fd);
                printf("Created file '%s'\n", filename);
                success_count++;
            }
            else 
            {
                printf("touch: Cannot create file '%s': Permission denied or invalid path\n", filename);
                failure_count++;
            }
        }
    }
    
    // 打印操作总结
    if (failure_count == 0) 
    {
        printf("touch: Successfully processed %d file(s)\n", success_count);
        return 0;
    }
    else 
    {
        printf("touch: Processed %d file(s), %d failed\n", success_count, failure_count);
        return 1;
    }
}
