#include <stdio.h>
#include <stdlib.h>

void swap(unsigned int *val1, unsigned int *val2) {
    int temp = *val2;
    *val2 = *val1;
    *val1 = temp;
}

void quicksort(unsigned int *left, unsigned int *right) {

    if(left<right) {                 //list contains more than one element

        //partition list, using rightmost element as pivot
        unsigned int pivot_val = *right;
        unsigned int *pivot_pos = left;

        unsigned int *i;
        for(i = left; i<right; i++) {
            if(*i < pivot_val) {
                swap(i, pivot_pos);
                pivot_pos++;
            }
        }

        swap(pivot_pos,right);      //move pivot "between" the two parts

        //sort sublists
        quicksort(left,pivot_pos-1);
        quicksort(pivot_pos+1,right);
    }
}

void main(int argc, char **argv) {

    unsigned int *list;
    unsigned int length,i;

    FILE *list_file;
    list_file = fopen(*(argv+1),"rb");

    if(list_file != NULL) {
        fread(&length, sizeof(unsigned int), 1, list_file);
        printf("Sorting %d values...\n", length);

        list = calloc(length,sizeof(unsigned int));

        fread(list, sizeof(unsigned int), length, list_file);

        quicksort(list,list+(length-1));

        for(i=0; i<length; i++)
            printf("%u \t", *(list+i));
    }

    fclose(list_file);
    free(list);
}
