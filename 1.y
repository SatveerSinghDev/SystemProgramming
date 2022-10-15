%{
/*
 *Attempt 1 for recognising tokens
 */
#include <stdio.h>
/*for boolean values*/
#include <stdbool.h>
bool x = true;
/* boolean declartion ends*/
int yylex();
int yyerror();
int ar[2][2] = { {1,1}, {1,1} }; 	
void abc(int *);
int a=0;
%}
%union{
	int val;
}
%token <val> NUM
%token SS N
%type <val> stmts
%%
stmt : stmts';'|stmts':'|stmts'<'|stmts','|stmts'>' {printf("%d : found youNUM this times :%d\n",$1,a); abc(&$1); } ;
stmts: NUM stmtst	;
stmtst : NUM stmtst	{a++;}
	| SS stmtst	{a++;}
	| SS {a++;ar[1][1] = 0;};
%%
void abc(int* a)
{
	printf("Value of num is : %d\n",*a);
}
int main()
{
	yyparse();
	for(int i = 0;i < 2;i++)
	{	for(int j = 0;j < 2;j++)
		printf("a[%d][%d] = %d\n",i,j,ar[i][j]);
	}
	return 0;
}
