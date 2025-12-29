typedef unsigned long ssize_t;
const char *cmd[] = {"echo", "ls", "pwd", "touch", "rm", "ps", "cat"};

// 定义NULL常量（如果未定义）
#ifndef NULL
#define NULL ((void *)0)
#endif

// edit命令实现
// 用于查看、编辑文本文件，运行shell命令
#include "stdio.h"
#include "string.h"
#include "sys/fs.h"
#include "../include/ls.h" // 包含系统常量定义

// 定义O_TRUNC常量（如果未定义）
#ifndef O_TRUNC
#define O_TRUNC 0x0200 /* truncate to zero length */
#endif

// 可执行文件列表（shell命令）
const char *executable_files[] = {"cat", "echo", "kill", "ls", "ps", "pwd", "remove", "touch"};
const int executable_count = 8;

// 字符串转换为整数的函数（从kill.c复制）
int my_atoi(const char *str) {
    int pid = 0;
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
        pid = pid * 10 + (*str - '0');
        str++;
    }

    return sign * pid;
}

// 打印kill命令帮助信息的函数（从kill.c复制）
void print_help() {
    printf("kill - terminate a process\n\n");
    printf("Usage: kill [PID]\n\n");
    printf("Options:\n");
    printf("  --help    display this help and exit\n\n");
    printf("PID must be between 0 and %d\n", NR_TASKS + NR_PROCS - 1);
}

// 检查文件是否为文本文件
int is_text_file(const char *filename)
{
    int fd = open(filename, O_RDWR);
    if (fd == -1)
    {
        return 1; // 文件不存在，默认为文本文件
    }

    char buffer[1024];
    int bytes_read = read(fd, buffer, sizeof(buffer));
    close(fd);

    if (bytes_read <= 0)
    {
        return 1; // 空文件或读取失败，默认为文本文件
    }

    // 检查是否包含非打印字符
    for (int i = 0; i < bytes_read; i++)
    {
        if (buffer[i] == '\0' || (buffer[i] < 32 && buffer[i] != '\n' && buffer[i] != '\r' && buffer[i] != '\t'))
        {
            return 0; // 包含非打印字符，不是文本文件
        }
    }

    return 1; // 是文本文件
}

