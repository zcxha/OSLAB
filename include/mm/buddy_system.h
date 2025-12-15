#include "type.h"
// 节点数量。
#define BUDDY_ORDER 32

// 叶子结点32字节
#define LEAF_SIZE 32

/*
    二叉树第i层（从0开始）节点编号[2^i, 2^(i+1) - 1]
    所以根节点目前是32*2^5字节的大小1K
*/

typedef struct ListNode {
    /*
        id of current node, when deallocate blocks, needs to use this. see 
        https://stackoverflow.com/questions/1957099/what-happens-when-you-call-free-with-a-pointer-to-the-middle-of-the-allocation
    */
    /*
        选择记录id可以确保块能链入它分配的时候属于的节点的list，
        但是不一定能跟同样大小的节点进行合并。
        选择记录大小就完全随机它能链入到哪里。
        这里先选择id试试看

        upd: 同一个id下有多个同大小块也是可以合并的。
    */
    
    u32 addr;
    u32 size;    

    struct ListNode *prev; // previous
    struct ListNode *next; // next
}ListNode;

typedef struct ListHead {
    ListNode *head;
}ListHead;

/*
    Buddy Binary Tree, the buddy of node i, is i^1. 
    第一层最大，第二层是/2，第三层是/4
    https://en.wikipedia.org/wiki/Buddy_memory_allocation
*/
typedef struct BTree {
    ListHead nodes[BUDDY_ORDER];
}BTree;

/* mem Layout */
typedef struct Layout {
    // size of the requested block of memory, measured in bytes
    u32 size;


    // alignment of the requested block of memory, measured in bytes.
    // we ensure that this is always a power-of-two, because API's
    // like `posix_memalign` require it and it is a reasonable
    // constraint to impose on Layout constructors.
    //
    // (However, we do not analogously require `align >= sizeof(void*)`,
    //  even though that is *also* a requirement of `posix_memalign`.)
    u32 align; // unused
}Layout;