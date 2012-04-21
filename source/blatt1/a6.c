#include <stdlib.h>
#include <stdio.h>
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
		//TODO: bthex benutzen
		printf("Menge: %x\n", m);
	}while(input);
}
