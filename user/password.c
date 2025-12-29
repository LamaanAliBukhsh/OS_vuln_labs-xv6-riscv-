#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
  // readpassword will print the flag if root or error message if not
  readpassword(0);
  exit(0);
}
