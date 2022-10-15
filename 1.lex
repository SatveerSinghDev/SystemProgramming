%{
#include "y.tab.h"
	/*example from book lex & yacc
	**/
%}

%%
ss {return SS;}
[0-9] {yylval.val=atoi(yytext); return NUM;}
a return 0;
[<>,:;] return *yytext;
.|[\n \t] return *yytext;
%%

