 //This is a stub or a simple compiler that compiles from a language we have made, through C++ to object code
 //Note - comments are indented in lex (and yacc) - should not start from first column
 //Also, change syntax highlighting to yacc, to be able to spot coding errors quickly
%{
#include <cstdio>
#include <cstdlib>
#include <string>
using namespace std;
#include "calc.tab.h"
void yyerror(char *s);
int yyparse(void);
%}

%%

[ \t\n]+		; //do nothing on white space
"print" 		return PRINT;
[a-zA-Z][a-zA-Z0-9]*	{yylval.str_val = new string(yytext); return VARIABLE;}
[0-9][0-9]*(.[0-9]+)?	{yylval.double_val = atof(yytext); return NUMBER;}
"="			return EQUALS;
"+"			return PLUS;
"-"			return MINUS;
"*"			return STAR;
"/"			return SLASH;
"("			return LPAREN;
")"			return RPAREN;
";"			return SEMICOLON;

%%

void yyerror(char *str)
{
	printf("Parse Error: \n%s\n",str);
}

int yywrap(void)
{
}

int main(int num_args, char** args)
{
	if (num_args !=2)
	{
		printf("usage: ./parser1 filename\n");
		exit(0);
	}
	FILE* file1 = fopen(args[1],"r");
	if (file1 == NULL)
	{
		printf("Cannot open %s\n",args[1]);
		exit(0);
	}
	yyin = file1;
	yyparse();
	fclose(file1);
}


