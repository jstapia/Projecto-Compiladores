#ifndef QUAD_H
#define QUAD_H

typedef struct cuad QUAD;
struct _quad {
  char *op;
  char *arg1;
  char *arg2;
  char *res;
  quad *next;
};

// Funciones:
quad *init_quad(char *op, char *arg1, char *arg2, char *res);
void finish_quad(quad *q);   
  
code *init_code();
void finish_code(code *c);
 
void append_quad(code* c  Quad *cd);
void append_new_quad(code *c, char *op, char *arg1, char *arg2, char *res);

QUAD *search_quad_index(CODE *c,char *i);
#endif
