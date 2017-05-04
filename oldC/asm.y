%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int

extern char* yytext;
int flag = 0;

%}


%token CONST
%token PLUS MINUS TIMES DIVIDE MOD
%token LEFT RIGHT
%token ENDLN
%token ASSIGN EQ IF ENDIF LOOP END SHOW SHOWX COLON
%token VAR

%left PLUS MINUS
%left TIMES DIVIDE
%left NEG

%start Input

%%

Input:
     | Input Line
;

Line:
  ENDLN
  | Ifstm
  | Loopstm
  | Stms
  | Display
  | Condition
  | error { yyerror(); flag = 0; }
;


Oprn:
  VAR
  | CONST
;

Condition:
  Oprn EQ Oprn { printf("CONDITION\n");}
;

Block:
  Stms
  | Ifstm
  | Ifstm Stms
  | Stms Ifstm
  | Stms Ifstm Stms
;

Ifstm:
  IF Condition ENDLN Stms ENDIF ENDLN { printf("IF\n");}
;

Stm:
  VAR ASSIGN Exp { printf("STM\n"); }
  | Exp { printf("STM"); }
;

Stms:
  Stm ENDLN{ printf("STMS STM\n"); }
  | Stm ENDLN Stms { printf("STMS STM STMS\n"); }
;


Exp:
  CONST { }
  | VAR { printf("Hello world");}
  | Exp PLUS Exp { printf("ADD regis %d, %d\n", $1, $3); }
  | Exp MINUS Exp { printf("SUB regis %d, %d\n",$1,$3); }
  | Exp TIMES Exp { printf("EXP*\n"); }
  | Exp DIVIDE Exp { printf("EXP/\n"); }
  | MINUS Exp %prec NEG { printf("EXP neg\n"); }
  | LEFT Exp RIGHT { printf("EXP ()\n"); }
;

Loopstm:
  LOOP CONST COLON CONST ENDLN Block END ENDLN { printf("LOOP\n");}
;

Display:
  SHOW VAR { printf("SHOW\n");}
  | SHOWX VAR { printf("SHOWX\n");}
;
%%

int yyerror() {
  if (flag == 0){
   printf("ERROR! \n");
   flag = 1;
  }
}

int main() {
  yyparse();
}
