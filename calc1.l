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
",...," return ELLIPSIS;
"while" return WHILE;
"if" return IF;
"else" return ELSE;

"and" return AND; 
"do" return DO;
"or" return OR; 
"then" return THEN;
"array" return ARRAY; 
"int" return INTEGER;
"procedure" return PROCEDURE;
"value" return VALUE;
"start" return START;
"end" return END;
"mod" return MOD;
"rem" return REM;
"boolean" return BOOLEAN;
"for" return FOR;
"not" return NOT;
"string" return STRING;


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
