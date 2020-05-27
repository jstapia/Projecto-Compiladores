/* aun faltan unos pocos cambios */
%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(char *s);
%}

%union{
    int tipoi;
    float tipof;
    double tipod;
    char tipoc;
}

%token<tipoi> ENTERO
%token<tipof> REAL
%token<tipod> DREAL
%token<tipoc> CHAR
%token ESTRUCT
%token DEF 
%token SIN
%token NUM
%token ID
%token CAD
%token IF THEN
%token DO 
%token WHILE 
%token SEGUN
%token<tipoc> CHAR
%token VERDADERO
%token FALSO

%left IGUAL
%left O
%left Y
%left IDENTICO
%left DIFERENTE
%left MAYORIGUAL
%left MENORIGUAL
%left MAYOR
%left MENOR
%left MAS
%left MENOS
%left MUL
%left DIV
%left MODULO
%left NO

%nonassoc ESTRUCTURA
%nonassoc INICIO
%nonassoc END
%nonassoc DEF
%nonassoc SI
%nonassoc ENTONCES
%nonassoc SINO
%nonassoc MIENTRAS
%nonassoc HACER
%nonassoc SEGUN
%nonassoc ESCRIBIR
%nonassoc LEER
%nonassoc DEVOLVER
%nonassoc TERMINAR
%nonassoc LPAR RPAR
%nonassoc LCOR RCOR
%nonassoc CASO
%nonassoc PRED
%nonassoc PUNTO COMA DOSP PYC


%start programa

%%
programa: declaraciones funciones {};

declaraciones: tipo lista_var PYC declaraciones {}
            | tipo_registro lista_var PYC declaraciones {}
            | {};

tipo_registro: ESTRUCTURA INICIO declaraciones END {};

tipo: base tipo_arreglo {};

base: ENTERO {}
            | REAL {}
            | DREAL {}
            | CHAR {}
            | SIN {};

tipo_arreglo: LCOR NUM RCOR tipo_arreglo {}
            |{} ;

lista_var: lista_var COMA ID {}
            |{} ID {};

funciones: DEF tipo ID LPAR argumentos RPAR INICIO declaraciones sentencias END funciones {}
            |{} ;

argumentos: lista_arg COMA arg {}
            |{} ;

lista_arg: lista_arg COMA arg {}
            | arg {};

arg: tipo_arg ID {};

tipo_arg: base param_arr {};

param_arr: LCOR RCOR param_arr {}
            | {};

sentencias: sentencias sentencia {}
            |sentencia {};

sentencia: SI e_bol ENTONCES sentencia END {}
            |SI e_bol ENTONCES sentencia SINO sentencia END {}
            |MIENTRAS e_bol HACER sentencia END {}
            |HACER sentencia MINETRAS e_bol PYC {}
            |SEGUN LPAR variable RPAR HACER casos predeterminado END {}
            |variable IGUAL expresion PYC {}
            |ESCRIBIR expresion PYC {}
            |LEER variable PYC {}
            |DEVOLVER {}
            |DEVOLVER expresion {}
            |TERMINAR {}
            |INICIO sentencias END {};

casos: CASO NUM DOSP sentencia casos {}
            |CASO NUM DOSP sentencia {};

predeterminado: PRED DOSP sentencia {}
            |{} ;

e_bol: e_bol O e_bol{}
            |e_bol Y e_bol {}
            |NO e_bol {}
            |LPAR e_bol RPAR {}
            |relacional {}
            |VERDADERO {}
            |FALSO {};

relacional: relacional MAYOR relacional {}
            |relacional MENOR relacional {}
            |relacional MAYORIGUAL relacional {}
            |relacional MENORIGUAL relacional {}
            |relacional DIFERENTE relacional {}
            |relacional IDENTICO relacional {}
            |expresion {};

expresion: expresion MAS expresion {}
            |expresion MENOS expresion {}
            |expresion MUL expresion {}
            |expresion DIV expresion {}
            |expresion MODULO expresion {}
            |LPAR expresion RPAR {}
            |variable {}
            |NUM {}
            |CAD {}
            |CHAR {};

variable: ID variable_comp {};

variable_comp: dato_est_sim {}
            |arreglo {}
            |LPAR parametros RPAR {};

dato_est_sim: dato_est_sim PUNTO ID {}
            | ;

arreglo: LCOR expresion RCOR {}
            |arreglo LCOR expresion RCOR {};

parametros: lista_param COMA expresion {}
            | expresion {};

lista_param: lista_param COMA expresion {}
            | expresion {};
%%

void yyerror(char *s){
    printf("Error Sintactico\n");
}
