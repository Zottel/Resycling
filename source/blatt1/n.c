#include <stdio.h>
#include <stdlib.h>

void swap(int *val1, int *val2) {
    int temp = *val2;
    *val2 = *val1;
    *val1 = temp;
}

void quicksort(int *left, int *right) {

    if(left<right) {                 //list contains more than one element

        //partition list, using rightmost element as pivot
        int pivot_val = *right;
        int *pivot_pos = left;

        int *i;
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

    int *list;
    int length,i;

    FILE *list_file;
    list_file = fopen(*(argv+1),"r");

    if(list_file != NULL) {
        fread(&length, sizeof(int), 1, list_file);

        list = calloc(length,sizeof(int));

        fread(list, sizeof(int), length, list_file);

        quicksort(list,list+(length-1));

        for(i=0; i<length; i++)
            printf("%d ", *(list+i));
    }

    fclose(list_file);
    free(list);
}
