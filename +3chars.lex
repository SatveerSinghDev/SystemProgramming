%{
#include <stdio.h>
void nextThree(const char*);
%}

%%
[ \t\n]	;
[a-zA-z]+	{ nextThree(yytext);}
.	;
%%

void nextThree(const char* c)
{
	int x;
	for(int i = 0; i < yyleng; i++)
	{
		if(c[i] > 'w'){
			x = c[i] + 3 - 26;
			printf("%c",x);
		}
		else{
			x = c[i] + 3;
			printf("%c",x);
		}
	}
	printf("\n");
	return;
}	
