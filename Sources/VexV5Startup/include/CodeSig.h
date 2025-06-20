#pragma once

#include <stdint.h>

// Code signature magic number, "VXV5"
#define V5_CODESIG_MAGIC 0x35585658

// Identifies the type of binary to VEXos.
typedef enum : uint32_t {
    PROGRAM_TYPE_USER = 0,
} ProgramType;

// The owner (originator) of the user program
typedef enum : uint32_t {
    PROGRAM_OWNER_SYSTEM = 0,
    PROGRAM_OWNER_USER = 1,
    PROGRAM_OWNER_PARTNER = 2,
} ProgramOwner;

// Program Flags
//
// These bitflags are part of the `CodeSignature` and determine some small
// aspects of program behavior when running under VEXos. This struct contains
// the flags with publicly documented behavior.
typedef enum : uint32_t {
    // Inverts the background color to pure white.
    PROGRAM_FLAGS_INVERT_DEFAULT_GRAPHICS = (1 << 0),
    // VEXos scheduler simple tasks will be killed when the program requests exit.
    PROGRAM_FLAGS_KILL_TASKS_ON_EXIT = (1 << 1),
    // If VEXos is using the Light theme, inverts the background color to pure white.
    PROGRAM_FLAGS_THEMED_DEFAULT_GRAPHICS = (1 << 2),
} ProgramFlags;

// Code Signature
//
// The first 16 bytes of a user code binary should contain the user code
// signature.

typedef struct [[gnu::packed]] {
    // Magic, must be 'VXV5' 0x35565856 le
    uint32_t magic;
    // Program type
    ProgramType type;
    // Program originator
    ProgramOwner owner;
    // Program options
    ProgramFlags options;
} CodeSignature;
