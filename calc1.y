%{
    #include <stdio.h>
	#include <math.h>
    int yylex(void);
    void yyerror(char *);
    void swap(int *, int *);
    void while_f();
    int sym[26],i=0;
%}

%token INTEGER FLOAT STRING BOOLEAN ARRAY VAR  
%token WHILE FOR IF DO END
%token AND OR PROCEDURE VALUE START MOD REM NOT
%nonassoc THEN ELSE ELLIPSIS SWAP
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
            ;

expr:
        INTEGER
        |FLOAT
        |STRING
        |BOOLEAN
        |ARRAY
        |VAR                      { $$ = sym[$1]; }  
        | expr '/' expr           { $$ = $1 / $3; }   
        | expr '*' expr           { $$ = $1 * $3; }
        | expr '+' expr           { $$ = $1 + $3; }
        | expr '-' expr           { $$ = $1 - $3; }
        | expr '^' expr           { $$ = pow($2,$3); }
        | '(' expr ')'            { $$ = $2;}
        | expr SWAP expr          { swap($1,$2);}
        ;


%%

void yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
}

void while_f(){

             for(i=0;i<=10;i++){
                 printf("%d\n",i);
             }
    }

int main(void) {
    yyparse();
    return 0;
	}

void swap(int *v1, int *v2){
    int temp;
    temp = *v1;
    *v1 = *v2;
    *v2 = temp;
}
