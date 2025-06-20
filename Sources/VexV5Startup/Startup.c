#include "Startup.h"

// Entrypoint
void boot(void) {
    asm volatile("ldr sp, =__stack_top");
    asm volatile("bl main");

    // main returns = loop forever
    asm volatile("b     .");
}

// stub to fix linker errors
int putchar(int value) {
    // TODO
    return 0;
}
