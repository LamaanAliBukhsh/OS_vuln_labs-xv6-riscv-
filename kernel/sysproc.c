#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "vm.h"

// Lab 1: FLAG
char info_buffer[128] = "Process info data goes here...................................FLAG{xv6_buff3r_0verfl0w_m4st3r_LAB1}";

// Lab 2: FLAG
char admin_flag[64] = "FLAG{pr1v_3sc_g0t_r00t_acc3ss_LAB2}";

// Takes a size parameter but doesn't validate it!
// Normal use-case: size=32 gives safe data
uint64
sys_getprocinfo(void)
{
  int size;
  argint(0, &size);  // User specifies how many bytes to read
  
  uint64 addr;
  argaddr(1, &addr);  // User's buffer address
  
  
  if(copyout(myproc()->pagetable, addr, info_buffer, size) < 0)
    return -1;
  
  return 0;
}

// Read password file (requires root privileges)
uint64
sys_readpassword(void)
{
  struct proc *p = myproc();
  
  if(!p->isroot) {
    printf("Access denied: root privileges required\n");
    return -1;
  }
  
  printf("%s\n", admin_flag);
  
  return 0;
}

// Helper function to set root privileges
// Uses || (OR) instead of && (AND) in authentication!
// Should require: uid==0 AND magic==0x1337
// Actually checks: uid==0 OR magic==0x1337 (Code error)
uint64
sys_setroot(void)
{
  int uid;
  int magic;
  argint(0, &uid);
  argint(1, &magic);
  
  struct proc *p = myproc();
  // uid=0 is for root process
  if(uid == 0 || magic == 0x1337) {
    p->isroot = 1;
    return 0;
  }
  
  return -1;
}

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  kexit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return kfork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return kwait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
  argint(1, &t);
  addr = myproc()->sz;

  if(t == SBRK_EAGER || n < 0) {
    if(growproc(n) < 0) {
      return -1;
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
      return -1;
    if(addr + n > TRAPFRAME)
      return -1;
    myproc()->sz += n;
  }
  return addr;
}

uint64
sys_pause(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  if(n < 0)
    n = 0;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kkill(pid);
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
