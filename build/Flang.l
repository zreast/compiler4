%{
#include <cstdio>
#include <iostream>
#include "Flang.tab.h"
#define YY_DECL extern "C" int yylex()
using namespace std;
%}

blank [ \t]+
digit [0-9]
dec {digit}+
hex [0-9a-fA-F]
%%

{blank} { }

{hex}+[hH] {
  sscanf(yytext,"%x",&yylval);
  return CONST;
}

{dec} {
  sscanf(yytext,"%d",&yylval);
  return CONST;
}

$[a-z] {
  yylval=(int)yytext[1]-'a';
  return REGISTER;
}

"+" return ADD;
"-" return SUB;
"*" return MUL;
"/" return DIV;
"%" return MOD;

"(" return OB;
")" return CB;
"=" return EQ;
"<<" return ASSIGN;
"if" return IF;
"then" return THEN;
"endif" return ENDIF;
"loop" return LOOP;
"endloop" return ENDLOOP;

"show" return SHOW;
"showx" return SHOWX;
":" return COLON;

"\n" return NEWLN;
. { return yytext[0]; }
