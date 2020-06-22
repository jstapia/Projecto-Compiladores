#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "backpatch.h"

//create_list
label *init_list_index(int l){
	
	label *list = malloc(sizeof(label));
	list->items = malloc(sizeof(int) * 100);
	list->i = 0;
	list->items[list->i] = l;
	list->i++;
	return list;
}

/* Funcion encargadad de copiar las listas de ambas etiquetas. */
//merge
label *combinar (label *l1, label *l2){
	label *l = malloc(sizeof(label));
	l = l1;
	for(int i = 0; i < l2->i; i++){
		l->items[l->i] = l2->items[i];
		l->i++;
	}
	return l;
}



/* Funcion encargada de cambiar la localizacion donde se almacenara el resultado. */
void backpatch(label *l, label *l2){
	char res[100];
	int inst;
	if(l2){
		inst = l2->i;
	}else{
		inst = -1;
	}
	quad *q = CODE.root;
	for(int i = 0; i < l->i ; i++){
		sprintf(res, "%d", inst);
		strcpy((CODE.root[l->items[i]]).res, res);
	}
	
}
