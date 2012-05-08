bits 16

readNum:
	push dx
	push bx
	push si
	
	; Read at most 6 chars to our input buffer
	mov BYTE [.read_buffer], 6
	mov dx, .read_buffer
	mov ah, 0x0a
	int 0x21
	
	; Initialisiere Schleifenregister
	mov si, .read_buffer
	xor ax, ax
	xor dx, dx
	mov bx, 0x000A
	
	.parseLoop:
		; ax = ax * 10 + dx
		mul bx
		add ax, dx
		
		; Nächstes Zeichen einlesen und testen ob es eine Ziffer ist
		mov dl, [si]
		inc si
		sub dl, '0'
		cmp dl, 0x09
		jle .parseLoop ; jump if less or equal
	
	.finished:
	; Anzahl gelesener Ziffern in cx
	mov cx, si
	sub cx, .read_buffer
	dec cx

	pop si
	pop bx
	pop dx
ret
.read_buffer: times 7 db 0

writeNum:
	; Ziffern werden "rückwärts" geschrieben
	std
	
	; in den .write_buffer
	mov di, .write_buffer
	dec .write_buffer
	
	.writeLoop:
	mov bx, 0x000A
	xor dx, dx
	div bx
	push ax
		mov al, dl
		stosb
	pop ax
	or ax, ax
	jnz .writeLoop
	
	; si auf das erste Zeichen setzen
	inc si
	
	; Puffer ausgeben
	mov dx, si
	mov ah, 0x09
	int 0x21
	
ret
.write_buffer: times 7 db '$'

