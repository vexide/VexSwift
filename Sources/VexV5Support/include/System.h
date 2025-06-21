#include <stddef.h>

#include "Sdk.h"

#undef putchar
int putchar(int c);

[[noreturn]]
void _exit(int code);

int getentropy(void *buf, size_t buflen);
