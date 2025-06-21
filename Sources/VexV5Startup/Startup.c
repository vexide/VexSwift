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

// TODO: try and set up a panic handler by overwriting _swift_runtime_on_report
// https://github.com/swiftlang/swift/blob/1ceeb7089bb80ed54528547adfa250b57cedf3cd/stdlib/public/runtime/Errors.cpp#L376C1-L376C25
