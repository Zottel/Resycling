BASE = C:\TC
CC = $(BASE)\BIN\TCC.EXE
MODEL = -ms
CFLAGS = $(MODEL)

# General Purpose Rules

%.obj: %.c
	echo "Building $<.obj"
	$(CC) $(CFLAGS) -o$<.obj -c $<.c

%.exe: %.obj
	echo "Building $<.exe"
	$(CC) $(CFLAGS) -e $<.exe $<.c

all: a.exe b.exe c.exe d.exe e.exe f.exe g.exe h.exe i.exe j.exe k.exe l.exe m.exe n.exe o.exe p.exe
