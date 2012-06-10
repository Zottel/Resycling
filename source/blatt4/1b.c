#include <stdio.h>
#include "worep16.h"

#define IRQ 5
#define INT_ADDR 0x0D

ORE_ADR_PARAMS ore_adr_params;
int dev_count;

void interrupt (*old_int) (void);

unsigned char switches = 0;
unsigned char switch_buffer = 0;

int init() {
    
    if ((init_ore16_adrparams(&dev_count,&ore_adr_params) == SUCCESSFUL)) {
        //Set all three Timers to mode 3 
        outportb(ore_adr_params.tim8254_contr[0],0x36);
        outportb(ore_adr_params.tim8254_contr[0],0x76);
        outportb(ore_adr_params.tim8254_contr[0],0xB6);

        //Timer 1 clock = 4MHz -> count to 4 to fire every 1uS
        outportb(ore_adr_params.tim8254_0[0],0x04);
        outportb(ore_adr_params.tim8254_0[0],0x00);

        //Timer 2 clock from Timer 1 -> count to 1000 to fire every 1ms
        outportb(ore_adr_params.tim8254_1[0],0xE8);
        outportb(ore_adr_params.tim8254_1[0],0x03);

        //Timer 3 clock from Timer 2 -> count to 500 to interrupt every 500ms 
        outportb(ore_adr_params.tim8254_2[0],0xF4);
        outportb(ore_adr_params.tim8254_2[0],0x01);

        return 0;
    } else {
        return -1;
    }
}

void interrupt INT_SERV(void) {
    if( ((inportb(ore_adr_params.ore_int_status[0])) & 0x20) == 0x20) {   //Interrupt from timer
        
        unsigned char switches_temp;
        
        //Schalter lesen
        switches_temp = inportb(ore_adr_params.optoin_a[0]);

        //Barrel shift when unchanged
        if(switches_temp == switches) {
            asm rol switch_buffer,1;
        } else {
            switch_buffer = switches = switches_temp;
        }

        //Output to LEDs
        outportb(ore_adr_params.relout_a[0],switch_buffer);

        //Reset Timer interrupt
        inportb(ore_adr_params.timer_int_reset[0]);
    }

    //Send EOI to PIC1
    outportb(0x20,0x20);
}

void main() {
    
    //Init
    if(init()) {
        printf("Init failed!\n");
        return;
    }

    //Setup ISR

    old_int = getvect(INT_ADDR); //Get old ISR
    setvect(INT_ADDR,INT_SERV);  //Set own ISR

    outportb(0x21,(inportb(0x21)&~(1<<IRQ))); //Clear mask bit

    outportb(ore_adr_params.timer_int_contr[0],1); //Enable Timer interrupt on OPTORE
    inportb(ore_adr_params.timer_int_reset[0]); //Reset timer interrupt

    getch(); //waiting...

    //TODO Timer anhalten?

    outportb(ore_adr_params.timer_int_contr[0],0); //disable timer interrupt on OPTORE

    outportb(0x21,(inportb(0x21)|(1<<IRQ))); //Set amsk bit again

    setvect(INT_ADDR,old_int); //Restore old ISR
}
