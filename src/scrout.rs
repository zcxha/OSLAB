/// scrout.rs
/// 与屏幕输出相关

use core::{arch::asm, ffi::{CStr, c_char}};

unsafe extern "C" {
    fn console_putchar(c: u8, color: u8);
}

// 改编自Cstr的代码
#[unsafe(no_mangle)]
pub fn strlen(ptr: *const c_char) -> usize {
    let mut len = 0;

    // SAFETY: Outer caller has provided a pointer to a valid C string.
    while unsafe { *ptr.add(len) } != 0 {
        len += 1;
    }

    len
}

pub fn print(s: &CStr) {
    for c in s.to_bytes() {
        unsafe { console_putchar(*c, 0xF) };
    }
}

// 改编自ChatGPT
pub const HEX_CHARS: &[u8; 16] = b"0123456789abcdef";
pub fn u32_to_hex_buf_lower(value: u32, buf: *mut u8) {
    for i in 0..8 {
        let shift = (7 - i) * 4;
        let nibble = ((value >> shift) & 0xF) as usize;

        if let Some(c) = HEX_CHARS.get(nibble) {
			unsafe { *buf.add(i+2) = *c };
        }else {

		}
    }
}

pub fn print_int(value: u32) {
    let mut buf: [u8; 11] = [48; 11];

    u32_to_hex_buf_lower(value, buf.as_mut_ptr());

	buf[0] = 48;
	buf[1] = 120;
    buf[10] = 0;
    unsafe {print(&*(&buf as *const [u8] as *const CStr));}// 来自CStr的from_ptr的最后一行
}