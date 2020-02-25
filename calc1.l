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
"int"   return DATA_TYPE;
","     return COMMA;

[a-zA-Z]+ {  
                yylval = *yytext - 'a';
               return VAR; 
            }
            
[0-9]+      {
                yylval = atoi(yytext);
                return INTEGER;
            }           

[-+()\^=/*{};.]      { return *yytext; }

[\n]                 { return *yytext;}   
[ \t\s]+       ;       /* skip whitespace */

.           yyerror("Unknown character");

%%

int yywrap(void) {
    return 1;
}
