# makefile
clear
nasm -f elf32 main-lin.asm -o main.o
nasm -f elf32 sprites-lin.asm -o sprites.o
gcc main.o sprites.o -o main

./main