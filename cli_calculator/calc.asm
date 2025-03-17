    bits 64
    global _start

    SYS_EXIT equ 60
    STDIN equ 0
    STDOUT equ 1
    SYS_READ equ 0
    SYS_WRITE equ 1

    section .bss
buffer: resb len

    section .data
    len equ 1024

    section .text
_start:
    ; read
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, [buffer] ; buffer to store the read input
    mov rdx, len  ; length of buffer (see the label buffer)
    syscall

    ; write result
    mov rax, SYS_WRITE 
    mov rdi, STDOUT 
    mov rsi, [buffer] 
    mov rdx, len 
    syscall 

    ; exit
    mov rax, SYS_EXIT
    mov rdi, 0 ; error code
    syscall




