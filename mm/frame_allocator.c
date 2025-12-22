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
        phy_frames[i].run_node.key = phy_frames[i].phybase;
        phy_frames[i].run_node.entity = &phy_frames[i];
    }
}

FrameTracker *frame_alloc()
{
    FrameTracker *ft = __pick_first_entity(&frame_tree);
    
    if(ft == NULL)
    {
        disp_str("no ft");
        panic("no frame tracker in rbtree.");
    }
    else
    {
        ft->in_use = 1;
        rb_delete(&frame_tree, &ft->run_node);
    }
    return ft;
}

void frame_dealloc(FrameTracker *ft)
{
    assert(ft->count == 0);

    ft->in_use = 0;

    rb_insert(&frame_tree, &ft->run_node);
}

/*
    TODO:本来以为不会再接触到phybase，结果unmap就来了。
    那么之后考虑用红黑树结点去查找node再释放吧。(线性查找其实也行（？？？maybe outer O(n), causes O(nm)）)
*/
FrameTracker *frame_find(void *pa)
{
    // disp_int((u32)pa &0xFFFFF000);
    pa = (u32)pa & 0xFFFFF000;
    u32 idx = (u32)pa / FRAME_SIZE;
    if(pa != phy_frames[idx].phybase) panic("not eq");
    if(idx >= FRAME_COUNT) panic("can't find frame.");
    return &phy_frames[idx];
}