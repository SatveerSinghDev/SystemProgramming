%{
/* Language is music bhangra nacho khatam */
#include <stdio.h>
#include "y.tab.h"
%}


%%
[ \t]	;
music	{/*storing the first letter of the word as the token's value*/ yylval.val = yytext[0]; return MUSIC;}
bhangra	{ yylval.val = yytext[0]; return BHANGRA;}
nacho	{ yylval.val = yytext[0]; return NACHO;}
khatam	{ yylval.val = yytext[0]; return KHATAM;}
\n	return 0;
.	return yytext[0];
%%


