/* calculator #1 */
%{
    #include "y.tab.h"
    #include <stdlib.h>
    void yyerror(char *);
%}



%%

"<=" return LE;
">=" return GE;
"==" return EQ;
"!=" return NE;
":=:" return SWAP;
",...," return ELLIPSIS;

"array" return ARRAY; 

"int"|"string"|"boolean" {return DATATYPE;}

[a-zA-Z]+ {  
                yylval = *yytext - 'a';
               return VAR; 
            }
            
[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }

([0-9]*[.])?[0-9]+ {
                yylval = atoi(yytext);
                return FLOAT;
                }            


[-+()\^=/*{};.]      { return *yytext; }

[\n]                 { return *yytext;}   
[ \t\s]+       ;       /* skip whitespace */

.           yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
