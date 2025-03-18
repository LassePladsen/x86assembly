nasm -f elf64 -o hello_world.o hello_world.asm \
    && ld -static -o hello_world hello_world.o
