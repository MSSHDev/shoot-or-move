#!/bin/bash

# makefile
clear
nasm -f elf32 main-lin.asm -o main.o
nasm -f elf32 sprites-lin.asm -o sprites.o
gcc -m32 getch.c main.o sprites.o -o main

./main