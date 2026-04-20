.intel_syntax noprefix

.section .rodata

    code: .ascii "main(): i32 {\n"
          .ascii "ret 0\n"
          .ascii "}\n\0"

    file_name: .string "test_file"

.section .text

    .global main
    main:
        lea rdi, [rip + file_name]
        call file_create

        jmp exit_success
