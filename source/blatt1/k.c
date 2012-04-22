#include <stdio.h>

struct list_elem {
	struct list_elem *previous;
	int value;
};

void main() {
	struct list_elem *last = NULL, *next_elem;
	
	// Read numbers and store them in the linked list
	int val = 0;
	int exit = 0;
	while(!exit) {
		if(scanf("%d", &val)) {
			next_elem = (struct list_elem *) malloc(sizeof(struct list_elem));
			next_elem->value = val;
			next_elem->previous = last;
			last = next_elem;
		} else {
			exit = 1;
		}
	}
	
	while(last != NULL) {
		printf("%d\n", last->value);
		
		// Remove element from list and free it.
		next_elem = last;
		last = last->previous;
		free(next_elem);
	}
}

