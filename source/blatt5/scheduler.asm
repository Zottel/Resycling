bits 16

extern prozess1, prozess2, prozess3, prozess4

;-----------------------------;
SEGMENT _TEXT PUBLIC CLASS=CODE
;-----------------------------;


main:
	;WASCO karte initialisieren
	;--------------------------
	mov al, 0x01
	out 0xe021, al ;OPTOIN interrup aktivieren
	;Interrupts zuruesetzen
	in al, 0xe020
	in al, 0xe021
	in al, 0xe022
	in al, 0xe023
	in al, 0xe024
	in al, 0xe025
	in al, 0xe026
	in al, 0xe027

	;ISR aufsetzten
	;-------------
	push es
	xor ax, ax
	mov es ,ax
	;Alte ISR sichern
	mov ax, WORD [es:52]
	mov WORD [orig_off] , ax
	mov ax, WORD [es:54]
	mov WORD [orig_seg], ax
	;Eigene ISR setzen
	mov WORD [es:52], scheduler
	mov WORD [es:54], seg scheduler
	pop es

	xor ax, ax
	jmp first_jump

scheduler:
	; DS wird gebraucht für globale variablen
	push ds
	; AX wird zum Zwischenspeichern von Werten benötigt
	push ax
	
	; Datensegment der globalen Variablen und Structs des Schedulers
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
	
	; Prozesszustand fertig gesichert
	; Aktiver Prozess in AX
	
	; OPTOIN Interrupt?
	in bl, 0xe44c
	cmp bl, 0x04 
	jne first_jump
	; Welcher Schalter?
	in bl, 0xe00e
	
	cmp bl, 0x01
	jne .not_0
	mox ax, 0
	jmp .switch_end

	.not_0:
	cmp bl, 0x02
	jne .not_1
	mox ax, 1
	jmp .switch_end

	.not_1:
	cmp bl, 0x04
	jne .not_2
	mox ax, 2
	jmp .switch_end

	.not_2:
	cmp bl, 0x08
	jne .not_3
	mox ax, 3
	jmp .switch_end
	
	.not_3:
	jmp first_jump

	.switch_end:

	;Reset OPTOIN Interrupt
	in bl, 0xe020
	in bl, 0xe021
	in bl, 0xe022
	in bl, 0xe023
	in bl, 0xe024
	in bl, 0xe025
	in bl, 0xe026
	in bl, 0xe027
	
	;Reset PIC
	mov bl, 0x20
	out 0x20, bl

	; Nummer des nächsten Prozesses wird hier in AX erwartet.
	first_jump:
		mov [activeThread], ax
		mov di, state0
		mov bx, state_size
		mul bx         ; Resultat in DX:AX - DX wird verworfen
		add di, ax
	
	
error:
	jmp $

;-----------------------------;
SEGMENT _DATA PUBLIC CLASS=DATA
;-----------------------------;

orig_seg: dw 0
orig_off: dw 0

activeThread: dw 0

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
	dw stack0 ; SP
	st_bp equ ($ - state0)
	dw 0 ; BP
	st_es equ ($ - state0)
	dw 0 ; ES
	st_ss equ ($ - state0)
	dw seg initial_stacks ; SS	
	state_size equ ($ - state0)

state1:
	dw 0 ; FLAGS
	dw 0 ; DI
	dw 0 ; SI
	dw 0 ; AX
	dw 0 ; BX
	dw 0 ; CX
	dw 0 ; DX
	dw stack1 ; SP
	dw 0 ; BP
	dw 0 ; ES
	dw seg initial_stacks ; SS	

state2:
	dw 0 ; FLAGS
	dw 0 ; DI
	dw 0 ; SI
	dw 0 ; AX
	dw 0 ; BX
	dw 0 ; CX
	dw 0 ; DX
	dw stack2 ; SP
	dw 0 ; BP
	dw 0 ; ES
	dw seg initial_stacks ; SS	

state3:
	dw 0 ; FLAGS
	dw 0 ; DI
	dw 0 ; SI
	dw 0 ; AX
	dw 0 ; BX
	dw 0 ; CX
	dw 0 ; DX
	dw stack3 ; SP
	dw 0 ; BP
	dw 0 ; ES
	dw seg initial_stacks ; SS	

initial_stacks:
	        dw seg prozess1
	        dw     prozess1
	        dw 0 ; DS Anfangswert
	stack0: dw 0 ; AX Anfangswert
	        dw seg prozess2
	        dw     prozess2
	        dw 0 ; DS Anfangswert
	stack1: dw 0 ; AX Anfangswert
	        dw seg prozess3
	        dw     prozess3
	        dw 0 ; DS Anfangswert
	stack2: dw 0 ; AX Anfangswert
	        dw seg prozess4
	        dw     prozess4
	        dw 0 ; DS Anfangswert
	stack3: dw 0 ; AX Anfangswert
