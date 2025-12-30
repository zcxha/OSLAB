#include "stdio.h"
#include "string.h"

#define LOGBUF_SIZE 4096

int main(int argc, char * argv[])
{
    if (argc < 2) {
        printf("Usage: log [process|file|syscall|device] [0|1]\n");
        printf("       log show\n");
        return 0;
    }

    if (strcmp(argv[1], "show") == 0) {
        char buf[LOGBUF_SIZE];
        int pos = logcontrol(999, LOGBUF_SIZE, buf);
        
        /* The buffer is a ring buffer in kernel, copied to 'buf'.
           'pos' is the index of the next write (oldest data if full).
           We linearize it to print correctly.
        */
        char linear[LOGBUF_SIZE + 1];
        int i;
        for (i = 0; i < LOGBUF_SIZE; i++) {
            linear[i] = buf[(pos + i) % LOGBUF_SIZE];
        }
        linear[LOGBUF_SIZE] = 0;
        
        /* Find the start of the last 10 lines */
        int lines = 0;
        int start_index = 0;
        /* Scan backwards */
        /* Skip trailing nulls/newlines if any? */
        /* Since it's a ring buffer, unused parts might be 0. 
           But if we linearize from 'pos', the 0s will be at the beginning (oldest) if buffer not full.
           Wait, if buffer is not full, 'pos' points to next free.
           Everything from 'pos' to end of 'buf' might be 0 or garbage?
           No, if not full, we started at 0. 'pos' is where we are.
           buf[0] to buf[pos-1] is valid.
           buf[pos] to buf[end] is 0 (since global var).
           So linearization:
           buf[(pos + i)%SIZE]
           i=0 -> buf[pos] (which is 0).
           ...
           i=SIZE-pos -> buf[0] (valid).
           So 'linear' will have 0s at the beginning, then data.
        */
        
        /* Optimization: Just print. The 0s won't print. */
        /* But we want last 10 lines. */
        
        /* Let's find the *real* end of data. 
           It is always at the end of 'linear' buffer (because we rotated it so newest is at end).
        */
        
        /* Count newlines from end */
        /* Note: linear contains 0s at start if not full. That's fine. */
        
        for (i = LOGBUF_SIZE - 1; i >= 0; i--) {
            if (linear[i] == '\0') continue; /* Skip nulls if any (shouldn't be any at the end unless the log message inserted a null?) */
            
            if (linear[i] == '\n') {
                lines++;
                if (lines > 10) {
                    start_index = i + 1;
                    break;
                }
            }
        }
        
        printf("%s", &linear[start_index]);
        return 0;
    }

    if (argc < 3) {
        printf("Usage: log [process|file|syscall|device] [0|1]\n");
        return 0;
    }

    int what = 0;
    if (strcmp(argv[1], "process") == 0) what = 1;
    else if (strcmp(argv[1], "file") == 0) what = 2;
    else if (strcmp(argv[1], "syscall") == 0) what = 3;
    else if (strcmp(argv[1], "device") == 0) what = 4;
    else {
        printf("Unknown target: %s\n", argv[1]);
        return 1;
    }

    int status = 0;
    if (strcmp(argv[2], "1") == 0) status = 1;
    else if (strcmp(argv[2], "0") == 0) status = 0;
    else {
        printf("Invalid status: %s\n", argv[2]);
        return 1;
    }

    if (logcontrol(what, status, 0) == 0) {
        printf("System log: [%s] %s\n", argv[1], status ? "enabled" : "disabled");
    } else {
        printf("System log: [%s] failed to set\n", argv[1]);
    }
    return 0;
}
