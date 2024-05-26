section .data
    hello_msg db 'Hello, World!', 0

section .text
    global main

main:
    ; Write 'Hello, World!' to stdout
    mov     rax, 1          ; syscall number for sys_write
    mov     rdi, 1          ; file descriptor 1 (stdout)
    mov     rsi, hello_msg  ; pointer to the string
    mov     rdx, 13         ; length of the string
    syscall

    ; Exit the program
    mov     rax, 60         ; syscall number for sys_exit
    xor     rdi, rdi        ; exit status 0
    syscall