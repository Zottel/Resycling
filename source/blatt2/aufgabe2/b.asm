org 0x100

main:
	
	.schleife:
		call read
		or ax, ax
		jz .ende

		mov [next_mem], ax
		mov [next_mem+2], prev_ptr
		mov prev_ptr, next_mem
		add next_mem, 4
		jmp .schleife

	.ende:
		


write:
	


;Lese Zahlen ein
read:
	mov dx, input_buffer
	mov ah, 0x0a
	int 0x21

	xor ax, ax
	xor dx, dx
	mov bx, 10
	mov si, input_buffer

	.schleife:
		mov dl, [si]
		cmp dl, 0x0d ;Enter eingegeben
		je .ende

		sub dl, '0'
		mul bx
		add ax, dx
		inc si
		jmp  .schleife
		
		.ende:
			ret




input_buffer: times 6 db 0
prev_ptr: dw 0
next_mem: equ code_end
code_end:

