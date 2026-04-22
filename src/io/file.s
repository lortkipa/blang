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

.section .text

    # rdi - file name
    # ret eax - file descriptor
    .global file_create
    file_create:
        mov eax, SYS_CALL.OPEN
        mov esi, OPEN_FLAG.WRITE | OPEN_FLAG.CREATE
        mov edx, OPEN_MODE.OWNER_WRITE | OPEN_MODE.OWNER_EXEC
        syscall

        cmp eax, 0
        jl file_not_created_err

        ret
