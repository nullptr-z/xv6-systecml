// Physical memory allocator, for user processes,
// kernel stacks, page-table pages,
// and pipe buffers. Allocates whole 4096-byte pages.
// 物理内存分配器，用于用户进程，
// 内核堆栈、页表页、
// 和管道缓冲区。 分配整个 4096 字节页面。
#include "types.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "riscv.h"
#include "defs.h"

void freerange(void *pa_start, void *pa_end);

extern char end[]; // first address after kernel. 内核之后的首地址。
                   // defined by kernel.ld.       由kernel.ld 定义。

struct run
{
  struct run *next;
};

struct
{
  struct spinlock lock;
  struct run *freelist;
} kmem;

void kinit()
{
  initlock(&kmem.lock, "kmem");
  freerange(end, (void *)PHYSTOP); // 128MB
}

void freerange(void *pa_start, void *pa_end)
{
  char *p;
  p = (char *)PGROUNDUP((uint64)pa_start);
  for (; p + PGSIZE <= (char *)pa_end; p += PGSIZE)
    kfree(p);
}

// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
// 释放v指向的物理内存页，
// 通常应该由 a 返回
// 调用 kalloc()。 （例外情况是当
// 初始化分配器； 请参阅上面的 kinit。）
void kfree(void *pa)
{
  struct run *r;

  if (((uint64)pa % PGSIZE) != 0 || (char *)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  // 填充垃圾以捕获悬空的引用。
  memset(pa, 1, PGSIZE);

  r = (struct run *)pa;

  acquire(&kmem.lock);
  r->next = kmem.freelist;
  kmem.freelist = r;
  release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
// 分配一页 4096 字节的物理内存。
// 返回内核可以使用的指针。
// 如果内存无法分配则返回0。
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if (r)
    kmem.freelist = r->next;
  release(&kmem.lock);

  if (r)
    memset((char *)r, 5, PGSIZE); // fill with junk  填充垃圾
  return (void *)r;
}

uint64 amount_free_memory(void)
{

  struct run *r;
  uint64 cnt = 0;

  acquire(&kmem.lock);
  r = kmem.freelist;
  while (r)
  {
    r = r->next;
    cnt++;
  }
  release(&kmem.lock);

  return cnt * PGSIZE;
}
