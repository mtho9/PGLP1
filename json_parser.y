%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json_parser.h"

void yyerror(const char* msg);
%}

%union {
    char* str;
}

%token NULL_TOKEN TRUE_TOKEN FALSE_TOKEN NUMBER STRING
%token OPEN_BRACE CLOSE_BRACE OPEN_BRACKET CLOSE_BRACKET COLON COMMA

%%

json:
    object { printf("JSON parsed successfully.\n"); }
  | array { printf("JSON parsed successfully.\n"); }
  ;

object:
    OPEN_BRACE CLOSE_BRACE
  | OPEN_BRACE members CLOSE_BRACE
  ;

members:
    pair
  | members COMMA pair
  ;

pair:
    STRING COLON value
  ;

array:
    OPEN_BRACKET CLOSE_BRACKET
  | OPEN_BRACKET elements CLOSE_BRACKET
  ;

elements:
    value
  | elements COMMA value
  ;

value:
    STRING
  | NUMBER
  | TRUE_TOKEN
  | FALSE_TOKEN
  | NULL_TOKEN
  | object
  | array
  ;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(1);
}