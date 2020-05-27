%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #include "y,tab.h"
  void error (char *s)
}
%option noyywrap
%option yylineno
%s COMENTARIO

letra [a-zA-Z]
num [0-9]+
entero ({num})+
real {num}*"."{num}+|{num}+"."{num}*
id [{letra}][{letra}|{num}]*
cadena {letra}{letra}+
caracter [>|<|>=|<=|<>|=]
oparit [[+|-|*|/]


%%
"estructura" {return ESTRUCTURA;}
"inicio" {return INICIO;}
"fin" {return END;}
"ent" {return ENTERO;}
"real" {return REAL;}
"dreal" {return DREAL;}
"sin" {return SIN;}
"car" {return CAR}
"si"  {return SI;}
"def" {return DEF;}
"entonces" {return ENTONCES;}
"sino" {return SINO;}
"mientras" {return MIENTRAS;}
"hacer" {return HACER;}
"segun" {return SEGUN;}
"escribir" {return ESCRIBIR;}
"leer"  {return LEER;}
"devolver" {return DEVOLVER;}
"terminar" {return TERMINAR;}
"caso" {return CASO;}
"pred" {return PRED;}
"o" {return O;}
"y" {return Y;}
"no" {return NO;}
"verdadero" {return VERDADERO;}
"falso" {return FALSO;}
"+" {return MAS;}
"-" {return MENOS;}
"*" {return MUL;}
"/" {return DIV;}
"%" {return MODULO;}
"<" {return MENOR;}
">" {return MAYOR;}
"<=" {return MENORIGUAL;}
">=" {return MAYORIGUAL;}
"==" {return IDENTICO;}
"<>" {return DIFERENTE;}
":=" {return IGUAL;}
"(" {return LPAR;}
")" {return RPAR;}
"[" {return LCOR;}
"]" {return RCOR;}
"." {return PUNTO;}
"," {return COMA;}
":" {return DOSP;}
";" {return PYC;}

{num} {
        strcpy(yylval.dir,yytext);
           return NUM;
      }
{id} {
            strcpy(yylval.dir,yytext);
           return ID;
      }

{cadena} {
            strcpy(yylval.dir,yytext);
           return CADENA;
      }
{caracter} {
            strcpy(yylval.dir,yytext);
           return CARACTER;
      }
[ \t\n\r] {/* Ignora los espacios en blanco*/}
.   {error(yytext);}
%%

int yywrap(){
    return 1;
}

void error(char *s){
    printf("Error léxico: %s, en la línea %d\n",s,yylineno);
}
