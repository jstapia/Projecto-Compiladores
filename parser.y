#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include "tabla_simbolos.h"
#include "tabla_tipos.h"
#include "cuadruplas.h"
#include "backpatch.h"
#include "tipos.h"
#include "tabla_cadenas.h"
#include "pila_direcciones.h"

void yyerror(char *s);
extern int yylex();
extern char* yytext;
extern int yylineno;
void print_code(struct code *c);

// Variable que llevara el manejo de direcciones.
	int dir;
	int FuncType;
	int temp;
	bool FuncReturn;
	stack_dir stackDir;
	int tipo_g; 
	symstack *StackTS;
	stack_cad *StackCad;
	typestack *StackTT;
	ttype base;
	typetab *tt_global;
	symtab *ts_global;
	code CODE;
    int indice;
	int label_c;
    INDEX *indiceGlobal, *indiceAux; 
    LINDEX *prueba;

    // Variable que guardara la direccion cuando se haga un cambio de alcance.
	int dir_aux;
	// Variable que llevara la cuenta de variables temporales.
	int temporales;
	// Variable que indica la siguiente instruccion.
	int siginst;
	// Variable que guarda el tipo heredado.
	int global_tipo;
	// Variable que guardara la dimension heredada.
	int global_dim;
	// Variable que llevara el numero de parametros que tiene una funcion.
	int num_args;
	// Lista que guarda los tipos de los parametros.
	int* list_args;
	// Variable que nos ayuda a saber en que alcance estamos.
	int scope;
	// Variable que dice si hay un registro en camino
	int has_reg;

    void init();
	int busca_main();
	int existe_en_alcance(char*);
	int existe_globalmente(char*);
	char *reducir(char *dir, int t1, int t2);
	char *ampliar(char *dir, int t1, int t2);
	int max(int, int);
	void new_Temp(char*);
	char* newIndex();
	char* newTemp();
	void label_to_char(char* lchar, label l);
	void intToChar(char* out, int i); 
	void print_label(label *l);
	expresion operacion(expresion, expresion, char*);
	expresion numero_entero(int);
	expresion numero_flotante(float);
	expresion numero_doble(double);
	expresion funcion_e(char* f);
	expresion caracter(char);
	expresion variable_v(char* c);
	expresion cadena_s(char* c);
	condition relacional(condition e1, condition e2, char* oprel);

	expresion identificador(char *s);
	label *newLabel();

	void yyerror(char*);

%}


%start programa

%token<sval> ID
%token<num> NUM
%token INICIO
%token FIN
%token ENT
%token REAL
%token DREAL
%token CAR
%token SIN
%token REGISTRO
%token COMA
%token PT
%token FUNC
%token MIENTRAS
%token MIENTRAS_QUE
%token HACER
%token VERDADERO
%token FALSO
%token DEVOLVER
%token SEGUN
%token TERMINAR
%token CASO
%token PREDET
%token<sval> CADENA
%token<car> CARACTER
%token ENTONCES
%token LEER
%token ESCRIBIR
%token SI

/* Precedencia y asociatividad de operadores */
%left ASIG
%left OO
%left YY
%left<sval> EQEQ DIF
%left<sval> GRT SMT GREQ SMEQ
%left<sval> MAS MENOS
%left<sval> PROD DIV MOD
%left NOT
%nonassoc LPAR RPAR  LCOR RCOR
%nonassoc SIX
%nonassoc SINO

/* Tipos */
%type<tval> base tipo tipo_arreglo  tipo_registro declaraciones arg tipo_arg param_arr
%type<args_list> argumentos lista_arg lista_param parametros
%type<eval> expresion arreglo variable
%type<cond> expresion_booleana relacional
%type<sent> sentencias sentencia
%%

/*Estructura de la gramatica, falta agregar todas las reglas semanticas*/
