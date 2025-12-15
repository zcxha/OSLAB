#include "type.h"
#include "mm/aspace.h"
#include "mm/buddy_system.h"

u32 log_2(u32 i)
{
    u32 ans = 0;
    while (i != 1)
    {
        i = i / 2;
        ans++;
    }
    return ans;
}

u32 pow_2(u32 i)
{
    u32 ans = 1;
    while (i)
    {
        ans = ans * 2;
        i--;
    }
    return ans;
}

void buddy_list_insert(ListHead *head, ListNode *node)
{
    ListNode *headnode = head->head;

    node->prev = NULL;
    node->next = NULL;

    if (!headnode)
    {
        head->head = node;
    }
    else
    {
        headnode->prev = node;
        node->next = headnode;
        
        head->head = node;
    }
}

/* buddy allocator tree */
BTree buddy_tree;

/*
    把堆空间初始化到根节点
*/
void buddy_init()
{
    u32 size = HEAP_SIZE;
    u32 node_addr = HEAP_BASE;
    ListNode *next = NULL, *head = NULL;
    u32 blksz = LEAF_SIZE * pow_2(log_2(BUDDY_ORDER));
    while (size)
    {
        ListNode *cur = (ListNode *)node_addr;
        buddy_list_insert(&buddy_tree.nodes[1], cur);

        size -= blksz;
        node_addr += blksz;
    }

    buddy_tree.nodes[0].head = NULL;
    for (int i = 2; i < BUDDY_ORDER; i++)
    {
        buddy_tree.nodes[i].head = NULL;
    }
}
