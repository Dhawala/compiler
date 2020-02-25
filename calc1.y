%{
    #include <stdio.h>
	#include <math.h>
    int yylex(void);
    void yyerror(char *);
    void swap(int *, int *);
    void while_f();
    int sym[26],temp;
%}

%token DATA_TYPE INTEGER ARRAY VAR COMMA
%nonassoc ELLIPSIS SWAP
%left LE GE EQ NE '>' '<'
%left '+' '-'
%left '*' '^' '/' 

%%

program:
        program statement '\n'         
        | 
        ;

statement:  expr          { printf("%d\n", $1); }
            |VAR '=' expr { sym[$1] = $3; }	
            |DATA_TYPE vars
            ;

vars:   vars COMMA VAR                  { sym[$3]; }
        |vars COMMA VAR '=' expr        { sym[$3] = $5; }
        | VAR                           { sym[$1]; }
        | VAR '=' expr                  { sym[$1] = $3; }
expr:
        |INTEGER
        | VAR                     { $$ = sym[$1]; } 
        | expr '/' expr           { $$ = $1 / $3; }   
        | expr '*' expr           { $$ = $1 * $3; }
        | expr '+' expr           { $$ = $1 + $3; }
        | expr '-' expr           { $$ = $1 - $3; }
        | expr '^' expr           { $$ = pow($2,$3); }
        | '(' expr ')'            { $$ = $2;}
        | VAR SWAP VAR            { swap(&sym[$1],&sym[$3]);} 
        ;


%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

int main(void) {
    yyparse();
    return 0;
	}

void swap(int *v1, int *v2 ){
    int temp;
    temp = *v1;
    *v1 = *v2;
    *v2 = temp;
}
