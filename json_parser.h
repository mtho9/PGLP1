#ifndef JSON_PARSER_H
#define JSON_PARSER_H

void yyerror(const char* msg);
int yyparse();
int yylex();
void set_input(const char* input);

#endif // JSON_PARSER_H