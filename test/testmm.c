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
    u32 la = 0x300000;
    u32 pa = la2pa(la);
    printl("la2pa: %x ", pa);

    FrameTracker *ft = unmap(la);
    printl("unmapped: %x inuse:%x count:%x ", ft->phybase, ft->in_use, ft->count);
    // pa = la2pa(la); // 预计panic。、
    // printl("la2pa: %x ", pa);

    frame_dealloc(ft);

    ft = frame_alloc();

    printl("allocated frame: %x inuse:%x count:%x ", ft->phybase, ft->in_use, ft->count);

    map(la, ft);

    printl("mapped frame: %x inuse:%x count:%x ", ft->phybase, ft->in_use, ft->count);

    pa = la2pa(la);
    printl("la2pa: %x ", pa);
}