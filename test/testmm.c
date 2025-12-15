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
#include "test/testmm.h"
void testmm()
{
    // test translation
    // 测试连续unmap dealloc 连续alloc map
    u32 la = 0x300000;
    printl("\ndeallocated: ");
    for (int i = 0; i < 5; i++)
    {
        u32 tmp = la + i * 0x1000;
        u32 pa = la2pa(tmp);
        FrameTracker *ft = unmap(tmp);
        frame_dealloc(ft);
        printl("0x%x ", ft->phybase);
    }
    u32 tmp = 0x290000;
    u32 pa = la2pa(tmp);
    FrameTracker *ft = unmap(tmp);
    frame_dealloc(ft);
    printl("0x%x ", ft->phybase);
    printl("\nmapped: ");
    for(int i = 0; i < 5; i++)
    {
        u32 tmp = la + i * 0x1000;
        FrameTracker *ft = frame_alloc();
        map(tmp, ft);
        printl("0x%x->0x%x ", tmp, la2pa(tmp));
    }


}