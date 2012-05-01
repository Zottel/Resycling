BASE = C:\TC
CC = $(BASE)\BIN\TCC.EXE
ASM = C:\NASM\NASM.EXE
MODEL = -ms
CFLAGS = $(MODEL)

a.exe: a.c bthex.c
    $(CC) -1 -ms -ea.exe a.c bthex.c
    
b.exe: a.c bthex.asm
    $(ASM) -f obj -o bthex.obj bthex.asm
    $(CC) -ms -eb.exe a.c bthex.obj

all: a.exe b.exe
