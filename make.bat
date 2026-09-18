:: makefile complete
@echo off
cls
nasm -f win32 main.asm -o main.obj
nasm -f win32 sprites.asm -o sprites.obj
gcc -m32 main.obj sprites.obj -o main.exe

main.exe %1