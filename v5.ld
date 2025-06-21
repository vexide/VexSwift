OUTPUT_FORMAT("elf32-littlearm")

ENTRY(_boot)

__user_ram_start = 0x03800000;
__user_ram_length = 48M;
__user_ram_end = __user_ram_start + __user_ram_length; /* 0x08000000 */

__code_signature_length = 0x20;

__stack_length = 4M;
__heap_end = __user_ram_end - __stack_length;

/* see https://github.com/llvm/llvm-project/blob/main/libunwind/src/AddressSpace.hpp#L78 */
/* __eh_frame_hdr_start = SIZEOF(.eh_frame_hdr) > 0 ? ADDR(.eh_frame_hdr) : 0;
__eh_frame_hdr_end = SIZEOF(.eh_frame_hdr) > 0 ? . : 0; */

MEMORY {
    USER_RAM : ORIGIN = __user_ram_start, LENGTH = __user_ram_length
}

SECTIONS {
    /*
     * VEXos expects program binaries to have a 32-byte header called a "code signature",
     * at their start, which tells the OS that we are a valid program and configures some
     * miscellaneous startup behavior.
     */
    .code_signature : {
        KEEP(*(.code_signature))
        . = __user_ram_start + __code_signature_length;
    } > USER_RAM

    .text : {
        *(.boot)
        *(.text .text.*)
    } > USER_RAM

    /* Global/uninitialized/static/constant data sections. */
    .rodata : {
        *(.rodata .rodata.*)
        /* Global Offset Table, used for resolving globals */
        *(.got*)
    } > USER_RAM

    /*
     * These sections are added by the compiler in some cases to facilitate stack unwinding.
     * __eh_frame_start and similar symbols are used by libunwind.
     */
    /* .eh_frame_hdr : {
        KEEP(*(.eh_frame_hdr))
    } > USER_RAM

    .eh_frame : {
        __eh_frame_start = .;
       KEEP(*(.eh_frame))
        __eh_frame_end = .;
    } > USER_RAM

    .ARM.exidx : {
        __exidx_start = .;
        *(.ARM.exidx*)
        __exidx_end = .;
    } > USER_RAM

    .ARM.extab : {
        __extab_start = .;
        *(.ARM.extab*)
        __extab_end = .;
    } > USER_RAM */

    .data : {
        *(.data .data.*)
    } > USER_RAM

    /*
     * .tdata must be at least as aligned as .tbss so memcpy-ing the entire
     * TLS block to an address with alignment `__tls_align` works as expected.
     *
     * See: https://github.com/picolibc/picolibc/commit/de46cd909e6cad136e4c97c45c74f47cb4b00426
     */

    .tdata : ALIGN(__tls_align) {
        __tls_base = .;
        __tdata_start = .;

        *(.tdata .tdata.* .gnu.linkonce.td.*)

        __tdata_end = .;
    } > USER_RAM

    /* __bss_start includes .tbss because both of them need to be zeroed on startup */

    .tbss (NOLOAD) : {
        __bss_start = .;
        __tbss_start = .;

        *(.tbss .tbss.*)
        *(.tcommon)

        __tls_end = .;
        __tbss_end = .;
    } > USER_RAM

    __tls_align = MAX(ALIGNOF(.tdata), ALIGNOF(.tbss));
    __arm32_tls_tcb_offset = MAX(8, __tls_align);


    .bss (NOLOAD) : {
        *(.bss .bss.*)
    } > USER_RAM

    __bss_end = .;

    /* Active memory regions for the stack/heap. */
    .heap (NOLOAD) : ALIGN(8) {
        __heap_start = .;
        . = __heap_end;
    } > USER_RAM

    __heap_length = __heap_end - __heap_start;

    .stack (NOLOAD) : ALIGN(8) {
        __stack_bottom = .;
        . += __stack_length;
        __stack_top = .;
    } > USER_RAM

    /*
     * `.ARM.attributes` contains arch metadata for compatibility purposes, but we
     * only target one hardware configuration, meaning it'd just take up space.
     */
    /DISCARD/ : {
        *(.ARM.attributes*)
    }

    /* Throw away exception handling data for now */
    /DISCARD/ : {
        *(.ARM.exidx*)
        *(.ARM.extab*)
		*(.note .note.*)
        *(.eh_frame_hdr)
		*(.eh_frame .eh_frame.*)
    }

    /* Unused Swift metadata */
    /DISCARD/ : {
        *(.swift_modhash*)
        *(.swift_ast*)
    }

    /* ELF metadata sections */
    /* These are not loaded into the final BIN, but stay in the ELF to help with debugging */
    /* All are given an offset of 0 for proper semantics */
    .symtab   0 : { *(.symtab) }
    .strtab   0 : { *(.strtab) }
    .shstrtab 0 : { *(.shstrtab) }
    .debug    0 : { *(.debug*) }
    .comment  0 : { *(.comment) }
}