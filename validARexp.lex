%{
#include <stdio.h>
int operands = 0;
int operators = 0;
int open_br = 0;
int closed_br = 0;
%}

operator	("+"|"-"|"*"|"/")
operand		[a-zA-Z0-9]+

%%
[ \t]	;
"("	{if(closed_br <= open_br) open_br++;}
")"	{closed_br++;}
{operator}	{operators++;}
{operand}	{operands++;}
\n	return 0;	
%%

extern FILE *yyin;

int main(int argc,char *argv[]) 
{

	FILE *file = fopen(argv[1],"r");
	if(!file)
	{
		fprintf(stderr,"Could not open %s\n",argv[1]);
	}
	yyin = file;

	yylex();
	if( (open_br == closed_br) && (operands == operators+1) )
		printf("Expression valid.");
	else 
		printf("Expression invalid!");

	if(file)	fclose(file);
	return 0;
}
