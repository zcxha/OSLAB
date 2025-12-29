#include "stdio.h"
#include "string.h"

/**
 * 显示文件内容的命令实现
 * 支持显示文件内容，可同时处理多个文件
 * 
 * @param argc 命令参数个数
 * @param argv 命令参数数组
 * @return 执行结果，0表示成功，非0表示失败
 */
int main(int argc, char *argv[])
{
    int file_desc;
    char buffer[1024];  // 1024字节缓冲区
    int i;
    
    // 检查是否有文件参数
    if (argc < 2) {
        printf("cat: Missing file parameter!\n");
        printf("To use: cat <filename> [filename...]\n");
        return 1;
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
        for (int j = 0; j < sizeof(buffer); j++) {
            buffer[j] = '\0';
	}

        // 循环读取文件内容并输出，直到文件结束
        // 修复：使用循环读取，并检查read返回值，避免缓冲区残留和未初始化数据问题
        int bytes_read;
        while ((bytes_read = read(file_desc, buffer, sizeof(buffer))) > 0)
        {
            write(1, buffer, bytes_read);
        }

        if (bytes_read < 0) {
             printf("cat: %s: Read failed!\n", argv[i]);
        }
        else {
             printf("\n");
        }
        
        printf("\n");
        close(file_desc);
    }
    
	/*test kill
	while (1){
	;
	}
	*/

    return 0;
}
