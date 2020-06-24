%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #include "y,tab.h"
  void error (char *s)
%}

%option noyywrap
%option yylineno
%x comentario


letra [a-zA-Z]
num [0-9]+
entero [+-]?{num}+
exp [Ee][+-]?{num}+
real_def ({num}.?{num}{exp}|{num}?.{num}{exp}?|{num}.{num}?{exp}?)[Ff]
dreal_def ({num}.?{num}{exp}|{num}?.{num}{exp}?|{num}.{num}?{exp}?)[dD]
id [{letra}][{letra}|{num}]*
cadena \"({letra})*\"
caracter \'({letra})\

registro [r][e][g][i][s][t][r][o]
inicio [i][n][i][c][i][o]
fin [f][i][n]
ent [e][n][t]
real [r][e][a][l]
dreal [d][r][e][a][l]
car [c][a][r]
sin [s][i][n]
func [f][u][n][c]
si [s][i]
entonces [e][n][t][o][n][c][e][s]
sino [s][i][n][o]
mientras [m][i][e][n][t][r][a][s]
hacer [h][a][c][e][r]
mientrasq [m][i][e][n][t][r][a][s]" "[q][u][e]
escribir [e][s][c][r][i][b][i][r]
leer [l][e][e][r]
devolver [d][e][v][o][l][v][e][r]
terminar [t][e][r][m][i][n][a][r]
verdadero [v][e][r][d][a][d][e][r][o]
falso [f][a][l][s][o]

%%
"estructura" {return ESTRUCT;}
"inicio" {return INICIO;}
"fin" {return END;}
"si"  {return IF;}
"def" {return DEF;}
"entonces" {return THEN;}
"sino" {return SINO;}
"mientras" {return WHILE;}
"hacer" {return DO;}
"segun" {return SEGUN;}
"escribir" {return WRITE;}
"leer"  {return READ;}
"devolver" {return DEV;}
"terminar" {return TERMINAR;}
"caso" {return CASO;}
"pred" {return PRED;}
"o" {return OR;}
"y" {return AND;}
"no" {return NOT;}
"verdadero" {return TRUE;}
"falso" {return FALSE;}
"ent" {return ENTERO;}
"real" {return REAL;}
"dreal" {return DREAL;}
"car" {return CAR;}
"sin" {return SIN;}
"%" {return MODULO;}
":=" {return IGUAL;}
"(" {return LPAR;}
")" {return RPAR;}
"[" {return LCOR;}
"]" {return RCOR;}
"." {return PUNTO;}
"," {return COMA;}
":" {return DOSP;}
";" {return PYC;}
"<" {return MENORQUE;}
">" {return MAYORQUE;}
"<=" {return MENORIGUAL;}
">=" {return MAYORIGUAL;}
"=" {return IDENTICO;}
"<>" {return DIFERENTE;}
"+" {return MAS;}
"-" {return MENOS;}
"*" {return MUL;}
"/" {return DIV;}

{num} { 
        yylval.num.tipe= 0;
        yylval.num.valor= strdup(yytext);
        return NUM;
      }
{id} {  
        /* Ej: el valor de yytext se copia en el parser, 
           en el elemento de la union id, estructura dentro de la union*/
        strcpy(yylval.id.lexval,yytext);
        return ID;
      }
{cadena} {
          strcpy(yylval.cad.lexval,yytext);
          return CADENA;
        }

{caracter} {
           strcpy(yylval.cad.lexval,yytext); 
           return CARACTER;
          }

[ \n\r\t] {}
<INITIAL>"/*" {BEGIN(COMENTARIO);}
<COMENTARIO>[^*/]  {}
<COMENTARIO>[*/]   {}    
<COMENTARIO>"*/"   {BEGIN(INITIAL);}
%%
