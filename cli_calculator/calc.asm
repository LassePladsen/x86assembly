    bits 64

    SYS_EXIT equ 60
    STDIN equ 0
    STDOUT equ 1
    SYS_READ equ 0
    SYS_WRITE equ 1

section .bss
    input resb 1024
    output resb 1024

section .text
    global _start

_start:
    ; read
    mov rax, SYS_READ
    mov rdi, STDIN
    mov rsi, input ; buffer to store the read input
    mov rdx, 1024  ; length of buffer (see the label buffer)
    syscall

    ; mov r8, rax ; output is actual no. bytes read
    
    ; convert input to int
    mov rsi, input
    call ascii_to_int

    ; TODO: MATH
    
    ; convert output back to ascii
    mov rsi, rdi
    call int_to_ascii

    ; write result
    mov rax, SYS_WRITE 
    mov rdi, STDOUT 
    mov rsi, [rbx]
    mov rdx, 1024
    syscall

    ; exit
    mov rax, SYS_EXIT
    mov rdi, 0 ; error code
    syscall

ascii_to_int: ; input: rsi, output: rdi
    xor rcx, rcx ; Counter (more efficient way to set zero than mv)
    xor rdi, rdi ; rbx will hold the result
    call to_int_loop
    ret

to_int_loop:
    mov dl, byte [input + rcx] ; get current char from address of input start + counter which starts at zero

    ; Stop if we reached end of input (10 is ascii for newline)
    cmp dl, 10
    je return

    sub dl, 0x30 ; for numbers 0-9 you can convert from ascii to int by subtracting binary of value 0 (0x30) see ascii sheet and type out the binaries to understand
    and rdx, 0xFF    ; Clear all bits except the lowest 8 (same as dl)
    add rdi, rdx ; add this number to output

    inc rcx ; increment counter
    jmp to_int_loop
    
return:
    ret

int_to_ascii:
    xor rcx, rcx ; Counter (more efficient way to set zero than mv)
    xor rdi, rdi ; rbx will hold the result
    call to_ascii_loop
    ret

to_ascii_loop:
    mov dl, byte [rsi + rcx]

    add dl, 0x30 

    ; TODO :WTF
