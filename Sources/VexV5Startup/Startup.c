#include "Startup.h"

#include <string.h>

// Entrypoint
void boot(void) {
    asm volatile("ldr sp, =__stack_top");
    asm volatile("bl swift_startup");

    // main returns = loop forever
    asm volatile("b     .");
}

extern int main(void);

void swift_startup(void) {
    // Clear the .bss (uninitialized statics) section by filling it with zeroes.
    // This is required, since the compiler assumes it will be zeroed on first access.
    size_t bss_size = (uintptr_t) &__bss_end - (uintptr_t) &__bss_start;
    memset(&__bss_start, 0, bss_size);

    main();
}

// stub to fix linker errors
int putchar(int value) {
    // TODO
    return 0;
}
