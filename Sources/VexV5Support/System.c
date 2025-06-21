#include <stdio.h>

#include "System.h"

constexpr uint32_t STDIO_CHANNEL = 1;

// Used by Swift for the print function
int putchar(int c) {
    int rtn = vexSerialWriteChar(STDIO_CHANNEL, c);

    while (vexSerialWriteFree(STDIO_CHANNEL) < 2048) {
        vexTasksRun();
    }

    return rtn == 1 ? c : EOF;
}

// Implementation of stdio for picolibc

static int serial_putc(char c, FILE *file);
static int serial_getc(FILE *file);
static int serial_flush(FILE *file);

static FILE stdio = {
    .flags = _FDEV_SETUP_RW,
    .put = serial_putc,
    .get = serial_getc,
    .flush = serial_flush,
};

// All 3 streams are aliased to the same `stdio` reference.
FILE *const stdin = &stdio;
extern FILE *const stdout [[gnu::alias("stdin")]];
extern FILE *const stderr [[gnu::alias("stdin")]];

int serial_putc(char c, FILE *file) {
    return 0;
}

int serial_getc(FILE *file) {
    return 0;
}

int serial_flush(FILE *file) {
    return 0;
}

void _exit(int code) {
    vexSystemExitRequest();

    while (true) {
        vexTasksRun();
    }
}

int getentropy(void *buf, size_t buflen) {
    return 0;
}