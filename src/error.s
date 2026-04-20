.intel_syntax noprefix

.section .rodata

    file_not_created_err.str: .ascii "File not created\n"
    .set file_not_created_err.len, $ - file_not_created_err.str

.section .text

    .global file_not_created_err
    file_not_created_err:
        lea rsi, [rip + file_not_created_err.str]
        mov edx, file_not_created_err.len
        call print_err

        jmp exit_failure
