.intel_syntax noprefix

.section .text

    .macro EXIT code
        mov eax, 60
        mov edi, \code
        syscall
    .endm

    .global exit_success
    exit_success:
        EXIT 0

    .global exit_failure
    exit_failure:
        EXIT 1
