[bits 16]

global _add


segment _TEXT CLASS=CODE

; add(int * a, b)
_add:
	; Stackfram
	push bp
	mov bp, sp

	; Benutzte Register
	push ax
	push bx
	push cx
	push si
	push di
	push ds
	
	; Pointer a in ax, *a in bx, b in cx
	mov ax, [bp + 6]
	mov si, ax
	mov ds, [bp + 8]
	mov bx, [ds:si]
	mov cx, [bp + 10]

	add bx, cx

	; *a = bx
	mov di, ax
	mov [ds:di], bx

	; Benutzte Register
	pop ds
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop bp
retf

