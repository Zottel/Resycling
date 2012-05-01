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
	
	; Pointer a in ax, *a in bx, b in cx
	mov ax, [bp + 4]
	mov si, ax
	mov bx, [si]
	mov cx, [bp + 6]

	add bx, cx

	; *a = bx
	mov di, ax
	mov [di], bx

	; Benutzte Register
	pop di
	pop si
	pop cx
	pop bx
	pop ax
	pop bp
ret

