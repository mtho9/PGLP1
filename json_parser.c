#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "json_parser.h"

extern FILE* yyin;

void set_input(const char* input) {
    yyin = fopen(input, "r");
    if (!yyin) {
        perror("Error opening file");
        exit(1);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <json_file>\n", argv[0]);
        return 1;
    }

    set_input(argv[1]);

    if (yyparse() == 0) {
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }

    fclose(yyin);
    return 0;
}