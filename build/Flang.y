%{
#include "mainbuffer.cpp"
#include "asmlink.cpp"
#include <cstdio>
#include <iostream>
#include <string>
#include <stack>
#include <queue>
#include <cstdlib>
#include <fstream>
using namespace std;

int reg_Array[60] = {};
void stack_print();
queue<mainbuffer*> queue_node;
int lCount = 0;
int ifCount = 0;
int temp_initial = 0;
stack<int> temp;

int swap_temp;
mainbuffer nodeblock;

//init Binary tree
struct node{
   int data;
   struct node *right, *left;
};

queue<string> asmQ;
queue<string> asmV;
typedef struct node node;
node *subtree;

//stack for tree
stack<mainbuffer*> stack_node;

string asmShow(){
	return "mov $show,%edi \nmov %eax,%esi \npush %rax\ncall printf\npop %rax\nret\n";
}

// stuff from flex that bison needs to know
extern "C" int yylex();
extern "C" int yyparse();
extern "C" FILE *yyin;

void convert_to_asm(int opr1,int opr2);
void yyerror(const char *s);
%}

%token CONST
%token OTHERS
%token OB CB
%token NEWLN
%token ASSIGN EQUAL IF THEN ENDIF LOOP ENDLOOP SHOW SHOWX COLON
%token REGISTER

%left ADD SUB
%left MUL DIV MOD
%left NEG

%start recursion

%%

recursion:
     | buffer recursion;
;

buffer:
  NEWLN
  | ifstatement
  | loop
  | multistatement
  | Display
  | condition
  | error { yyerror("ERROR\n"); }
;


reg:
  REGISTER
  {
  	Variable *node_var = new Variable($1);
  	int char_index = $1;

 	if(reg_Array[char_index] == 0)
 	{
 		asmV.push(init_var(node_var->getAsm()));
 		reg_Array[char_index] = 1;
 	}
 	stack_node.push(node_var);
  }

  | CONST
    {
      Constant *node_const = new Constant(); //create constant object
      node_const->setValue($1);  //add value to constant node

      stack_node.push(node_const);
      asmQ.push(xconstant(node_const->getValue()));
    }
;

condition:
    reg EQUAL reg
  {
  	mainbuffer *node1 = stack_node.top();
  	stack_node.pop();
  	mainbuffer *node2 = stack_node.top();
  	stack_node.pop();

  	Equal *node_equal = new Equal(node2,node1); //condition object
  	stack_node.push(node_equal);
	asmQ.push(xcondition(node1->getAsm(),node2->getAsm(),ifCount));
  }
;


ifstatement:
  IF OB condition CB NEWLN THEN NEWLN multistatement ENDIF NEWLN  // change multistatement to statement for first version support only one statement
  {
	   asmQ.push(xif(&ifCount));
  }

;

REGISTERF:
	REGISTER {
		Variable *node_var = new Variable($1);
	  	int char_index = $1;
	 	//cout << " var = " << $1 << endl;

	 	if(reg_Array[char_index] == 0)
	 	{
	 		asmV.push(init_var(node_var->getAsm()));
	 		reg_Array[char_index] = 1;
	 	}
	 	stack_node.push(node_var);
	}

statement:
  REGISTERF ASSIGN expression NEWLN{
	mainbuffer *node_exp = stack_node.top();
  Variable *node_var = new Variable($1);
 	//cout << " var = " << $1 << endl;
 	stack_node.push(node_exp);
	//cout << "var assign @ = " << node_var->getValue() << endl;

	asmQ.push(xassign(node_exp->getAsm(),node_var->getValue()));
  	//stack_print();
  }
  | Display {
  }
;

blockstatement:
  multistatement {}
  | ifstatement {}
  | ifstatement multistatement {}
  | multistatement ifstatement {}
  | multistatement ifstatement multistatement {}
;

multistatement:
  statement {  }
  | statement multistatement {}
;

