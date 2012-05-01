#include <stdlib.h>
#include <stdio.h>
#include "bthex.h"

int main() {
	int i;
	double zahl;
	unsigned char *laeufer = NULL;
	
	// Double sind 8 bytes => 16 hex ascii chars + '\0' = 17
    char ausgabe[17];	

	puts("Bitte Zahl eingeben: ");
	
	if(scanf("%lf", &zahl)) {
		// Schreibe von BTHEX zurückgegebene Zeichen in Ausgabestring
		for(i = 0; i < 8; i++, laeufer++) {
			*(int *)(ausgabe + (2 * i)) = BTHEX(*laeufer);
		}
		
		// Nullterminator des Strings
		ausgabe[16] = '\0';
		
		puts(ausgabe);
		
	} else {
		fputs("Zahl im falschen Format!", stderr);
	}
	
	return 0;
}
