#ifndef BACKPATCH_H
#define BACKPATCH_H

#include "cuadruplas.h

typedef struct _LINDEX {
  struct _LINDEX* next;
  int *items;
  int i;
} LINDEX;


LINDEX *init_list_index(LINDEX l)

LINDEX* create_list(int l);
LINDEX* combinar(LINDEX *l1, LINDEX *l2);
void backpatch(LINDEX *l, LINDEX *l2);
LINDEX* newLINDEX();
#endif
