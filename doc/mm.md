###### 参考资料

rcore实验的ch4代码的部分mm设计

###### 草稿

假设内存4G，这里有frame_allocator对物理内存进行帧分配
以及page_table对页表进行map的操作

functions:

- void init_frametracker()
- FrameTracker *frame_alloc()
- void frame_dealloc(FrameTracker *ft)
- FrameTracker *frame_find(void *pa)



- void *la2pa(void *la)
- void map(void *la, FrameTracker *ft)
- void *unmap(void *la)



这个内核ldr自动把所有页表都恒等映射了。



因为frame_tracker数组太大，我们把内核入口点改了。

入口点为1M+400h（内核从1M开始）

页目录从512M开始



栈分配（局部变量分配）是编译器自己会写的

堆分配由操作系统管理，所以需要内核实现，而C的堆分配也就是malloc和free。

[c - 当你用指向内存分配中间位置的指针调用 free() 函数时会发生什么？ - Stack Overflow --- c - What happens when you call free() with a pointer to the middle of the allocation? - Stack Overflow](https://stackoverflow.com/questions/1957099/what-happens-when-you-call-free-with-a-pointer-to-the-middle-of-the-allocation)

注意，似乎不会自动dealloc FrameTracker，请自行释放

Buddy System有问题，全部分配之后然后再free可能无法重用，但也就这样了

###### 物理页管理与页表

**物理页管理**

将物理地址空间以4k为一块组织，用frame_tracker跟踪这些块的使用情况，包括它们的物理地址、引用计数和是否在使用。需要一个frame的时候则按顺序查找，找到第一个没占用的frame就返回它的tracker。dealloc的时候传入它的tracker，进行置零即可。

**页表**

主要负责页表映射的管理，需要将线性地址映射到物理地址的时候，传入线性地址和你有的物理页帧的tracker，map将负责设置二级页表项。

unmap负责将线性地址原本映射到的物理页的地址，找到它的tracker（在这里使用frame_tracker_find）然后将其返回给调用者供以后处理。

la2pa即线性地址到物理地址的转换，这里直接查找页表进行转换。

**参考**

[rCore-Tutorial-Book-v3 3.6.0-alpha.1 文档](https://rcore-os.cn/rCore-Tutorial-Book-v3/)

[Writing an OS in Rust](https://os.phil-opp.com/)

###### 动态内存分配

**伙伴系统**

伙伴系统是一个最优适应算法，即找到比它大的最小$2^k$内存块进行分配。

在本内核的实现中，将分配链表组织成二叉树的形式，即每个结点$i$从1开始，i^1为其伙伴。除了根节点。这样方便查找。数据结构中，每个块首部存储它分配时所属的二叉树id，方便放回；块地址；块大小。以及对应大小块的链表中的前驱后继。

插入参考了blogos的头插入。链表操作与常规链表一致。

初始化的时候将堆区域分成若干个根节点所能表达的最大块大小的小块，然后插入到根节点的链表中。

分配的时候，首先计算出要分配大小对应的树结点id，也就是这个大小的应该在哪些id中循环遍历链表，如果找到则返回，否则在对应深度之前倒序遍历找到第一个大于这个块大小的块进行分裂直到满足。

合并的时候，从传入的块基址中找到id，然后找它的伙伴id，看是否有对应的连续内存块地址节点。如果有的话说明它们可以向上合并。

**不足**

在多次全分配全删除的情况下，存在一些bug。代码能力不足。

**参考文献**

[Writing an OS in Rust](https://os.phil-opp.com/)

《计算机程序设计艺术》第一卷

###### 虚拟内存

先考虑一下，要实现虚拟内存，要在进程里面放什么。

- 每个进程都有独立的虚拟地址空间，因此每个进程都要有一个自己的页表（二级页表）

- 进程创建的时候，代码段需要映射到页表上。

- 我们也可以在实现虚拟内存的同时，实现程序的加载（暂无）

  

###### 测试

先连续dealloc5个帧，然后再dealloc某个随机

然后重新alloc与映射测试分配与映射机制。

###### 内存布局

![image-20251216160602031](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251216160602031.png)

###### 虚拟内存实现

一组PageDir+PageTable一共是4K+4M(401000h)。也就是说，供给用户页表机构、用户地址空间为20401000h之后的所有. for easy its 30000000h





###### 难点

本来想做请求调页，但是要做这个就要做文件系统，然后就要做fork、exec什么的。由于时间问题就没搞了。

