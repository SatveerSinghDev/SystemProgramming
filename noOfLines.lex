%{
#include <stdio.h>
int no_of_lines = 0;
int no_of_chars = 0;
%}

%%
[ \t]	;
\n	{ 
	  no_of_lines++;
	  no_of_chars++;
	}
.	{ 
	  no_of_chars++;
	}
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

	fclose(file);

	printf("Total number of lines in %s is %d\n",argv[1],no_of_lines);
	printf("Total number of characters in %s is %d\n",argv[1],no_of_chars);
	return 0;
}
