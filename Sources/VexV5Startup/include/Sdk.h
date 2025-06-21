#include <stdint.h>

// SDK calls used for implementing stubbed libc functions

void vexTasksRun(void);
int32_t vexSerialWriteChar(uint32_t channel, uint8_t c);
int32_t vexSerialWriteFree(uint32_t channel);
