%{
#include "json_parser.h"
#include "json_parser.tab.h" // this should be created by Bison
%}

%%
"null"              { return NULL_TOKEN; }
"true"              { return TRUE_TOKEN; }
"false"             { return FALSE_TOKEN; }
-?[0-9]+(\.[0-9]+)? { yylval.str = strdup(yytext); return NUMBER; }
\"([^"\\]|\\["\\/bfnrt]|\\u[0-9a-fA-F]{4})*\" { yylval.str = strdup(yytext); return STRING; }
"{"                 { return OPEN_BRACE; }
"}"                 { return CLOSE_BRACE; }
"["                 { return OPEN_BRACKET; }
"]"                 { return CLOSE_BRACKET; }
":"                 { return COLON; }
","                 { return COMMA; }
[ \t\r\n]+          { /* Ignore whitespace */ }
.                   { printf("Unexpected character: %s\n", yytext); exit(1); }
%%