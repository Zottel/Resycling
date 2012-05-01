#include <stdlib.h>
#include <stdio.h>
#include "bthex.h"

typedef unsigned int menge;

menge maske(int nr) {
	return 0x0001 << (nr - 1);
}

menge einfuegen(menge m, int nr) {
	return m | maske(nr);
}

menge loeschen(menge m, int nr) {
	return m & ~maske(nr);
}

void main() {
	menge m = 0;
	int input = 0;
    char ausgabe[5];

	do{
		if(!scanf("%d", &input)) {
			errno = 0;
			input = 17;
		}

		if(input<0&&input>-17) {
			m = loeschen(m,-input);
		} else if(input>0&&input<17) {
			m = einfuegen(m,input);
		} else if(input!=0) {
			fprintf(stderr,"Unerwartete Eingabe!\n");
		}

        *(int *)ausgabe = BTHEX(m >> 8);
        *(int *)(ausgabe + 2) = BTHEX(m & 0xFF);
        
        ausgabe[4] = '\0';

        puts(ausgabe);

	}while(input);
}
