#pragma once

#include <stddef.h>
#include <stdint.h>

// MARK: Linker constants

extern uint8_t __heap_start[];
extern uint8_t __heap_end[];

extern uint8_t __bss_start[];
extern uint8_t __bss_end[];

// MARK: Startup functions

// The entrypoint for the program.
// Handles setting up the stack pointer.
[[gnu::naked]]
[[noreturn]]
void boot(void) asm("_boot");

// Swift runtime initialization.
//
// Fills the `.bss` (uninitialized statics) section with zeroes,
// then calls the main function
void swift_startup(void);

// MARK: Stubs

#undef putchar
int putchar(int value);
