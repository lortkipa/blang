.intel_syntax noprefix

.include "sys.inc"

# 'system open' flags
.set OPEN_FLAG.READ, 0
.set OPEN_FLAG.WRITE, 1 
.set OPEN_FLAG.READ_WRITE, 2
.set OPEN_FLAG.CREATE, 64

# 'system open' modes
.set OPEN_MODE.OWNER_EXEC, 0100
.set OPEN_MODE.OWNER_WRITE, 0200
.set OPEN_MODE.OWNER_READ, 0400

# elf header
elf_header:
    .byte 0x7F, 0x45, 0x4c, 0x46 # magic number
    .byte 2 # 1 - 32bit format; 2 - 64bit format;
    .byte 1 # 1 - little endianness; 2 - big endianness;
    .byte 1 # set 1 if original/current version elf
    .byte 0x00 # os: 0x00 - sysv; 0x03 - linux;
    .byte 0 # ignore (not linux thing)
    .skip 7 # reserved
    .word 0x02 # file type: 0x00 - unknown; 0x01 - relocatable; 0x02 - executable; 0x03 - shared;
    .word 0x3E # instruction set architecture: 0x03 - x86; 0x3E - x64;
    .long 1 # 1 - original elf version;
    .quad 0 # entry address
    .quad 0 # program header table address
    .quad 0 # section header table address
    .long 0 # flags
    .word 64 # header size
    .word 0x38 # program header table entry size
    .word 0 # number if entries in prorgam header table
    .word # section header table entry size
    .word # index of section header table entry wich contains section names
.set elf_header.size, $ - elf_header

.section .text

    # rdi - file name
    # ret eax - file descriptor
    .global file_create
    file_create:
        mov eax, SYS_CALL.OPEN
        mov esi, OPEN_FLAG.WRITE | OPEN_FLAG.CREATE
        mov edx, OPEN_MODE.OWNER_READ | OPEN_MODE.OWNER_WRITE | OPEN_MODE.OWNER_EXEC
        syscall

        cmp eax, 0
        jl file_not_created_err

        ret

    # edi - file descriptor
    .global file_write
    file_write:
        mov eax, SYS_CALL.WRITE
        lea rsi, [rip + elf_header]
        mov rdx, elf_header.size
        syscall

        cmp eax, 0
        jl file_not_written_err

        ret
