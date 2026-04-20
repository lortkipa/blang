.intel_syntax noprefix

.include "sys.inc"

.section .text

    .macro EXIT code
        mov eax, SYS_CALL.EXIT
        mov edi, \code
        syscall
    .endm

    .global exit_success
    exit_success:
        EXIT SYS_EXIT.SUCCESS

    .global exit_failure
    exit_failure:
        EXIT SYS_EXIT.FAILURE
