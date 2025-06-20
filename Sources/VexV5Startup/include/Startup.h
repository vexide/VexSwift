#pragma once
#include <stddef.h>

__attribute__((naked))
__attribute__((noreturn))
void boot(void) asm("_boot");

int putchar(int value);
