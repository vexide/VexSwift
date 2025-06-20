#include "CodeSig.h"

[[gnu::weak]]
[[gnu::section(".code_signature")]]
struct CodeSignature code_signature = {
    .magic = V5_CODESIG_MAGIC,
    .type = PROGRAM_TYPE_USER,
    .owner = PROGRAM_OWNER_PARTNER,
    .options = 0,
};