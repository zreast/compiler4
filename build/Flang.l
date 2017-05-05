%{
#include <cstdio>
#include <iostream>
#include "Flang.tab.h"
#define YY_DECL extern "C" int yylex()
using namespace std;
%}

white [ \t]+
digit [0-9]
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

$[a-z] {
  yylval=(int)yytext[1]-'a';
  return VAR;
}

"+" return ADD;
"-" return SUB;
"*" return TIMES;
"/" return DIVIDE;
"%" return MOD;

"(" return LEFT;
")" return RIGHT;

"==" return EQ;
"=" return ASSIGN;
"if" return IF;
"endif" return ENDIF;
"loop" return LOOP;
"endloop" return END;

"show" return SHOW;
"showx" return SHOWX;
":" return COLON;

"\n" return ENDLN;
. { return yytext[0]; }
