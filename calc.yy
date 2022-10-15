%{
#include <cstdio>
#include <cstdlib>
#include <string>
#include <map>
using namespace std;
map<string, double> vars;	//dictionary of variables and values
extern int yylex();
extern void yyerror(char*);
void Div0Error(void);		//a primitive error handler - arithmetic exception could be invoked
void UnknownVarError(string s);	//a primitive error handler - C++ (classes/objects) exception handlers 
				//could do elaborate handling of such/similar cases
%}

%union
{
 int 		int_val;
 double		double_val;
 string*	str_val;
}

%token <int_val>	PLUS MINUS STAR SLASH EQUALS PRINT LPAREN RPAREN SEMICOLON
%token <str_val>	VARIABLE
%token <double_val>	NUMBER

%type <double_val> expression;
%type <double_val> inner1;
%type <double_val> inner2;

%start parsetree

%%

parsetree:	lines;
lines:		lines line | line;
line:		PRINT expression SEMICOLON		{printf("%lf\n",$2);}
		| VARIABLE EQUALS expression SEMICOLON	{vars[*$1] = $3; 
							 delete $1;};
expression:	expression PLUS inner1			{$$ = $1 + $3;}
		| expression MINUS inner1		{$$ = $1 - $3;}
		| inner1				{$$ = $1;};
inner1:		inner1 STAR inner2			{$$ = $1 * $3;}
		| inner1 SLASH inner2			{if($3==0)
							  Div0Error();
							 else
							  $$ = $1 / $3;}
		| inner2				{$$ = $1;};
inner2:		VARIABLE				{if(!vars.count(*$1))
							  UnknownVarError(*$1);
							 else
							  $$ = vars[*$1];
							 delete $1;}
		| NUMBER				{$$ = $1;}
		| LPAREN expression RPAREN		{$$ = $2;};
%%

void Div0Error(void) 
{
	printf("Error: division by zero\n");
	exit(0);
}
void UnknownVarError(string s)
{
	printf("Error: %s does not exist (undefined variablename)\n",s);
	exit(0);
}

