# Day2 - rust与asm互调

###### References（前置知识）

- 如何在```rust```中使用```C```[A little C with your Rust - The Embedded Rust Book](https://docs.rust-embedded.org/book/interoperability/c-with-rust.html)，该网站还有共轭文章，即```C```使用```rust```

###### A plain implementation

作者```rust```基础不好（），所以对```gdt```替换只写了朴素方法，欢迎交流。

比如```C```的

```c
	u8 a[4] = {0x7f, 0x7f, 0x7f, 0x7f};

	cout << *((int *)&a[0]);

 
```

应该如何在rust中实现呢？或许也是C的特性？我不太懂。

```rust
fn replace_gdt() {
    unsafe {
        let lim: u16 = ((GDT_PTR[1] as u16) << 8) + (GDT_PTR[0] as u16);
        let base: u32 = ((GDT_PTR[5] as u32) << 24)
            + ((GDT_PTR[4] as u32) << 16)
            + ((GDT_PTR[3] as u32) << 8)
            + (GDT_PTR[2] as u32);
        memcpy(&raw const GDT, base, lim + 1);

        let newbase = &raw const GDT[0] as u32;
        let newlim: u16 = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;

        GDT_PTR[0] = newlim as u8;
        GDT_PTR[1] = (newlim >> 8) as u8;
        GDT_PTR[2] = newbase as u8;
        GDT_PTR[3] = (newbase >> 8) as u8;
        GDT_PTR[4] = (newbase >> 16) as u8;
        GDT_PTR[5] = (newbase >> 24) as u8;
    }
}
```

详细的问题如下：

我们知道，不可变指针是可以拿来像c一样搞的

```rust
#[unsafe(no_mangle)]
pub static buf: [u8; 4] = [1; 4];

#[unsafe(no_mangle)]
pub fn square(num: i32) -> i32 {
    let b = buf[0..1].as_ptr() as *const u16;
	unsafe{
		print!("{}", *b);
	}
    b as i32
}
```

原理就是切片的ptr作为一个指针

而如果想修改buf，那么使用相应的

```rust
fn main() {
	square(1);

	print!("{}", unsafe {buf[0]});
}
#[unsafe(no_mangle)]
pub static mut buf: [u8; 4] = [1; 4];

#[unsafe(no_mangle)]
pub fn square(num: i32) -> i32 {
    let b = unsafe { buf }[0..1].as_mut_ptr() as *mut u16;
	unsafe{
		*b = 0;
		print!("{}", *b);
	}
    b as i32
}
```

恭喜最后并没有修改buf

```
print: 01
```

原因在本人调试的时候发现，rust似乎拷贝了一份变量

![image-20251031012007025](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251031012007025.png)

**超级牛的，避免了指针操作的方法（来自Lynx）**

union

global.rs

```rust

pub union GDT_PTR_UNION {
	pub raw: [u8; 6],
	pub lim: u16, 
	pub base: u32
}

// 注意到这种形式在汇编中是定义这样一段GDT_PTR: .zero 6
// C中的数组，汇编形式是 一个Label：.zero 6
#[unsafe(no_mangle)]
pub static mut GDT_PTR: GDT_PTR_UNION = GDT_PTR_UNION{raw: [0; 6]};
// pub static mut GDT_PTR: [u8; 6] = [0; 6];

```

```rust

fn replace_gdt()
{
	let lim = unsafe { GDT_PTR.lim };
	let base = unsafe { GDT_PTR.base };
	
	unsafe { memcpy(&raw const GDT, base, lim + 1) };

	let newbase = &raw const GDT as u32;
	let newlim = (GDT_SIZE * size_of::<DESCRIPTOR>()) as u16 - 1;

	unsafe { GDT_PTR.base = newbase };
	unsafe { GDT_PTR.lim = newlim };
}
```



###### Code tree

```
.
├── Cargo.lock
├── Cargo.toml
├── Makefile
├── a.img
├── bochsrc
├── boot # 原实验的boot
│   ├── boot.asm
│   ├── boot.bin
│   ├── include
│   │   ├── fat12hdr.inc
│   │   ├── load.inc
│   │   └── pm.inc
│   ├── loader.asm
│   └── loader.bin
├── build.bat
├── build.json
├── build.py
├── build.sh
├── i686-unknown-none.json
├── kernel
│   └── kernel.asm # 原实验的kernel，也是作为入口，在里面跟rust进行交流
├── lib # 原实验lib
│   ├── kliba.asm
│   └── string.asm
├── src
│   ├── config.rs # 一些常量
│   ├── global.rs # 一些全局变量
│   ├── main.rs # 包含rust_main
│   └── protect.rs # 保护模式数据结构等定义
```



###### Small Exploration

这个系统启动之后，需要使用代码对```rust```全局变量进行初始化，也就是说声明的时候初始化值是没用的。应该也挺好理解，程序加载器```loader```并没有在对内核```elf```布局的同时初始化内存空间。

###### Personal Notes

虽然现在的代码看上去很好懂，我现在看都觉得为什么我当时写了这么久才写这么点。还是对```rust```不懂导致的。比如

```
let newbase = &raw const GDT[0] as u32;
```

为什么使用```&raw const```，为什么```as *const u32```就不行呢？这只是一个例子。TODO