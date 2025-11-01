// from rcore
use core::fmt::{self, Write};

unsafe extern "C" {
    unsafe fn console_putchar(c: u8, color: u8);
}

struct Stdout {
    color: u8,
}

impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for c in s.chars() {
            unsafe { console_putchar(c as u8, self.color) };
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    let mut stdout = Stdout { color: 0xf };
    stdout.write_fmt(args).unwrap();
}

pub fn printc(color: u8, args: fmt::Arguments) {
    let mut stdout = Stdout { color };
	stdout.write_fmt(args).unwrap();
}

/// Print! to the host console using the format string and arguments.
#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?))
    }
}

/// Println! to the host console using the format string and arguments.
#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}

/// printc! print color
#[macro_export]
macro_rules! printc {
	($color: expr, $fmt:literal $(, $($arg: tt)+)?) => {
		$crate::console::printc($color ,format_args!($fmt $(, $($arg)+)?))
	};
}

/// printlnc! printlnc
#[macro_export]
macro_rules! printlnc {
	($color: expr, $fmt:literal $(, $($arg: tt)+)?) => {
		$crate::console::printc($color ,format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
	};
}
