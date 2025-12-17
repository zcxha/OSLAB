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
#include "mm/heap_allocator.h"
#include "mm/page_table.h"
#include "global.h"
#include "test/testmm.h"
void test_frame_pgtable()
{
    // test translation
    // 测试连续unmap dealloc 连续alloc map
    u32 la = 0x300000;
    printl("\ndeallocated: ");
    for (int i = 0; i < 5; i++)
    {
        u32 tmp = la + i * 0x1000;
        u32 pa = la2pa(tmp);
        printl("pa: %x ", pa);
        FrameTracker *ft = unmap(tmp);
        printl("tracker phybase:%x in_use:%x count:%x\n", ft->phybase, ft->in_use, ft->count);
        frame_dealloc(ft);
        printl("0x%x ", ft->phybase);
    }
    u32 tmp = 0x290000;
    u32 pa = la2pa(tmp);
    FrameTracker *ft = unmap(tmp);
    frame_dealloc(ft);
    printl("0x%x ", ft->phybase);
    for (int i = 0; i < 5; i++)
    {
        u32 tmp = la + i * 0x1000;
        FrameTracker *ft = frame_alloc();
        printl("got tracker phybase:%x in_use:%x count:%x \n", ft->phybase, ft->in_use, ft->count);
        map(tmp, ft);
        printl("mapped: 0x%x->0x%x\n", tmp, la2pa(tmp));
    }
}

void test_malloc_free()
{
    u32 *arr = malloc(sizeof(u32) * 64);
    for (int i = 0; i < 64; i++)
    {
        *(arr + i) = 0;
    }
    free(arr);
}

void testmm()
{
    test_frame_pgtable();
    test_malloc_free();
}