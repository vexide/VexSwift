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

int putchar(int value) {
    static const uint32_t STDIO_CHANNEL = 1; 

    void (*vexTasksRun)(void) = *(void (**)(void))0x037fc05c;
    int32_t (*vexSerialWriteChar)(uint32_t, uint8_t) = *(int32_t (**)(uint32_t, uint8_t))0x037fc898;
    int32_t (*vexSerialWriteFree)(uint32_t) = *(int32_t (**)(uint32_t))0x037fc8ac;

    int rtn = vexSerialWriteChar(STDIO_CHANNEL, value);
    
    while (vexSerialWriteFree(STDIO_CHANNEL) < 2048) {
        vexTasksRun();
    }

    return rtn == 1 ? value : -1;
}
