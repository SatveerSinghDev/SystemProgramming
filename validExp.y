%{
#include <stdio.h>
int yylex();
%}
%union{
	char val;
}

%token <val> BHANGRA MUSIC NACHO KHATAM
%type <val> start khtm
%%
dance : start khtm	{ printf("Dance number for start = %c\n",$1);
				printf("Dance number for khatam = %c\n",$2);
			}
	;
start : MUSIC BHANGRA NACHO	{ /*Pass the number of bhangra to start.*/ $$ = $2;
					printf("Music chalu with number %c\n",$1);
					printf("Number for Bhangra is %c\n",$2);
					printf("Nach rahe hai with number %c\n",$3);
				}
	;
khtm : KHATAM		{ $$ =$1; }
%%
