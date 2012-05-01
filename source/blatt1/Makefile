BASE = C:\TC
CC = $(BASE)\BIN\TCC.EXE
MODEL = -ms
CFLAGS = $(MODEL)

# Special Purpose
bthex.obj:
	@echo "BTHEX is provided externally"

f.exe: f.obj bthex.obj
	@echo "Sonderregel: Aufgabe f wird gelinkt"
	$(CC) -ms -ef.exe f.obj bthex.obj

g.exe: g.obj bthex.obj
	@echo "Sonderregel: Aufgabe f wird gelinkt"
	$(CC) -ms -ef.exe f.obj bthex.obj

h.exe: f.obj ohex.obj
	@echo "Sonderregel: Aufgabe h wird gelinkt"
	$(CC) -ms -eh.exe f.obj ohex.obj

j.exe: j.obj ohex.obj
	@echo "Sonderregel: Aufgabe j wird gelinkt"
	$(CC) -ms -ej.exe j.obj ohex.obj

o.exe: o1.obj o2.obj
	@echo "Sonderregel: Aufgabe o wird gelinkt"
	$(CC) -ms -eo.exe o1.obj o2.obj

p1.obj: o1.c
	@echo "Kompiliere p1.obj mit Small Memory Model"
	$(CC) -ms -op1.obj -c o1.c

p2.obj: o2.c
	@echo "Kompiliere p2.obj mit Large Memory Model"
	$(CC) -ml -op2.obj -c o2.c

p.exe: p1.obj p2.obj
	@echo "Sonderregel: Aufgabe p wird gelinkt"
	$(CC) -ms -eo.exe p1.obj p2.obj

# General Purpose Rules

%.obj: %.c
	echo "Building $<.obj"
	$(CC) $(CFLAGS) -o$<.obj -c $<.c

%.exe: %.c
	echo "Building $<.exe"
	$(CC) $(CFLAGS) -e$<.exe $<.c

all: a.exe b.exe c.exe d.exe e.exe f.exe g.exe h.exe i.exe j.exe k.exe l.exe m.exe n.exe o.exe p.exe
