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
    struct ListNode *prev;
    struct ListNode *next;
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