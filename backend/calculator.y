%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int yylex();
void yyerror(const char *s);
#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif
%}
%union {
    double dval;
}
%token <dval> NUMBER
%token SIN COS TAN COT LOG LN SQRT ROOT ABS EXP10
%token PLUS MINUS MUL DIV POW
%token LPAREN RPAREN COMMA PIPE
%token EOL
%type <dval> exp
%left PLUS MINUS
%left MUL DIV
%left PIPE
%right POW
%right UMINUS
%%
calclist:
    | calclist exp EOL { printf("Result: %.2f\n\n", $2); printf("Enter expression (Ctrl+Z to end): "); }
    | calclist error EOL { 
        yyerrok; 
        printf("\nEnter expression (Ctrl+Z to end): "); 
    }
    ;
exp:
    NUMBER              { $$ = $1; }
    | exp PLUS exp      { $$ = $1 + $3; }
    | exp MINUS exp     { $$ = $1 - $3; }
    | exp MUL exp       { $$ = $1 * $3; }
    | exp DIV exp       { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | exp POW exp       { $$ = pow($1, $3); }
    | MINUS exp %prec UMINUS { $$ = -$2; }
    | LPAREN exp RPAREN { $$ = $2; }
    | SIN LPAREN exp RPAREN { $$ = sin($3 * M_PI / 180.0); }
    | COS LPAREN exp RPAREN { $$ = cos($3 * M_PI / 180.0); }
    | TAN LPAREN exp RPAREN { $$ = tan($3 * M_PI / 180.0); }
    | COT LPAREN exp RPAREN { 
        double tan_val = tan($3 * M_PI / 180.0);
        if (tan_val == 0) {
            yyerror("Cotangent undefined");
            $$ = 0;
        } else {
            $$ = 1.0 / tan_val;
        }
    }
    | LOG LPAREN exp RPAREN { 
        if ($3 <= 0) {
            yyerror("Log of non-positive number");
            $$ = 0;
        } else {
            $$ = log10($3);
        }
    }
    | LN LPAREN exp RPAREN { 
        if ($3 <= 0) {
            yyerror("Ln of non-positive number");
            $$ = 0;
        } else {
            $$ = log($3);
        }
    }
    | SQRT LPAREN exp RPAREN { 
        if ($3 < 0) {
            yyerror("Square root of negative number");
            $$ = 0;
        } else {
            $$ = sqrt($3);
        }
    }
    | ROOT LPAREN exp COMMA exp RPAREN { 
        if ($5 == 0) {
            yyerror("Root index cannot be zero");
            $$ = 0;
        } else if ($3 < 0 && fmod($5, 2) == 0) {
            yyerror("Even root of negative number");
            $$ = 0;
        } else {
            $$ = pow($3, 1.0 / $5);
        }
    }
    | ABS LPAREN exp RPAREN { $$ = fabs($3); }
    | PIPE exp PIPE { $$ = fabs($2); }
    | EXP10 LPAREN exp RPAREN { $$ = pow(10, $3); }
    ;
%%
void yyerror(const char *s) {
    fprintf(stderr, "Invalid input! ");
}
int main() {
    printf("Enter expression (Ctrl+Z to end): ");
    yyparse();
    return 0;
}