nasm -f elf64 -o calc.o calc.asm \
    && ld -static -o calc calc.o 
