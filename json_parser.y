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
      { printf("Parsed empty object\n"); }
  | OPEN_BRACE members CLOSE_BRACE
      { printf("Parsed object with members\n"); }
  ;

members:
    pair { printf("Parsed member\n"); }
  | members COMMA pair { printf("Parsed multiple members\n"); }
  ;

pair:
    STRING COLON value { printf("Parsed pair: %s\n", $1); free($1); }
  ;

array:
    OPEN_BRACKET CLOSE_BRACKET
      { printf("Parsed empty array\n"); }
  | OPEN_BRACKET elements CLOSE_BRACKET
      { printf("Parsed array with elements\n"); }
  ;

elements:
    value { printf("Parsed element\n"); }
  | elements COMMA value { printf("Parsed multiple elements\n"); }
  ;

value:
    STRING { printf("Parsed string: %s\n", $1); free($1); }
  | NUMBER { printf("Parsed number: %s\n", $1); free($1); }
  | TRUE_TOKEN { printf("Parsed TRUE\n"); }
  | FALSE_TOKEN { printf("Parsed FALSE\n"); }
  | NULL_TOKEN { printf("Parsed NULL\n"); }
  | object { printf("Parsed nested object\n"); }
  | array { printf("Parsed nested array\n"); }
  ;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "Error: %s\n", msg);
    exit(1);
}