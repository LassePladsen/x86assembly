bits 64
section .text
    global _start

_start:
    ; Write hello world
    mov rax, 1 ; syscall: write
    mov rdi, 1 ; filedescriptor: stdout
    mov rsi, msg ; buffer argument: message hello world
    mov rdx, len ; count to write: length of message
    syscall ; execute

    ; Exit 
    mov rax, 60 ; syscall: exit
    mov rdi, 0  ; error code 
    syscall

section .data
    msg db "Hello, World!", 10 
    len equ $ - msg ; find msg length
