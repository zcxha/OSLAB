unsafe extern "C" {
     fn in_byte(port: u16) -> u8;
     fn out_byte(port: u16, value: u8);
}

pub fn inb(port: u16) -> u8
{
	unsafe {in_byte(port)}
}

pub fn outb(port: u16, value: u8)
{
	unsafe {out_byte(port, value);}
}