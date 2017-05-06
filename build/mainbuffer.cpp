#include<string>
#include<iostream>
#include<sstream>
using namespace std;


class mainbuffer
{
	public:
		char type; //tell about type of nodeBlock
		mainbuffer *left;
		mainbuffer *right;
		//int value;
		mainbuffer() {}
		~mainbuffer() {}
		virtual void setValue(int) {};
		virtual int  getValue() {};
		virtual void print() { cout << "mainbuffer" << endl; };
		virtual string getAsm() {};
		void cgen(); // generate code assembly
};


class Variable : public mainbuffer
{
	//In X86 have frame pointer name ebp
	private:
		char var_name;
		int address;
	public:
		Variable(int var_name) {
			address = (var_name+1) * 8; //each frame has 8 bytes
			this->type = 'v';
		}
		~Variable() {}
		int getValue() {
			return address;
		}

		virtual void print(){
			cout << "variable = " << endl;
		}
		virtual string getAsm(){
	//		stringstream val;
	//		val <<"-"<<address<<"(%rsp)";
	//		return val.str();
			stringstream val;
			val <<address;
			return val.str();
		}
};

class Constant : public mainbuffer
{
	private:
		int value;
	public:
		Constant() {};
		virtual void setValue(int value){
			this->value = value;
			this->type = 'c';
		}

		virtual int getValue(){
			return value;
		}

		virtual void print(){
			cout << "Constant = " << value << endl;
		}
		virtual string getAsm(){
			//stringstream val;
			//val <<"$"<<value;
			//return val.str();
			return "";
		}
};

class IfStatement : public mainbuffer
{
	public:
		IfStatement(mainbuffer *condition) {
			this->left = condition;
			//this->right = then;
			this->type = 'i';
		}
		~IfStatement() {}
		virtual void print() {
			cout << "condition is ";
			this->left->print();
			//cout << " then ";
			//this->right->print();
		}
};

class AddSyntax : public mainbuffer
{

	public:
		AddSyntax(mainbuffer *left,mainbuffer *right)
		{
			this->left = left;
			this->right = right;
			this->type = 'a';
		}
		~AddSyntax(){}
      virtual int getValue(){
         return 0;
      }
		virtual void print()
		{
			cout << "PLUS :: left = ";
			this->left->print();
			cout << " right = ";
			this->right->print();
			cout<< endl;
		}
		virtual string getAsm(){
			return "";
		}
};

class Equal :public mainbuffer
{
	public:
		Equal(mainbuffer *left,mainbuffer *right)
		{
			this->left = left;
			this->right = right;
			this->type = 'e';
		}
		~Equal(){}
		virtual void print()
		{
			cout << " Equal :: " << this->left->getValue() << " == " << this->right->getValue() << endl;
		}
};

class MinusSyntax : public mainbuffer
{
	public:
		MinusSyntax(mainbuffer *left,mainbuffer *right){
			this->left = left;
			this->right = right;
			this->type = 'm';
		}
		~MinusSyntax(){}
		virtual void print(){
			cout << "MINUS :  left = " << this->left->getValue();
			cout << " right = " << this->right->getValue() << endl;
		}
		virtual string getAsm(){
			return "";
		}
};

class TimesSyntax : public mainbuffer
{
	public:
		TimesSyntax(mainbuffer *left,mainbuffer *right){
			this->left = left;
			this->right = right;
		}
		~TimesSyntax(){}
		virtual void print(){
			cout << " MUL :: left = " << this->left->getValue() << endl;
			cout << " right = " << this->right->getValue() << endl;
		}
		virtual string getAsm(){
			return "";
		}
};

class DivideSyntax : public mainbuffer
{
	public:
		DivideSyntax(mainbuffer *left,mainbuffer *right){
			this->left = left;
			this->right = right;
		}
		~DivideSyntax(){}
		virtual void print(){
			cout << "DIV :: left = " << this->left->getValue() << endl;
			cout << " right = " << this->right->getValue() << endl;
		}
		virtual string getAsm(){
			return "";
		}
};

class ModSyntax : public mainbuffer
{
	public:
		ModSyntax(mainbuffer *left,mainbuffer *right){
			this->left = left;
			this->right = right;
		}
		~ModSyntax(){}
		virtual void print(){
			cout << "MOD :: left = " << this->left->getValue() << endl;
			cout << " right = " << this->right->getValue() << endl;
		}
		virtual string getAsm(){
			return "";
		}
};

class LoopStatement : public mainbuffer
{
      public:
          LoopStatement(mainbuffer *condition) {
          this->left = condition;
          //this->right = statement;
          this->type = 'l';
      }
      ~LoopStatement() {}
      virtual void print() {
         cout << "condition is ";
         this->left->print();
         //cout << " statement ";
         //this->right->print();
      }

};

class Show : public mainbuffer
{
      private:
            int variable;
      public:
         Show(int variable){
            this->variable = variable;
	 }
	 ~Show(){}
	 virtual void print(){
	   cout << "SHOW : " << variable << endl;
	 }
};

class ShowX : public mainbuffer
{
       private:
          int variable;
       public:
          ShowX(int variable){
             this->variable = variable;
       }
       ~ShowX(){}
       virtual void print(){
            cout << "SHOWX : " << variable << endl;
       }
};
