#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

void main(int argc, char *argv[]) {
	char zeichen1, zeichen2, zaehler;

	if(argc != 3) {
		fprintf(stderr, "Ungültiger Aufruf.\n Erwartet: %s <Zeichen 1> <Zeichen 2>\n", argv[0]);
		exit(1);
	}
	
	if(strlen(argv[1]) > 1 || strlen(argv[2]) > 1) {
		fprintf(stderr, "Erwarte nur einzelne Buchstaben als Parameter.\n");
		exit(2);
	}
	
	zeichen1 = *argv[1];
	zeichen2 = *argv[2];
	
	// Annahme: Eingaben sinnvoll gewählt.
	// Sonst fehlt eine genaue Spezifikation des Verhaltens
	
	for(zaehler = zeichen1; zaehler <= zeichen2; zaehler++) {
		putchar(zaehler);
	}
	putchar('\n');
}

