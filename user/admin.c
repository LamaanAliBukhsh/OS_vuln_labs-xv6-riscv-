#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  char secret[64];
  
  printf("Attempting to read password file...\n");
  
  if(readpassword(secret) < 0) {
    printf("Access denied: root privileges required\n");
    exit(1);
  }
  
  printf("Password file contents: %s\n", secret);
  exit(0);
}
