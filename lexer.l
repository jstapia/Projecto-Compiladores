%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #include "yacc.tab.h"
%}

%option noyywrap
%option yylineno

letra [a-zA-Z]
num [0-9]+
entero [+-]?{num}+
exp [Ee][+-]?{num}+
real_def ({num}.?{num}{exp}|{num}?.{num}{exp}?|{num}.{num}?{exp}?)[Ff]
dreal_def ({num}.?{num}{exp}|{num}?.{num}{exp}?|{num}.{num}?{exp}?)[dD]
id [{letra}][{letra}|{num}]*

car_def '([^'])'
cadena \"([^"]*)\"

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

%x com1
%x com2


%%




{entero}   {yylval.line = yylineno;yylval.num.tipo = 1;yylval.num.ival = atoi(yytext);return NUM;}

{real_def}  {yylval.line = yylineno;yylval.num.tipo = 2;yylval.num.fval = atof(yytext);return NUM;}

{dreal_def} {yylval.line = yylineno; yylval.num.tipo = 3; yylval.num.dval = atof(yytext);return NUM;}

{car_def}   {yylval.line = yylineno;yylval.car.tipo = 4;sprintf(yylval.sval,"%c",yytext[1]);return CARACTER;}

{ent}    {yylval.line = yylineno;return ENT;}

{dreal} {yylval.line = yylineno;return DREAL;}

{real} {yylval.line = yylineno;return REAL;}

{car} {yylval.line = yylineno;return CAR;}

{sin}   {yylval.line = yylineno;return SIN;}

{registro} {yylval.line = yylineno;return REGISTRO;}

{inicio} {yylval.line = yylineno;return INICIO;}

{func}  {yylval.line = yylineno;return FUNC;}

{sino}    {yylval.line = yylineno;return SINO;}

{si}    {yylval.line = yylineno;return SI;}

{devolver} {yylval.line = yylineno;return DEVOLVER;}

{fin}    {yylval.line = yylineno;return FIN;}

{entonces}    {yylval.line = yylineno;return ENTONCES;}

{verdadero} {yylval.line = yylineno;return VERDADERO;}

{falso} {yylval.line = yylineno;return FALSO;}

{mientras}  {yylval.line = yylineno;return MIENTRAS;}

{mientrasq}  {yylval.line = yylineno;return MIENTRAS_QUE;}

{leer}    {yylval.line = yylineno;return LEER;}

{escribir}    {yylval.line = yylineno;return ESCRIBIR;}

"oo"    {yylval.line = yylineno;return OO;}

"yy"    {yylval.line = yylineno;return YY;}

"no"    {yylval.line = yylineno;return NOT;}

"+" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return MAS; }

"-" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return MENOS; }

"*" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return PROD; }

"/" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return DIV; }

"%" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return MOD; }

"(" {yylval.line = yylineno;return LPAR; }

")" {yylval.line = yylineno;return RPAR;}

":="   {yylval.line = yylineno;return ASIG;}

"," {yylval.line = yylineno;return COMA;}

"[" {yylval.line = yylineno;return LCOR;}

"]" {yylval.line = yylineno;return RCOR;}

"." {yylval.line = yylineno;return PT;}

"<" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return SMT; }

">" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return GRT; }

">=" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return GREQ; }

"<=" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return SMEQ; }

"<>" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return DIF; }

"==" { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext); return EQEQ; }

{id} { yylval.line = yylineno; sprintf(yylval.sval,"%s",yytext);return ID;}

[ \n\t\r]+  {}



"/*"        { BEGIN(com1); }

<com1>\n        { yylval.line = yylineno; }

<com1>[^*\n]*   {}

<com1>"*"+[^*/\n]*  {}

<com1>"*"+"/"   { BEGIN(INITIAL); }

"//"        { BEGIN(com2); }

<com2>[^*\n]*   {}

<com2>\n        { BEGIN(INITIAL); }

.         { printf("\n****Error lexico en la linea: %d\n", yylineno);}

%%
