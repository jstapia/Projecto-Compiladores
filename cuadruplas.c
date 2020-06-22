#include <stdio.h>
#include <stdlib.h>
#include "cuadruplas.h"

//crea_quad
quad* init_quad(char *op , char *arg1, char *arg2, char *res){
	quad *q;
	q = malloc(sizeof(quad));
	q->op = op;
	q->arg1 = arg1;
	q->arg2 = arg2;
	q->res = res;
	return q;
}

//elimina_quad
void finish_quad(quad *q){
	while(q != NULL){
		elimina_quad(q->next);
	}
	free(q);
}


//void crea_code
code* init_code(){
	code *c;
	c = malloc(sizeof(code));
	c->root = malloc(sizeof(quad));
	c->num_instrucciones = 0;
	return c;
}

//elimina_code
void finish_code(code *c){
	free(c);
	finish_quad(c->root);
    printf("Se elimino una lista de codigo");
}


// void append_quad(CODE* c, QUAD *cd)
void append_quad(code* c  Quad *cd)
{
  if (c->num_instru == 0) {
	c->tail = cd;
	c->head = cd;
  }else{
	c->tail->next = cd;
	c->tail  = cd;
  }
  c->num_instru++;
}

//void agregar_cuadrupla(code* c, char *op, char* arg1, char *arg2, char* res){

void append_new_quad(code* c, char *op, char* arg1, char *arg2, char* res){
	quad *q, *q_temp;
	q = init_quad(op,arg1,arg2,res);
	if(c->root == NULL)
		c->root = q;
	else{
		q_temp = c->root;
		while(q_temp->next != NULL)
			q_temp = q_temp->next;
		q_temp->next = q;
		q->next = NULL;
	}
	c->num_instrucciones++;
}

//QUAD *search_quad_index(CODE *c,char *i){

