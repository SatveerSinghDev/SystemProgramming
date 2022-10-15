%{
#include <stdio.h>
%}

keyword		(int|float|char|struct|for|while|do|main|void|define|include|using|namespace|return)
id		[_a-zA-Z][_a-zA-Z0-9]*
digit		[0-9]
number		{digit}+
floating	{number}+\.{number}+
spaces		[ \t]+
lines		[\n]+
operator	("+"|-|"*"|\/|"++"|--|<|>|=|<=|>=|<<|>>|\.)
s_comment	^{spaces}*"//".*\n
m_comment	^{spaces}*"/*"(.*|{lines})*"*/"{spaces}*\n

%%
{s_comment}		{printf("%s : SINGLE-LINE COMMENT\n",yytext);}
{m_comment}		{
			/*Length of the multiline comment must not be 
			* greater than the buffer size of yytext
			*/
			printf("%s : MULTI-LINE COMMENT\n",yytext);
			}
{keyword}		{printf("%s : KEYWORD\n",yytext);}
{id}			{printf("%s : IDENTIFIER\n",yytext);}
{number}		{printf("%s : NUMBER\n",yytext);}		
{floating}		{printf("%s : FLOAT\n",yytext);}
{spaces}		{printf("%s : Whitespace or Tab\n",yytext);}
{lines}			{printf("%s : NEWLINE\n",yytext);}
{operator}		{printf("%s : OPERATOR\n",yytext);}
.			{printf("%s : Unrecognized Character\n",yytext);}
%%

extern FILE *yyin;
int main(int argc,char *argv[])
{
	FILE *file = fopen(argv[1],"r");
	if(!file)
		fprintf(stderr,"Could not open %s\n",argv[1]);
	yyin = file;
	yylex();
	if(file)	fclose(file);
	return 0;
}
