org 0x100

main:
	; Start der Kommandozeile
	mov di, 0x0081
	
	; Suche erstes Leerzeichen, darauf folgend der erste Parameter
	mov al, ' '
	cld
	repne	scasb
	mov dl, [di]
	
	; Zweites Leerzeichen, zweiter Parameter
	repne	scasb
	mov dh, [di]
	
	; Zähle Zeichen hoch und gebe aus
	schleife:
		mov ah, 0x02
		int 0x21
		inc dl
		cmp dh, dl
		jae schleife
	
	; Programm vorbei
	jmp 0