// 执行shell命令
void execute_command(const char *cmd, int argc, char *argv[])
{
    // 根据命令名执行相应的命令
    if (strcmp(cmd, "cat") == 0)
    {
        // 直接执行cat命令（从cat.c复制）
        int file_desc;
        char buffer[1024]; // 1024字节缓冲区
        int i;

        // 检查是否有文件参数
        if (argc < 2)
        {
            printf("cat: Missing file parameter!\n");
            printf("To use: cat <filename> [filename...]\n");
            return;
        }

        // 循环处理所有指定的文件
        for (i = 1; i < argc; i++)
        {
            // 打开文件
            file_desc = open(argv[i], O_RDWR);

            if (file_desc < 0)
            {
                printf("cat: %s: File does not exist or cannot be opened!\n", argv[i]);
                continue;
            }

            // 手工清空缓冲区，避免残留数据影响
            for (int j = 0; j < sizeof(buffer); j++)
            {
                buffer[j] = '\0';
            }

            // 读取文件内容并输出，直到文件结束
            int bytes_read = read(file_desc, buffer, sizeof(buffer));
            if (bytes_read > 0)
            {
                write(1, buffer, bytes_read);
            }

            if (bytes_read == 0)
            {
                printf("\n");
            }

            // 检查读取错误
            if (bytes_read < 0)
            {
                printf("cat: %s: Read failed!\n", argv[i]);
            }

            printf("\n");
            close(file_desc);
        }
    }
    else if (strcmp(cmd, "echo") == 0)
    {
        // 直接执行echo命令（从echo.c复制）
        int i;
        for (i = 1; i < argc; i++)
            printf("%s%s", i == 1 ? "" : " ", argv[i]);
        printf("\n");
    }
    else if (strcmp(cmd, "kill") == 0)
    {
        // 直接执行kill命令（从kill.c复制）
        if (argc < 2)
        {
            printf("Error: No PID specified\n\n");
            print_help();
            return;
        }

        if (strcmp(argv[1], "--help") == 0)
        {
            print_help();
            return;
        }

        // 将字符串转换为整数
        int pid = my_atoi(argv[1]);

        // 检查PID是否在有效范围内
        if (pid < 0 || pid >= NR_TASKS + NR_PROCS)
        {
            printf("Error: Invalid PID %d\n", pid);
            printf("PID must be between 0 and %d\n", NR_TASKS + NR_PROCS - 1);
            return;
        }

        // 发送终止进程消息
        MESSAGE msg;
        msg.PID = pid;
        msg.type = END_WHICH_PROC;

        // 发送消息并检查结果
        int result = send_recv(BOTH, TASK_SYS, &msg);
        if (result != 0)
        {
            printf("Error: Failed to send kill message (result: %d)\n", result);
            return;
        }

        // 检查kill操作是否成功
        if (msg.RETVAL != 0)
        {
            printf("Error: Failed to kill process %d (RETVAL: %d)\n", pid, msg.RETVAL);
            return;
        }

        // 验证进程是否真的被终止
        struct proc p;
        MESSAGE check_msg;
        check_msg.PID = pid;
        check_msg.type = GET_PROC_INFO;
        check_msg.BUF = &p;

        result = send_recv(BOTH, TASK_SYS, &check_msg);
        if (result == 0)
        {
            if (p.p_flags == FREE_SLOT)
            {
                printf("Process %d killed successfully\n", pid);
            }
            else
            {
                printf("Warning: Process %d still exists with flags 0x%04X\n", pid, p.p_flags);
                printf("Kill command reported success but process is still present\n");
            }
        }
        else
        {
            printf("Process %d kill command sent successfully, but cannot verify status\n", pid);
        }
    }
    else if (strcmp(cmd, "ls") == 0)
    {
        // 定义目录路径，默认为当前目录
        char *dir_path = ".";

        // 检查命令参数
        if (argc > 2)
        {
            printf("ls: Too many arguments\n");
            printf("Usage: ls [directory path]\n");
            return;
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
                return;
            }
            dir_path = argv[1];
        }

        // 打开目录
        int fd = open(dir_path, O_RDWR);
        if (fd == -1)
        {
            printf("ls: Cannot open directory '%s': Directory does not exist or is not accessible\n", dir_path);
            return;
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
            return;
        }

        // 计算有效条目数量
        int entry_count = n / sizeof(struct dir_entry);

        // 统计文件和目录数量
        int file_count = 0, dir_count = 0, total_size = 0;

        struct dir_entry valid_entries[64];
        int valid_count = 0;

        for (int i = 0; i < entry_count; i++)
        {
            if (dir_entries[i].inode_nr != 0)
            {
                valid_entries[valid_count++] = dir_entries[i];
            }
        }

        for (int i = 0; i < valid_count - 1; i++)
        {
            int min_index = i;
            for (int j = i + 1; j < valid_count; j++)
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
        for (int i = 0; i < valid_count; i++)
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
    }
    else if (strcmp(cmd, "ps") == 0)
    {
        // 处理帮助选项
        for (int i = 1; i < argc; i++)
        {
            if (strcmp(argv[i], "--help") == 0 || strcmp(argv[i], "-h") == 0)
            {
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
                return;
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
            if (ret != 0)
            {
                printf("Error: Failed to get process information for PID %d\n", i);
                continue;
            }

            // 检查进程槽位是否被使用
            if (p.p_flags != FREE_SLOT)
            {
                // 确定进程状态
                char status = '?';
                if (p.p_flags & HANGING)
                {
                    status = 'Z'; // Zombie
                }
                else if (p.p_flags & WAITING)
                {
                    status = 'W'; // Waiting
                }
                else if (p.p_flags & SENDING || p.p_flags & RECEIVING)
                {
                    status = 'R'; // Running/Active
                }
                else
                {
                    status = 'S'; // Sleeping/Idle
                }

                // 打印进程信息，使用固定宽度格式
                printf("%5d %10s %c       0x%04X\n",
                       i, p.name, status, p.p_flags);
            }
        }
    }
    else if (strcmp(cmd, "pwd") == 0)
    {
        // 直接执行pwd命令（从pwd.c复制）
        printf("/\n");
    }
    else if (strcmp(cmd, "touch") == 0)
    {
        // 直接执行touch命令（从touch.c复制）
        // 检查命令参数
        if (argc < 2)
        {
            printf("touch: Missing file operand\n");
            printf("Usage: touch [OPTION]... FILE...\n");
            printf("Try 'touch --help' for more information\n");
            return;
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
            return;
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
                // 文件已存在，更新时间戳（这里简化处理，实际应使用utime系统调用）
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

        // 打印操作结果摘要
        if (success_count > 0)
        {
            printf("touch: Successfully processed %d file(s)\n", success_count);
        }
        if (failure_count > 0)
        {
            printf("touch: Failed to process %d file(s)\n", failure_count);
        }
    }
    else if (strcmp(cmd, "remove") == 0 || strcmp(cmd, "rm") == 0)
    {
        // 直接执行remove命令（从remove.c复制）
        // 检查命令参数
        if (argc < 2)
        {
            printf("remove: Missing file operand\n");
            printf("Usage: remove [OPTION]... FILE...\n");
            printf("Try 'remove --help' for more information\n");
            return;
        }
        else if (argc == 2 && (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0))
        {
            // 显示帮助信息
            printf("remove - Remove files or directories\n");
            printf("Usage: remove [OPTION]... FILE...\n");
            printf("Options:\n");
            printf("  --help, -h  Display this help message\n");
            printf("\n");
            printf("Examples:\n");
            printf("  remove file.txt     Remove the file named file.txt\n");
            printf("  remove f1 f2 f3     Remove multiple files\n");
            return;
        }

        int success_count = 0;
        int failure_count = 0;

        // 处理每个文件参数
        for (int i = 1; i < argc; i++)
        {
            const char *filename = argv[i];

            // 尝试删除文件
            if (unlink(filename) == 0)
            {
                printf("Removed '%s'\n", filename);
                success_count++;
            }
            else
            {
                printf("remove: Cannot remove '%s': File does not exist or permission denied\n", filename);
                failure_count++;
            }
        }

        // 打印操作结果摘要
        if (success_count > 0)
        {
            printf("remove: Successfully removed %d file(s)\n", success_count);
        }
        if (failure_count > 0)
        {
            printf("remove: Failed to remove %d file(s)\n", failure_count);
        }
    }
    else
    {
        printf("Unknown command: %s\n", cmd);
        printf("Available commands: cat, echo, kill, ls, ps, pwd, remove, touch\n");
    }
}

int main(int args, char *argv[])
{
    if (args < 2)
    {
        printf("illegal commmand!!!\n");
        printf("please use the comamnd in right format\n");
        return 0;
    }

    // 检查是否为可执行文件（shell命令）
    for (int i = 0; i < executable_count; i++)
    {
        if (strcmp(argv[1], executable_files[i]) == 0)
        {
            // 调整argv数组，使argv[0]成为命令名
            char *new_argv[args];
            new_argv[0] = argv[1];
            for (int j = 1; j < args - 1; j++)
            {
                new_argv[j] = argv[j + 1];
            }
            new_argv[args - 1] = NULL;
            // 调用execute_command，注意参数数量要减1
            execute_command(argv[1], args - 1, new_argv);
            return 0;
        }
    }

    // 先处理文件创建和编辑操作
    if (args == 2)
    {
        // 查看文件内容或创建空文件
        int fd = open(argv[1], O_RDWR);
        if (fd != -1)
        {
            // 文件存在，查看内容
            char buffer[1024];
            int bytes_read = read(fd, buffer, sizeof(buffer));
            if (bytes_read > 0)
            {
                printf("Content of %s:\n", argv[1]);
                printf("----------------------------------------\n");
                write(1, buffer, bytes_read);
                printf("\n----------------------------------------\n");
            }
            else
            {
                printf("File %s is empty.\n", argv[1]);
            }
            close(fd);
            return 0;
        }
        else
        {
            // 文件不存在，创建空文件
            fd = open(argv[1], O_CREAT | O_RDWR);
            if (fd == -1)
            {
                printf("Failed to create %s. Please check.\n", argv[1]);
                return 1;
            }
            printf("Successfully created %s.\n", argv[1]);
            close(fd);
            return 0;
        }
    }
    else if (args == 3)
    {
        // 编辑文件内容或创建带内容的文件
        // 首先检查文件是否存在
        int fd = open(argv[1], O_RDWR);
        if (fd != -1) {
            // 文件存在，先关闭它
            close(fd);
            // 删除文件
            unlink(argv[1]);
        }
        // 创建新文件
        fd = open(argv[1], O_CREAT | O_RDWR);
        if (fd == -1) {
            printf("Failed to open %s for writing.\n", argv[1]);
            return 1;
        }
        // 写入内容
        write(fd, argv[2], strlen(argv[2]));
        close(fd);
        printf("Successfully updated %s with content: %s\n", argv[1], argv[2]);
        return 0;
    }
    else if (args == 4 && strcmp(argv[2], "-a") == 0)
    {
        // 追加内容到文件（如果文件不存在则创建）
        int fd = open(argv[1], O_RDWR);
        if (fd == -1)
        {
            // 文件不存在，创建新文件
            fd = open(argv[1], O_CREAT | O_RDWR);
            if (fd == -1)
            {
                printf("Failed to open %s. Please check.\n", argv[1]);
                return 1;
            }
            
            // 新文件直接写入内容
            const char *content = argv[3];
            ssize_t written = write(fd, content, strlen(content));
            if (written == -1)
            {
                printf("Failed to write to %s.\n", argv[1]);
                close(fd);
                return 1;
            }
            printf("Successfully appended to %s: %s\n", argv[1], content);
            close(fd);
            return 0;
        }
        
        // 文件存在，读取文件内容
        char buffer[4096] = {0};
        ssize_t total_size = 0;
        ssize_t read_size;
        
        // 读取文件内容（最多4095字节）
        read_size = read(fd, buffer, sizeof(buffer) - 1);
        if (read_size > 0)
        {
            total_size = read_size;
        }
        
        // 关闭文件
        close(fd);
        
        // 重新打开文件（截断模式）
        fd = open(argv[1], O_RDWR | O_TRUNC);
        if (fd == -1)
        {
            printf("Failed to reopen %s.\n", argv[1]);
            return 1;
        }
        
        // 先写入原内容
        if (total_size > 0)
        {
            ssize_t written = write(fd, buffer, total_size);
            if (written == -1)
            {
                printf("Failed to write original content to %s.\n", argv[1]);
                close(fd);
                return 1;
            }
        }
        
        // 再写入新内容
        const char *content = argv[3];
        ssize_t written = write(fd, content, strlen(content));
        if (written == -1)
        {
            printf("Failed to append to %s.\n", argv[1]);
            close(fd);
            return 1;
        }
        
        printf("Successfully appended to %s: %s\n", argv[1], content);
        close(fd);
        return 0;
    }

    printf("Unknown command or invalid usage.\n");
    return 1;
}
