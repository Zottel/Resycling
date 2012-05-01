#include <stdlib.h>
#include <stdio.h>
#include "bthex.h"

int main() {
	unsigned int zahl;
	
    char ausgabe[5];

	puts("Bitte Hexadezimalzahl eingeben: ");
	
	if(scanf("%x", &zahl)) {
		// Schreibe von BTHEX zurückgegebene Zeichen in Ausgabestring
		*(int *)ausgabe = BTHEX(zahl >> 8);
		*(int *)(ausgabe + 2) = BTHEX(zahl & 0xFF);
		
		// Nullterminator des Strings
		ausgabe[4] = '\0';
		
		puts(ausgabe);
		
	} else {
		fputs("Zahl im falschen Format!", stderr);
	}
	
	return 0;
}
