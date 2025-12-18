typedef struct rbnode {
	/* color为0表示黑，1表示虹 */
	u32 color;
	u32 key;
	struct rbnode *left;
	struct rbnode *right;
	struct rbnode *p;
    void *entity;
	// struct sched_entity *se;
}rbnode;

// 暂未使用（预计多核扩展使用）
typedef struct rbtree {
    rbnode nil;
    rbnode* root;
}rbtree;


#define RB_RED 1
#define RB_BLACK 0