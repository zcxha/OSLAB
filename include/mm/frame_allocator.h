/* 沿用几个月前版本的位图法，实现比其他的简单啊，。、 */

#define FRAME_SIZE 4096
#define FRAME_COUNT 1024*1024 // 4G

typedef struct FrameTracker{
    u8 count; // 引用计数，用于多任务情况下共享问题。
    u8 in_use; // 这个4k的块是否正在使用
    u32 phybase; // 这个frame对应的物理地址
}FrameTracker;

/*
    初始化tracker
*/
void init_frametracker();

/*
    参考并斟酌了一下，暂时不实现连续页分配
*/

/*
    分配一帧，返回帧
*/
FrameTracker *frame_alloc();

/*
    取消分配，让帧空闲
*/
void frame_dealloc(FrameTracker *ft);

FrameTracker *frame_find(void *pa);