use crate::scrout::{print, print_int};

unsafe extern "C" {
    fn VAToPA(va: u32) -> i32;
    fn alloc_pages(num: u32, ptr: *mut u32) -> i32;
    fn free_pages(num: u32, ptr: *const u32);
    fn map(va: u32, pa: u32);
    fn unmap(va: u32) -> u32;
    fn get_bitmap(p: *mut u32);
    fn init_bitmap();
}

fn pr_int(x: u32) {
    print_int(x);
	print(c" ");
}

pub fn test_mm() {
    let mut bitmap: [u32; 4] = [1; 4];

    unsafe {
        init_bitmap();
    }

    unsafe {
        get_bitmap(bitmap.as_mut_ptr());
    }

    for i in 0..4 {
        pr_int(bitmap[i]);
    }

    let va: u32 = 0x00401000;

    let mut pa: u32 = unsafe { VAToPA(va) as u32 };

    pr_int(pa as u32); // 输出pa=va

    // 测试 unmap
    pa = unsafe { unmap(va) };

    pr_int(pa);

	// 测试VATOPA
	pa= unsafe { VAToPA(va) as u32 };// FFFFFFFF

    pr_int(pa as u32); // 输出pa=va

	print(c"\n");

    // 测试 alloc

    let mut blocks: [u32; 3] = [0; 3];
    let res = unsafe { alloc_pages(3, blocks.as_mut_ptr()) };

    unsafe {
        get_bitmap(bitmap.as_mut_ptr());
    }

    for i in 0..4 {
        pr_int(bitmap[i]);
    }

	print(c"res: ");
	pr_int(res as u32);

    if res == 0 {
        for i in 0..3 {
            pr_int(blocks[i]);
        }
    }

    // 测试map
    unsafe {
        map(va, blocks[1]);
    }

    pa = unsafe { VAToPA(va) as u32 };

    pr_int(pa);

    print(c"\n");

    // unmap 并测试VAToPA
    unsafe { unmap(va) };

    pa = unsafe { VAToPA(va) as u32 };

    pr_int(pa);

    // 测试free

    unsafe {
        free_pages(1, blocks.as_ptr().add(1));
    }

    unsafe {
        get_bitmap(bitmap.as_mut_ptr());
    }

    for i in 0..4 {
        pr_int(bitmap[i]);
    }

    unsafe {
        alloc_pages(1, blocks.as_mut_ptr().add(1));
    }

	pr_int(blocks[1]);
}
