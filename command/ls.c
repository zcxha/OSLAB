#include "../include/ls.h"

/**
 * 列出目录内容的命令实现
 * 支持列出指定目录的内容，显示文件名、大小等信息
 * 
 * @param argc 命令参数个数
 * @param argv 命令参数数组
 * @return 执行结果，0表示成功，非0表示失败
 */
int main(int argc, char *argv[]) 
{
    // 定义目录路径，默认为当前目录
    char *dir_path = ".";
    
    // 检查命令参数
    if (argc > 2) 
    {
        printf("ls: Too many arguments\n");
        printf("Usage: ls [directory path]\n");
        return 1;
    }
    else if (argc == 2) 
    {
        // 如果指定了目录路径
        if (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0) 
        {
            printf("ls - List directory contents\n");
            printf("Usage: ls [directory path]\n");
            printf("Options:\n");
            printf("  --help, -h  Display this help message\n");
            return 0;
        }
        dir_path = argv[1];
    }
    
    // 打开目录
    int fd = open(dir_path, O_RDWR);
    if (fd == -1) 
    {
        printf("ls: Cannot open directory '%s': Directory does not exist or is not accessible\n", dir_path);
        return 1;
    }
    
    // 定义目录条目结构和数组
    struct dir_entry 
    {
        int inode_nr;
        char name[12];
    } dir_entries[64];
    
    // 读取目录内容
    int n = read(fd, dir_entries, sizeof(dir_entries));
    if (n == -1) 
    {
        printf("ls: Failed to read directory '%s'\n", dir_path);
        close(fd);
        return 1;
    }
    
    // 计算有效条目数量
    int entry_count = n / sizeof(struct dir_entry);
    
    // 统计文件和目录数量
    int file_count = 0, dir_count = 0, total_size = 0;
    
    // 优化：先收集有效条目，提高后续处理效率
    struct dir_entry valid_entries[64];
    int valid_count = 0;
    int i, j;
    
    for (i = 0; i < entry_count; i++) 
    {
        if (dir_entries[i].inode_nr != 0) 
        {
            valid_entries[valid_count++] = dir_entries[i];
        }
    }
    
    // 优化：使用选择排序代替冒泡排序，提高排序效率
    for (i = 0; i < valid_count - 1; i++) 
    {
        int min_index = i;
        for (j = i + 1; j < valid_count; j++) 
        {
            if (strcmp(valid_entries[j].name, valid_entries[min_index].name) < 0) 
            {
                min_index = j;
            }
        }
        if (min_index != i) 
        {
            struct dir_entry temp = valid_entries[i];
            valid_entries[i] = valid_entries[min_index];
            valid_entries[min_index] = temp;
        }
    }
    
    // 打印目录信息
    printf("Directory: %s\n", dir_path);
    printf("===============================================\n");
    
    // 打印表头（使用手动对齐）
    printf("Name          Type        Size(bytes)     Perms\n");
    printf("------------- ----------- ------------    --------\n");
    
    // 遍历并显示目录条目
    for (i = 0; i < valid_count; i++) 
    {
        struct stat file_stat;
        if (stat(valid_entries[i].name, &file_stat) == 0) 
        {
            // 确定文件类型
            char type_str[12] = "File";
            if ((file_stat.st_mode & I_TYPE_MASK) == I_DIRECTORY) 
            {
                strcpy(type_str, "Directory");
                dir_count++;
            } 
            else 
            {
                file_count++;
                total_size += file_stat.st_size;
            }
            
            // 简单的权限显示
            char perm_str[4] = "rwx";
            
            // 打印格式化输出（使用手动空格对齐）
            printf("%13s ", valid_entries[i].name);
            printf("%11s ", type_str);
            printf("%12d ", file_stat.st_size);
            printf("%8s\n", perm_str);
        } 
        else 
        {
            printf("%13s ", valid_entries[i].name);
            printf("%11s ", "Unknown");
            printf("%12s ", "Error");
            printf("%8s\n", "-");
        }
    }
    
    // 打印目录统计信息
    printf("===============================================\n");
    printf("Total entries: %d\n", valid_count);
    printf("Directories: %d\n", dir_count);
    printf("Files: %d\n", file_count);
    printf("Total file size: %d bytes\n", total_size);
    
    // 关闭目录文件描述符
    close(fd);
    return 0;
}
