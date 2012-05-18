[BITS 16]

global _main

extern _printf

segment _TEXT CLASS=CODE

_main:

    ;Write Prompt
    push seg prompt
    push prompt
    call far _printf
    add sp, 0x04

    ;Read command
    mov ah, 0x0a
    push ds
    mov dx, seg CmdLine
    mov ds, dx
    mov dx, CmdLine
    int 0x21
    pop ds
    
    ;Search space
    push ds
    push es
    mov dx, seg CmdLine
    mov ds, dx
    mov es, dx
    mov si, CmdLine

    ; - ?
    cmp BYTE [ds:si+2], '-'
    je .exit

    .loop:
        lodsb
        
        ; Space?
        cmp al, ' '
        je .space
        
        ; Enter?
        cmp al, 0x0d
        jne .loop

    ;Without parameters
    dec si
    mov BYTE [ds:si], 0x00                ; Program name string terminator
    
    mov BYTE [ds:ParmLine], 0x00
    mov BYTE [ds:ParmLine + 1], 0x0d
    jmp .exec
    
    ; With parameters
    .space:
      dec si
      mov BYTE [ds:si], 0x00              ; Program name string terminator

      inc si

      mov di, ParmLine
      inc di
      mov al, ' '
      stosb
      
      xor cx, cx

      .copybyte:
        inc cx
        lodsb
        stosb
        cmp al, 0x0d
        jne .copybyte

      mov byte [ds:ParmLine], cl

    .exec:
    ;Insert newline
    mov bx, ds
    pop es
    pop ds
    push seg newline
    push newline
    call far _printf
    add sp, 0x04
    push ds
    push es
    mov ds, bx
    
    mov dx, CmdLine                  ; Program name asciz pointer
    add dx, 0x02

    mov ah, 0x4b
    mov al, 0x00
    mov bx, seg ParmBlock
    mov es, bx
    mov bx, ParmBlock
    
    int 0x21

    pop es
    pop ds

    ; Error?
    jnc .okay
    	push ax
    	push seg errormsg
    	push errormsg
    	call far _printf
    	add sp, 0x06
    .okay:
    jmp _main

    ret

    .exit
    pop es
    pop ds
    ret


segment _DATE CLASS=DATA

prompt: dw "-> ", 0

errormsg: db "Fehler: 0x%04x", 0x0d, 0x0a, 0x00

newline: db 0x0d, 0x0a, 0x00

ParmBlock:
    dw 0
    dw ParmLine
    dw seg ParmLine
    dw Fcb
    dw Fcb

Fcb db 3," ",0,0,0,0,0

CmdLine db 0x40, 0x00
        times 62 db 0
        
ParmLine db 0x00
         times 63 db 0

