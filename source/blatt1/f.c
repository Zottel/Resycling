#include <stdlib.h>
#include <stdio.h>
#include "bthex.h"

int main() {
	unsigned int zahl;
	
	char *ausgabe = (char *) calloc(5, sizeof(char));
	
	puts("Bitte Hexadezimalzahl eingeben: ");
	
	if(scanf("%x", &zahl)) {
		// Schreibe von BTHEX zurückgegebene Zeichen in Ausgabestring
		*(int *)ausgabe = bthex(zahl >> 8);
		*(int *)(ausgabe + 2) = bthex(zahl & 0xFF);
		
		// Nullterminator des Strings
		ausgabe[4] = '\0';
		
		puts(ausgabe);
		
	} else {
		fputs("Zahl im falschen Format!", stderr);
	}
	
	return 0;
}
