#include "type.h"
#include "stdio.h"

#define DINO_X 5
#define WIDTH 60

int main(int argc, char *argv[])
{
    // Config
    int width = WIDTH;
    
    // State
    int score = 0;
    int dino_y = 0; // 0 = ground, >0 = air
    int jump_timer = 0;
    int obstacle_x = WIDTH;
    int last_tick = 0;
    int speed = 3;  // Fast updates
    int jump_duration = 15; // Long jump
    
    char line[WIDTH + 1];
    char buffer[128];
    int i;
    int t;
    
    printf("Dino Game! Press SPACE to jump. Press 'q' to quit.\n");
    
    // Initial wait to let user see the message
    t = logcontrol(100, 0, (void*)0);
    while (logcontrol(100, 0, (void*)0) - t < 50) {}

    // Reset loop
    while(1) {
        score = 0;
        dino_y = 0;
        jump_timer = 0;
        obstacle_x = width;
        speed = 5; // Reset speed on restart
        last_tick = logcontrol(100, 0, (void*)0);
        
        // Wait for start
        printf("\nPress SPACE to Start!");
        while(1) {
             int k = logcontrol(200, 0, (void*)0);
             if (k != 0 && (char)k == ' ') break;
             if (k != 0 && (char)k == 'q') return 0;
        }
        printf("\r%60s\r", " "); // Clear line

        while (1) {
            // Timing
            int current_tick = logcontrol(100, 0, (void*)0);
            
            // Polling input while waiting
            do {
                 // Wake up TTY to process input immediately
                 printf("");

                 int key = logcontrol(200, 0, (void*)0);
                 while (key != 0) {
                     char ch = (char)(key & 0xFF);
                     if (ch == 'q') return 0;
                     if (ch == ' ' && dino_y == 0) {
                         dino_y = 1;
                         jump_timer = jump_duration;
                     }
                     key = logcontrol(200, 0, (void*)0);
                 }
                 current_tick = logcontrol(100, 0, (void*)0);
            } while (current_tick - last_tick < speed);
            
            last_tick = current_tick;
            
            // Logic
            if (dino_y > 0) {
                jump_timer--;
                if (jump_timer <= 0) dino_y = 0;
            }
            
            obstacle_x--;
            if (obstacle_x < 0) {
                obstacle_x = width;
                score++;
                if (score % 5 == 0 && speed > 1) speed--;
            }
            
            // Collision
            if (obstacle_x == DINO_X && dino_y == 0) {
                printf("\rGame Over! Score: %d. Press SPACE to restart.\n", score);
                break; // Break inner loop to restart
            }
            
            // Render
            for (i = 0; i < width; i++) {
                line[i] = '_';
            }
            line[width] = 0;
            
            if (dino_y == 0) line[DINO_X] = '@'; // Ground
            else line[DINO_X] = '^'; // Air (visual difference)
            
            if (obstacle_x >= 0 && obstacle_x < width) {
                line[obstacle_x] = '#';
            }
            
            // Use \r to return to start of line, then print buffer.
            sprintf(buffer, "\rScore: %d %s  ", score, line);
            printf("%s", buffer);
        }
    }
    return 0;
}
