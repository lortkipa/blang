.intel_syntax noprefix

.include "sys.inc"

.section .text

    # rsi - string
    # edx - length
    .macro OUTPUT descriptor
        mov eax, SYS_CALL.WRITE
        mov edi, \descriptor
        syscall
    .endm

    # rsi - string
    # edx - length
    .global print
    print:
        OUTPUT SYS_DESCRIPTOR.OUT
        ret

    # rsi - string
    # edx - length
    .global print_err
    print_err:
        OUTPUT SYS_DESCRIPTOR.ERR
        ret
