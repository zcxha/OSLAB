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



因为frame_tracker数组太大，我们把内核入口点改了。

入口点为1M+400h

页目录从512M开始



栈分配（局部变量分配）是编译器自己会写的

堆分配由操作系统管理，所以需要内核实现

###### 测试

先连续dealloc5个帧，然后再dealloc某个随机

然后重新alloc与映射测试分配与映射机制。

###### 内存布局
