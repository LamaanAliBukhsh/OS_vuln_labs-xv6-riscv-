#include "kernel/types.h"
#include "user/user.h"

int main(void) {
    char buffer[128];
    
    // Intentionally requesting more bytes than safe (128 bytes)
    if(getprocinfo(128, buffer) < 0) {
        printf("getprocinfo failed\n");
        exit(1);
    }

    printf("Received data:\n%s\n", buffer);
    
    exit(0);
}