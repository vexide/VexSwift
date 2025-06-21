#include "Startup.h"

#include <stdlib.h>
#include <string.h>

// Entrypoint
void boot(void) {
    asm volatile("ldr sp, =__stack_top");
    asm volatile("bl swift_startup");

    // swift_startup returns = loop forever
    asm volatile("b     .");
}

extern int main(void);

void swift_startup(void) {
    // Clear the .bss (uninitialized statics) section by filling it with zeroes.
    // This is required, since the compiler assumes it will be zeroed on first access.
    size_t bss_size = (uintptr_t) &__bss_end - (uintptr_t) &__bss_start;
    memset(&__bss_start, 0, bss_size);

    // Set the thread-local storage block for the processor
    _set_tls(__tls_base);

    // Run constructors
    __libc_init_array();

    int exit_code = main();
    exit(exit_code);
}

// TODO: try and set up a panic handler by overwriting _swift_runtime_on_report
// https://github.com/swiftlang/swift/blob/1ceeb7089bb80ed54528547adfa250b57cedf3cd/stdlib/public/runtime/Errors.cpp#L376C1-L376C25
