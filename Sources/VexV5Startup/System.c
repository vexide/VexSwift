#include <stdio.h>

#include "System.h"

constexpr uint32_t STDIO_CHANNEL = 1;

int putchar(int c) {
    int rtn = vexSerialWriteChar(STDIO_CHANNEL, c);

    while (vexSerialWriteFree(STDIO_CHANNEL) < 2048) {
        vexTasksRun();
    }

    return rtn == 1 ? c : EOF;
}