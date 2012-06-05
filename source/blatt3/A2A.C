[BITS 16]

org 0x100

main:   
        ;Links oben
        xor bx,bx   ;Page 0
        xor dx,dx   ;Pos 0,0
        mov ah,0x02 ;Set cursor Position
        int 0x10

        mov ah,0x09 ;Write char
        mov al,'A'
        xor bh,bh   ;Page 0
        mov bl,0x0a ;Gruen
        mov cx,0x01 ;1Mal
        int 0x10

        ;Rechts oben
        xor bx,bx   ;Page 0
        mov dh,0        
        mov dl,79   ;Pos 0,79
        mov ah,0x02 ;Set cursor Position
        int 0x10

        mov ah,0x09 ;Write char
        mov al,'B'
        xor bh,bh   ;Page 0
        mov bl,0x0c ;Rot
        mov cx,0x01 ;1Mal
        int 0x10

        ;Rechts unten
        xor bx,bx   ;Page 0
        mov dh,24       
        mov dl,79   ;Pos 24,79
        mov ah,0x02 ;Set cursor Position
        int 0x10

        mov ah,0x09 ;Write char
        mov al,'C'
        xor bh,bh   ;Page 0
        mov bl,0x0e ;Gelb
        mov cx,0x01 ;1Mal
        int 0x10

        ;Links unten
        xor bx,bx   ;Page 0
        mov dh,24        
        mov dl,0   ;Pos 24,0
        mov ah,0x02 ;Set cursor Position
        int 0x10

        mov ah,0x09 ;Write char
        mov al,'D'
        xor bh,bh   ;Page 0
        mov bl,0x09 ;Blau
        mov cx,0x01 ;1Mal
        int 0x10          

        ;Reset color and Position
        xor bx,bx   ;Page 0
        mov dh,23        
        mov dl,0   ;Pos 23,0
        mov ah,0x02 ;Set cursor Position
        int 0x10
        
        mov ah,0x09 ;Write char
        mov al,' '
        xor bh,bh   ;Page 0
        mov bl,0x07 ;Grau
        mov cx,80 ;80Mal
        int 0x10          
        
        xor bx,bx   ;Page 0
        mov dh,22        
        mov dl,0   ;Pos 22,0
        mov ah,0x02 ;Set cursor Position
        int 0x10

        jmp 0
