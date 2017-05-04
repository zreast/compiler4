%{
#define YYSTYPE int
#include "asm.tab.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
%}
%option noyywrap
white [ \t]+
digit [0-9]+
integer {digit}+
hex [0-9a-fA-F]
%%
{white} { }

0x{hex}+ {
  sscanf(yytext,"%x",&yylval);
  return CONST;
}
{integer} {
    sscanf(yytext,"%d",&yylval);
    return CONST;
}
$[a-zA-Z] {
    yylval=yytext[2]-'0';
    return VAR;
}
"+" return PLUS;
"-" return MINUS;
"*" return TIMES;
"/" return DIVIDE;
"%" return MOD;
"(" return LEFT;
")" return RIGHT;
"if" return IF;
"==" return EQ;
"=" return ASSIGN;
"endif" return ENDIF;
"loop" return LOOP;
"end" return END;
"show" return SHOW;
"showx" return SHOWX;
":" return COLON;
"\n" return ENDLN;
