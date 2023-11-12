	# qemu -kernel loads the kernel at 0x80000000
        # and causes each CPU to jump there.
        # kernel.ld causes the following code to
        # be placed at 0x80000000.
.section .text
.global _entry
_entry:
	# set up a stack for C.                 为C建立一个堆栈。
        # stack0 is declared in start.c,        stack0 在 start.c 中声明，
        # with a 4096-byte stack per CPU.       每个 CPU 有 4096 字节的堆栈。
        # sp = stack0 + (hartid * 4096)         sp = stack0 + (hartid * 4096)
        la sp, stack0
        li a0, 1024*4
	csrr a1, mhartid
        addi a1, a1, 1
        mul a0, a0, a1
        add sp, sp, a0
	# jump to start() in start.c
        call start
spin:
        j spin
