#pragma once

#include <stddef.h>
#include <stdint.h>

// libc internals

void __libc_init_array(void);

// see https://github.com/picolibc/picolibc/blob/main/doc/tls.md

// This is an architecture-specific function which sets the TLS block pointer for the processor to `tls`.
void _set_tls(void *tls);

// This function initializes the specified TLS block, copying values into the initialized data portion and clearing values in the uninitialized data portion.
void _init_tls(void *tls);

// MARK: Linker constants

extern uint8_t __heap_start[];
extern uint8_t __heap_end[];

extern uint8_t __bss_start[];
extern uint8_t __bss_end[];

extern uint8_t __tls_base[];

// MARK: Startup functions

// The entrypoint for the program.
// Handles setting up the stack pointer.
[[gnu::naked]]
[[gnu::section(".boot")]]
[[noreturn]]
void boot(void) asm("_boot");

// Swift runtime initialization.
//
// Fills the `.bss` (uninitialized statics) section with zeroes,
// then calls the main function, then exits.
[[noreturn]]
void swift_startup(void);
