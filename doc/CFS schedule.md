###### 草稿纸

1.有一个sched_latency，代表所有进程轮换一次的时间长度。

2.每个进程被调度运行的时候，它将运行sched_latency按照比例分配出来的时间长度

3.进程的选取使用vruntime最小的。

![image-20251113002616943](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113002616943.png)

###### CFS工作流程

1.在进程加入的时候，使用prio_to_weight赋值为该进程的weight

2.进程被调度运行，则其本次运行时间应该为
$$
ideal\_time[i] = \_\_sched\_period(nr\_running) * weight[i] / sum\_weight
$$
其中，__sched_period与linux一样，解释在参考文献[2]中写的比较明白，代码如下：

![image-20251113222715796](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113222715796.png)

注意这个地方跟linux不同的是，我做了缩放，太大会出问题（u32）。而且目前我改了时钟中断为1ms触发一次，执行时间每次增加1000，那么默认latency相当于60ms，sched_slice算出来除以100（已经改成/10，跟linux一致了虽然其实对结果没什么大的变化）就是0.6ms，也就是所有进程轮换一次的周期是0.6ms（nr_tasks<=8）

![image-20251113222734630](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113222734630.png)

此处的vruntime更新公式为：
$$
\delta_{vruntime} = \delta_{exec\_time} * \frac{1024}{weight_{curr}}
$$
3.本设计的检查时间为每次时钟中断，实际linux不是这样的，所以简化了。在每次时钟中断的时候，首先update_curr更新各种状态如全局时间变量ticks（linux中为now），更新进程的执行时间exec_time（linux中为exec_start,因此linux使用now-exec_start来计算时间，每次这个update调度的时候更新exec_start，这样就可以计算每次间隔的时间）。然后用这个exec_time计算calc_delta_fair用来更新vruntime。如果当前执行的时间大于ideal_runtime，则转调度程序，或者红黑树最小值的vruntime跟当前进程的vruntime差值大于ideal_runtime，也转调度。

![image-20251113222913244](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113222913244.png)

参考linux的check_preempt_tick[2]。

4.调度的时候要注意，当一个进程进入运行态，其结点在红黑树中删除。当一个进程从运行转为就绪态时，需要将红黑树node更新再插入进去。

![image-20251113223354632](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113223354632.png)

5.红黑树参考算法导论[1]的伪代码实现。

###### 数据结构定义

1.调度对象

![image-20251113223626124](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113223626124.png)

2.进程链表（约等于cfs_rq）

![image-20251113223651468](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113223651468.png)

3.红黑树结点

![image-20251113223723347](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113223723347.png)

因为没有基础所以先去看书发现书上的篇幅比linux code短所以直接抄书了。

###### 验证

1.先把任务添加进run_queue

![image-20251113223547304](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113223547304.png)

2.优先级的问题。在这里看到A是优先级高的。他们的weight分别是1277,1024,820。A相比于B的CPU占用应该多(1277-1024)/(1277+1024+820)

也就是
$$
\delta_{load_{ab}} = \delta_{weight_{ab}} / \sum  {weight}
$$
算出A应该比B大概多0.0811

A比C大概多0.1464

![image-20251113224740714](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113224740714.png)

3.我们运行一下：

![image-20251113224830169](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251113224830169.png)

由于IPS被调高了，而作者原来的代码就有因为disp_pos过大导致异常的问题，所以这里触发异常是正常的。我们先看核心的部分A=114项，B=92项，C=74项。

算出答案分别是0.0786和0.1429。答案已经很接近了。

###### 参考文献

[1] Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2022).Introduction to algorithms. MIT press.

[2] https://www.hitzhangjie.pro/blog/%E4%BB%BB%E5%8A%A1%E8%B0%83%E5%BA%A67v2/

[3] https://puranikvinit.hashnode.dev/cfs-scheduler

[4] https://elixir.bootlin.com/linux/latest/source/kernel/sched/fair.c
