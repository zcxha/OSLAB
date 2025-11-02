# 使用rust来编写内核

###### 前置知识

- 了解cargo构建流程
- 了解该实验的原版C代码

###### Requirements

```Ubuntu-16.04_i386```

```shell
python3.7 --version
Python 3.7.17	
```

```shell
rustc --version
rustc 1.93.0-nightly (278a90913 2025-10-28)
```

###### Configuration

```.cargo/config.toml```

```toml
[unstable]
build-std-features = ["compiler-builtins-mem"]
build-std = ["core", "compiler_builtins"]

[build]
target = "i686-unknown-none.json"

[target.i686-unknown-none]
rustflags = ["-C", "link-args=--image-base=0x30000 -Ttext=0x30400"]

```

```src/main.rs```

关于为什么这样写，详细请看[独立式可执行程序 | Writing an OS in Rust](https://os.phil-opp.com/zh-CN/freestanding-rust-binary/)

```rust
// main.rs

#![no_std]
#![no_main]

static HELLO: &[u8] = b"Hello World!1111.";

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
	let vga_buffer = 0xb8000 as *mut u8;

	for(i, &byte) in HELLO.iter().enumerate() {
		unsafe {
			*vga_buffer.offset(i as isize * 2) = byte;
			*vga_buffer.offset(i as isize * 2 + 1) = 0xb;
		}
	}

	loop {}
}

use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> !
{
	loop {
		
	}
}
```

```i686-unknown-none.json```

根据[How to compile Rust code to bare metal 32 bit x86 (i686) code? What compile target should I use? - Stack Overflow](https://stackoverflow.com/questions/67902309/how-to-compile-rust-code-to-bare-metal-32-bit-x86-i686-code-what-compile-targ)的回答，将配置文件写入后cargo build，llvm会提示data-layout，将它提示的信息复制到data-layout即可。

```json
{
  "llvm-target": "i686-unknown-none",
  "data-layout": "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i128:128-f64:32:64-f80:32-n8:16:32-S128",
  "arch": "x86",
  "target-endian": "little",
  "target-pointer-width": 32,
  "target-c-int-width": 32,
  "os": "none",
  "executables": true,
  "linker-flavor": "ld.lld",
  "linker": "rust-lld",
  "panic-strategy": "abort",
  "disable-redzone": true
}
```

```cargo.toml```

```toml
[package]
name = "lab6-rust"
version = "0.1.0"
edition = "2024"

[profile.dev]
panic = "abort"

[profile.release]
panic = "abort"
strip = true
```

###### 自行探索的方法（因此或许有更好的build，欢迎交流）

###### Some chore task to do

目的：汇编```nasm```生成产物，与```rust```的```.o```进行```ld```

因为构建是使用```rustc```调用```llvm```进行编译，而```llvm```本身就支持```cross-compile```所以只需要编写配置文件即可产生任何llvm支持的target

方法：使用```cargo build --release --verbose``` 获取```cargo```调用的```rustc```命令，将其复制保存到```build.sh```中

注意如果没有显示这样的说明当前产物是最新的，你修改一下产物再生成即可

![image-20251029223558402](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251029223558402.png)

![image-20251029223609024](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20251029223609024.png)

在```rustc```的编译命令中加入```--emit obj ```使```rustc```编译出来的文件为```.o```

[Command-line Arguments - The rustc book](https://doc.rust-lang.org/rustc/command-line-arguments.html#--emit-specifies-the-types-of-output-files-to-generate)



###### 现状

操作完上面的内容之后直接make即可。

关于构建流程可参考Makefile和build.py

###### Note

不要在英文中加```了好吗，打断思路好多次了。
