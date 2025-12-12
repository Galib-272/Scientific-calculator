%{
#include <stdio.h>
#include <stdlib.h>
#include "calculator.tab.h"
%}
%%
[ \t]       ;  /* skip whitespace */
[0-9]+\.?[0-9]*  { yylval.dval = atof(yytext); return NUMBER; }
"sin"       { return SIN; }
"cos"       { return COS; }
"tan"       { return TAN; }
"cot"       { return COT; }
"log"       { return LOG; }
"ln"        { return LN; }
"sqrt"      { return SQRT; }
"root"      { return ROOT; }
"abs"       { return ABS; }
"exp10"     { return EXP10; }
"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MUL; }
"/"         { return DIV; }
"^"         { return POW; }
"("         { return LPAREN; }
")"         { return RPAREN; }
","         { return COMMA; }
"|"         { return PIPE; }
\n          { return EOL; }
.           { printf("Unknown character: %s\n", yytext); }
%%
int yywrap() {
    return 1;
}