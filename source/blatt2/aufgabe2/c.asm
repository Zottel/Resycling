bits 16

org 0x100

main:
   
    mov di, [prev_ptr]
    
    .eingabe_schleife:
        ;Lese Zeichen, beende einlsen bei leerer Eingabe
        call readChars
        cmp al,0x0d
        je .e_ende
        
        call list_push
        jmp .eingabe_schleife

    .e_ende:

    .ausgabe_schleife:

	call list_pop
	or ax, ax
	jz .a_ende
	
	call writeChars
	call endl

        jmp .ausgabe_schleife

    .a_ende:
        jmp 0

list_push:
	mov di, [next_ptr]
	
	; Save ax to list element
	stosw
	
	; Save prev_ptr to struct
	mov ax, [prev_ptr]
	stosw
	
	; set prev_ptr to current element
	mov bx, WORD [next_ptr]
	mov WORD [prev_ptr], bx
	
	; Store location of the next free memory slot
	mov [next_ptr], di
	
	ret

list_pop:
	mov si, [prev_ptr]
	
	; When prev_ptr is NULL, return 0
	or si, si
	jnz .notnull
		xor ax, ax
		ret
	.notnull:
	
	; Load data word
	lodsw
	push ax
	
	; Load pointer to previous element
	lodsw
	
	; remember to "free" memory slot
	mov bx, WORD [prev_ptr]
	mov WORD [next_ptr], bx
	
	; Set prev_ptr to the previous element
	mov [prev_ptr], ax
	
	pop ax
	ret

readChars:
    ;String mit 2 Zeichen einlesen und in ax schreiben
    xor ah, ah
    int 0x16
    mov ah, 0x0e
    int 0x10
    mov bl, al

    xor ah, ah
    int 0x16
    mov ah, 0x0e
    int 0x10
    mov bh, al

    call endl

    mov ax, bx

    ret

writeChars:
    ;Erstes Zeichen in ax ausgeben
    push ax
    mov cx, 0x01
    mov ah, 0x0e
    int 0x10

    ;Zweites Zeichen
    pop ax
    mov cx, 0x01
    mov al, ah
    mov ah, 0x0e
    int 0x10

    ret

endl:
    mov ah, 0x0e
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10

    ret

prev_ptr dw 0
next_ptr dw code_end

code_end:
