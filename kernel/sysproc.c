#include "types.h"
#include "riscv.h"
#include "param.h"
#include "defs.h"
#include "date.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

pte_t *walk(pagetable_t pagetable, uint64 va, int alloc);

uint64
sys_exit(void)
{
  int n;
  if (argint(0, &n) < 0)
    return -1;
  exit(n);
  return 0; // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return fork();
}

uint64
sys_wait(void)
{
  uint64 p;
  if (argaddr(0, &p) < 0)
    return -1;
  return wait(p);
}

uint64
sys_sbrk(void)
{
  int addr;
  int n;

  if (argint(0, &n) < 0)
    return -1;

  addr = myproc()->sz;
  if (growproc(n) < 0)
    return -1;
  return addr;
}

uint64
sys_sleep(void)
{
  int n;
  uint ticks0;

  if (argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while (ticks - ticks0 < n)
  {
    if (myproc()->killed)
    {
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// #ifdef LAB_PGTBL
// int sys_pgaccess(void)
// {
//   // lab pgtbl: your code here.
// }
// #endif

uint64
sys_kill(void)
{
  int pid;

  if (argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

// int sys_pgaccess(uint64 first_va, int count, int mask)
int sys_pgaccess(void)
{
  struct proc *p = myproc();
  pagetable_t pt = p->pagetable;

  uint64 first_va = p->trapframe->a0;
  int count = p->trapframe->a1;
  int mask = p->trapframe->a2;
  // argaddr(0, &first_va); argint(1, &count); argint(2, &mask);

  uint64 masks = 0;
  for (uint32 i = 0; i < count; i++)
  {
    uint64 va = first_va + i * PGSIZE;
    pde_t *pte = walk(pt, va, 0);
    if (!pte)
    {
      continue;
    }

    if (*pte & PTE_A)
    {
      masks |= 1 << i;
      *pte &= ~PTE_A;
    }
  }
  copyout(pt, mask, (char *)&masks, sizeof(int));

  return 0;
}
