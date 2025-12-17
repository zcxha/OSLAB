/*
    因为汇编是早期（3个月前）编写，代码难以维护，于是重写成c的形式。 - lsl
    TODO可优化的思路：使用某种优先数据结构(Ping heng shu)组织，以地址为键。
*/
#include "type.h"
#include "const.h"
#include "protect.h"
#include "string.h"
#include "rbtree.h"
#include "proc.h"
#include "tty.h"
#include "console.h"
#include "proto.h"
#include "mm/aspace.h"
#include "mm/frame_allocator.h"
#include "mm/page_table.h"
#include "global.h"

void init_frametracker()
{
    for(int i = 0; i < FRAME_COUNT; i++)
    {
        phy_frames[i].count = phy_frames[i].in_use = 1; // 因为ldr默认把所有都direct 映射了一遍
        phy_frames[i].phybase = i * FRAME_SIZE; // 后续会把用户地址空间直接count--,dealloc。但不unmap
        // 也就是说内核始终是所有物理地址的恒等映射。
    }
}

FrameTracker *frame_alloc()
{
    for(int i = 0; i < FRAME_COUNT; i++)
    {
        if(phy_frames[i].in_use == 0)
        {
            phy_frames[i].in_use = 1;

            return &phy_frames[i];
        }
    }
    disp_str("no phy frame");
    panic("no phy frame to alloc.");
}

void frame_dealloc(FrameTracker *ft)
{
    assert(ft->count == 0);

    ft->in_use = 0;
}

/*
    TODO:本来以为不会再接触到phybase，结果unmap就来了。
    那么之后考虑用红黑树结点去查找node再释放吧。(线性查找其实也行（？？？maybe outer O(n), causes O(nm)）)
*/
FrameTracker *frame_find(void *pa)
{
    // disp_int((u32)pa &0xFFFFF000);
    for(int i = 0; i < FRAME_COUNT; i++)
    {
        if(phy_frames[i].phybase == ((u32)pa & 0xFFFFF000))
        {
            return &phy_frames[i];
        }
    }
    disp_str("can't find frame");
    panic("can't find frame to unmap.");
}