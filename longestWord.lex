%{
#include <stdio.h>
int len = 0;
char *word;
void longestWord();
%}

%%
[ \t\n]+	;
end	return 0;
[a-zA-z]+	{ if(yyleng > len) longestWord();}
.	;
%%

void longestWord()
{
	len = yyleng;
	word = (char*)malloc(sizeof(yyleng));
	/*Use either method 1 or 2*/
	
	/*@1*/
	//for(int i = 0; i < yyleng; i++)
	//	word[i] = yytext[i];
	/*@1ends*/
	
	/*@2*/
	word = strdup(yytext);
	/*@2ends*/

	printf("word is %s\n",word);
	return;
}

int main()
{
	yylex();
	printf("The longest word in the input is %s\n",word);
	return 0;
}
