# Security

## 分析+POC

1. 可执行程序篡改

   **分析**

   由add_task可知，内核为了方便，每次增加一个用户程序，用户程序的页表都是从kernel一直映射到堆。这样就会导致程序间内存可以互相访问。（本实验假设用户空间跟内核空间无法互相访问，很容易做到这一点，更改页表映射即可。可以想到在映射的时候将内核数据都映射为只读也行，不过这种方法要区分哪些地方只读哪些地方会变，因为栈区也在kernel的连续空间内。）

   ![image-20251228150422685](E:\OSLAB\work\LAB\doc\images\Security\image-20251228150422685.png)

   **POC**

   ![image-20251228150600184](E:\OSLAB\work\LAB\doc\images\Security\image-20251228150600184.png)

   实现对A进程代码段的修改即可。

   ![image-20251228150646635](E:\OSLAB\work\LAB\doc\images\Security\image-20251228150646635.png)

   如图，将A的第一个字节改成了'0'。

2. 内核关键数据破坏

   在应用程序页表未映射内核空间，无法访问内核地址的情况下，除了缓冲区溢出等方法，通常难以改变内核的关键数据。不过这个版本的代码可以随意修改内核数据。

3. 缓冲区溢出

可以实现用户态的缓冲区溢出，写两个函数即可。

![image-20251228170914952](E:\OSLAB\work\LAB\doc\images\Security\image-20251228170914952.png)

![image-20251228170928880](E:\OSLAB\work\LAB\doc\images\Security\image-20251228170928880.png)

![image-20251228170956001](E:\OSLAB\work\LAB\doc\images\Security\image-20251228170956001.png)



1. 可信启动（TODO）

## 防护

1. 可执行程序篡改

   解决方案为，装入时在内存中存储一个度量值，需要假设这个度量值是用户不可访问的。然后每隔一段时间（ticks%1000 == 0）进行一次度量。因为目前的内核还没有加载器，编译时无法得知代码段的长度，因此假设是0x1000。

   ![image-20251228154402952](E:\OSLAB\work\LAB\doc\images\Security\image-20251228154402952.png)

2. a

3. 缓冲区溢出

考虑在ebp和retaddr之间/local var和retaddr之间添加一个canary。