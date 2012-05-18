CBASE = C:\TC
CC = $(CBASE)\BIN\TCC.EXE
ASM = C:\NASM\NASM.EXE
CFLAGS = 

all: a.exe b.exe c.exe d.exe e.exe f.exe

a.exe: a.asm
    $(ASM) -o a.com a.asm

b.exe: b.asm
	$(ASM) -f obj -o b.obj b.asm
    $(CC) -ml -eb.exe b.obj

c.exe: c.asm
	$(ASM) -f obj -o c.obj c.asm
    $(CC) -ml -ec.exe c.obj

d.exe: d.asm
	$(ASM) -f obj -o d.obj d.asm
    $(CC) -ml -ed.exe d.obj

e.exe: e.asm
	$(ASM) -f obj -o e.obj e.asm
    $(CC) -ml -ee.exe e.obj

f.exe: f.asm
	$(ASM) -f obj -o f.obj f.asm
    $(CC) -ml -ef.exe f.obj
