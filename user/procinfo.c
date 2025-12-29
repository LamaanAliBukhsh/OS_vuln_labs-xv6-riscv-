#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  char info[64];
  
  if(getprocinfo(32, info) < 0) {
    printf("getprocinfo failed\n");
    exit(1);
  }
  
  printf("Process info: %s\n", info);
  exit(0);
}