expression:

   CONST {

   Constant *node_const = new Constant(); //create constant object
   node_const->setValue($1);  //add value to constant node
   stack_node.push(node_const);
	asmQ.push(xconstant(node_const->getValue()));

   }
  | REGISTER {
  	// add var to tree it's looklike constant but keep on address form fp(frame pointer)
 	Variable *node_var = new Variable($1);

 	int char_index = $1;

 	if(reg_Array[char_index] == 0)
 	{
 		asmV.push(init_var(node_var->getAsm()));
 		reg_Array[char_index] = 1;
 	}

 	//cout << " var = " << $1 << endl;
 	stack_node.push(node_var);
	//cout << "var assign @ = " << node_var->getValue() << endl;
	//stack_print();


  }
  | expression ADD expression {

      mainbuffer *node_left;
      mainbuffer *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      AddSyntax *addsyn = new AddSyntax(node_left,node_right);
      stack_node.push(addsyn);

 	asmQ.push(xadd(node_right->getAsm(),node_left->getAsm(),""));


    }
  | expression SUB expression {

      mainbuffer *node_left;
      mainbuffer *node_right;
      node_right = stack_node.top();
	  stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      MinusSyntax* minsyn = new MinusSyntax(node_left,node_right);
      stack_node.push(minsyn);
      //minsyn->print();
      // FOR TESTING VALUE
      /*
      mainbuffer* node_test = stack_node.top();
      cout << "test print from stack" << endl;
      node_test->print();
	  */
 	asmQ.push(xsub(node_right->getAsm(),node_left->getAsm(),""));
    }
  | expression MUL expression {

      mainbuffer *node_left;
      mainbuffer *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      TimesSyntax* timessyn = new TimesSyntax(node_left,node_right);
      stack_node.push(timessyn);

      //mainbuffer* node_test = stack_node.top();
      //node_test->print();
 	asmQ.push(xmul(node_right->getAsm(),node_left->getAsm(),""));
    }
  | expression DIV expression {
      mainbuffer *node_left;
      mainbuffer *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      DivideSyntax* dividesyn = new DivideSyntax(node_left,node_right);
      stack_node.push(dividesyn);

      //mainbuffer* node_test = stack_node.top();
      //node_test->print();

 	asmQ.push(xdiv(node_right->getAsm(),node_left->getAsm(),""));
}
  | expression MOD expression {

      mainbuffer *node_left;
      mainbuffer *node_right;
      node_right = stack_node.top();
      stack_node.pop();
      node_left = stack_node.top();
      stack_node.pop();

      ModSyntax* modsyn = new ModSyntax(node_left,node_right);
      stack_node.push(modsyn);

 	asmQ.push(xmod(node_right->getAsm(),node_left->getAsm(),""));

    }
  | OB expression CB { }
  | SUB expression %prec NEG {

      mainbuffer *node;
      node = stack_node.top();
      //cout << "OLD: " << node->getValue() << endl;
      stack_node.pop();
      int temp_neg = -node->getValue();
	asmQ.push("\tpop %rax");
	asmQ.push("\txor %rbx,%rbx");
	asmQ.push("\tsub %rax,%rbx");
	asmQ.push("\tpush %rbx\n");
      node->setValue(temp_neg);
      //cout << "NEW: " << node->getValue() << endl;
      stack_node.push(node);
    }
;
RVALUE:
  REGISTER
  {
  	Variable *node_var = new Variable($1);

  	int char_index = $1;

  	if(reg_Array[char_index] == 0)
 	{
 		asmV.push(init_var(node_var->getAsm()));
 		reg_Array[char_index] = 1;
 	}

 	stack_node.push(node_var);
	asmQ.push(xloopStart(node_var->getAsm(),lCount));
  }

  | CONST
  {
  	Constant *node_const = new Constant();
	node_const->setValue($1);  //add value to constant node
	stack_node.push(node_const);
	asmQ.push(xconstant(node_const->getValue()));
	asmQ.push(xloopStart(node_const->getAsm(),lCount));
  }
;
loop:
  LOOP OB RVALUE CB NEWLN blockstatement ENDLOOP NEWLN {

    Variable *node_var = new Variable(-1);

    LoopStatement *node_loop = new LoopStatement(node_var);

	asmQ.push(xloop(&lCount));
  }
;

Display:
  SHOW REGISTER NEWLN{
    Variable *node_var = new Variable($2);
    Show *node_show = new Show ($2*4);
//    node_show->print();
    asmQ.push(xprint(node_var->getAsm(),false));
  }
  | SHOWX REGISTER NEWLN{
    Variable *node_var = new Variable($2);
    ShowX *node_show = new ShowX ($2*4);
//    node_show->print();
    asmQ.push(xprint(node_var->getAsm(),true));
  }
;
%%

void yyerror(const char *s) {
  cout << "Aw! snap, Error message: " << s << endl;
  exit(-1);
}

int main() {
  while(yyparse());
	ofstream file_p;
	file_p.open ("assembly.s");

	file_p<<genHead()<<endl;

	while(!asmV.empty()){
		 file_p<<asmV.front()<<endl;
		asmV.pop();
	}

	while(!asmQ.empty()){
		 file_p<<asmQ.front()<<endl;
		asmQ.pop();
	}
	file_p<<genTail()<<endl;
	file_p.close();

  return 0;
}
