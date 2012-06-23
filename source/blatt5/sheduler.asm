bits 16

;-----------------------------;
SEGMENT _TEXT PUBLIC CLASS=CODE
;-----------------------------;


sheduler:
	; DS wird gebraucht für globale variablen
	push ds
	; AX wird zum Zwischenspeichern von Werten benötigt
	push ax
	
	; Datensegment der globalen Variablen und Structs des Shedulers
	mov ax, seg activeThread
	mov ds, ax
	
	; Jetzt kann AX in einen globalen Zwischenspeicher geschoben werden…
	pop ax
	mov [tmp_ax], ax
	
	; Damit auf dem Stack noch Platz für die flags ist
	pushf
	pop ax
	mov [tmp_flags], ax
	
	cmp BYTE [activeThread], 0x00
	jne .t_1
		mov [state0 + st_di], di
		mov di, state0
		jmp .t_any
	.t_1:

	cmp BYTE [activeThread], 0x01
	jne .t_2
		mov [state1 + st_di], di
		mov di, state1
		jmp .t_any
	.t_2:

	cmp BYTE [activeThread], 0x02
	jne .t_3
		mov [state2 + st_di], di
		mov di, state2
		jmp .t_any
	.t_3:

	cmp BYTE [activeThread], 0x03
	jne $ ; ERROR
		mov [state3 + st_di], di
		mov di, state3
		jmp .t_any
	
	.t_any:
		; Zwischengespeicherte Register in das Struct des Prozesses kopieren
		mov ax, tmp_flags
		mov [di + st_fl], ax
		mov ax, tmp_ax
		mov [di + st_ax], ax
		; Restliche Register sichern
		mov [di + st_si], si
		mov [di + st_bx], bx
		mov [di + st_cx], cx
		mov [di + st_dx], dx
		mov [di + st_sp], sp
		mov [di + st_bp], bp
		mov ax, es
		mov [di + st_es], ax
		mov ax, ss
		mov [di + st_ss], ax
	
	; Prozesszustand fertig gesichert, nächsten Prozess auswählen
	mov al, [activeThread]
	inc al
	cmp al, 0x03
	jle .nowrap
		mov al, 0x00
	.nowrap:
	
	mov [activeThread], al
	mov di, [state0 + state_size * al]

error:
	jmp $

;-----------------------------;
SEGMENT _DATA PUBLIC CLASS=DATA
;-----------------------------;

activeThread: db 0

tmp_flags: dw 0
tmp_ax: dw 0

state0:
	st_fl equ ($ - state0)
	dw 0 ; FLAGS
	st_di equ ($ - state0)
	dw 0 ; DI
	st_si equ ($ - state0)
	dw 0 ; SI
	st_ax equ ($ - state0)
	dw 0 ; AX
	st_bx equ ($ - state0)
	dw 0 ; BX
	st_cx equ ($ - state0)
	dw 0 ; CX
	st_dx equ ($ - state0)
	dw 0 ; DX
	st_sp equ ($ - state0)
	dw 0 ; SP
	st_bp equ ($ - state0)
	dw 0 ; BP
	st_es equ ($ - state0)
	dw 0 ; ES
	st_ss equ ($ - state0)
	dw 0 ; SS
	state_size equ ($ - state0)
	
state1:
	dw 0 ; SI
	
state2:
	dw 0 ; SI

state3:
	dw 0 ; SI
	
