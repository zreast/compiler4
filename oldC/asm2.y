%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int
extern char* yytext;
void yyerror(char *);
int flag = 0;
%}


%token CONST
%token LEFT RIGHT
%token ENDLN
%token ASSIGN EQ IF ENDIF LOOP END SHOW SHOWX COLON
%token VAR

%left PLUS MINUS MOD
%left AND OR NOT
%left TIMES DIVIDE
%left NEG



%start Input


%%

Input:
     | Input line
;
line :
     ENDLN {flag=0; printf("Hi\n");}
     |exp ENDLN  {printf("Ans : \n");}
;

exp:
   CONST {printf("constant\n");}
   |VAR {printf("variable\n");}
   |exp PLUS exp {printf("ADD\n");}
   |exp MINUS exp
   |exp TIMES exp
   |exp DIVIDE exp
   |exp MOD exp
   |MINUS exp %prec NEG
   |LEFT exp RIGHT
;
%%

void yyerror(char *e) {
//  if (flag == 0){
   printf("ERROR !! \n");
//  }
//  flag = 1;
  
}

int main() {
  while(yyparse());
}
