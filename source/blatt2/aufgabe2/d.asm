[BITS 16]

global _main
extern _printf

segment _TEXT CLASS=CODE

_main:
   
   ;Durchlauf Zählen um Adresse von Main zu testen
   push WORD [durchlauf]
   push seg first_run
   push first_run
   call far _printf
   add sp, 0x06
   inc WORD [durchlauf]

  
   ;Segment des PSP holen
   mov ah,0x62
   int 0x21

   push bx
   push seg anfang
   push anfang
   call far _printf
   add sp, 0x04
   pop bx

   ;Ende berechnen
   mov dx, ds
   mov ds, bx
   mov bx, WORD [ds:0x02]
   sub bx, 0x01
   push bx
   mov ds, dx
   push seg ende
   push ende
   call far _printf
   add sp, 0x06

   ;Adresse von Main
   push _main
   push seg _main
   push seg smain
   push smain
   call far _printf
   add sp, 0x08

   ;Zum Testen zu Main springen
   ;cmp [seg durchlauf:durchlauf], 2
   ;je .ende
   ;   push ds
   ;   mov ds, seg _main
   ;   mov bx, _main
   ;   call far ds:bx
   ;   pop ds
   ;.ende:
   ;retf
   mov ah, 0x4c
   int 0x21

segment _DATA CLASS=DATA
   first_run db 'Durchlauf Nr. %d', 13, 10, 0 
   anfang db 'Anfang: 0x%x0', 13, 10, 0
   ende db 'Ende: 0x%xf', 13, 10, 0
   smain db 'Main: 0x%04x:0x%04x', 13, 10, 0
   durchlauf dw 1
