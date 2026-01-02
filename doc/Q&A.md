这个只是QA备忘录，不是谁问的问题（我自己问的但是健忘）。



1. 为什么run出来，HD这个task，运行的stat最少?

因为跟硬盘打交道，IO时间长，interrupt_wait中会将自己block，那自然不统计。

