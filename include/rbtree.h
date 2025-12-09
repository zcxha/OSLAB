typedef struct rbnode {
	/* color为0表示黑，1表示虹 */
	u32 color;
	u32 key;
	struct rbnode *left;
	struct rbnode *right;
	struct rbnode *p;
	struct sched_entity *se;
}rbnode;

struct sched_entity* __pick_first_entity();

#define RED 1
#define BLACK 0