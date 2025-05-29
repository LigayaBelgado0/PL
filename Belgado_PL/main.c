#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>

// External function declarations for each language lexer
extern int c_lex(void);
extern int python_lex(void);
extern int java_lex(void);

// External file pointers for each lexer
extern FILE *c_in;
extern FILE *python_in;
extern FILE *java_in;

// Function for prototypes
void display_menu(void);
int get_language_choice(void);
void process_interactive_input(int language);
void setup_lexer_input(int language, FILE *input);
void run_lexer(int language);
void cleanup_temp_file(void);

// Variables
char temp_filename[] = "temp_input.tmp";

int main() {
    printf("------------------------------------------------------------------------------------\n");
    printf("               LEXICAL ANALYZER FOR C, PYTHON and JAVA               \n");
    printf("------------------------------------------------------------------------------------\n\n");

    int language_choice = get_language_choice();
    process_interactive_input(language_choice);
    
    return 0;
}

void display_menu(void) {
    printf("Select Programming Language:\n");
    printf("1. C\n");
    printf("2. Python\n");
    printf("3. Java\n");
    printf("Enter your choice (1-3): ");
}

int get_language_choice(void) {
    int choice;
    
    do {
        display_menu();
        if (scanf("%d", &choice) != 1) {
            printf("Error: Invalid input. Please enter a number.\n\n");
            while (getchar() != '\n'); // Clear input buffer
            choice = 0;
            continue;
        }
        
        if (choice < 1 || choice > 3) {
            printf("Error: Please select a valid option (1-3).\n\n");
        }
    } while (choice < 1 || choice > 3);
    
    // Clear input buffer
    while (getchar() != '\n');
    
    return choice;
}

void process_interactive_input(int language) {
    FILE *temp_file;
    char line[1000];

    printf("\nEnter your code (type 'END' on a new line to finish):\n");
    printf("----------------------------------------\n");

    // Create temporary file
    temp_file = fopen(temp_filename, "w");
    if (!temp_file) {
        printf("Error: Cannot create temporary file.\n");
        return;
    }

    // Read input lines until "END"
    while (fgets(line, sizeof(line), stdin)) {
        line[strcspn(line, "\r\n")] = '\0'; // Remove newline characters

        char upper_line[1000];
        strcpy(upper_line, line);
        for (int i = 0; upper_line[i]; i++) {
            upper_line[i] = toupper((unsigned char)upper_line[i]);
        }

        if (strcmp(upper_line, "END") == 0) {
            break;
        }

        fprintf(temp_file, "%s\n", line); // Add newline back to saved line
    }

    fclose(temp_file);

    // Reopen for reading
    temp_file = fopen(temp_filename, "r");
    if (!temp_file) {
        printf("Error: Cannot read temporary file.\n");
        return;
    }

    setup_lexer_input(language, temp_file);

    printf("\n=== LEXICAL ANALYSIS RESULTS ===\n");
    run_lexer(language);

    fclose(temp_file);
    cleanup_temp_file();
}

void setup_lexer_input(int language, FILE *input) {
    switch (language) {
        case 1:
            c_in = input;
            break;
        case 2:
            python_in = input;
            break;
        case 3:
            java_in = input;
            break;
    }
}

void run_lexer(int language) {
    const char* language_names[] = {"", "C", "Python", "Java"};

    printf("Language: %s\n", language_names[language]);
    printf("%-15s %-20s %s\n", "TOKEN TYPE", "TOKEN VALUE", "LINE");
    printf("-----------------------------------------------\n");

    switch (language) {
        case 1:
            while (c_lex() != 0);
            break;
        case 2:
            while (python_lex() != 0);
            break;
        case 3:
            while (java_lex() != 0);
            break;
    }

    printf("-----------------------------------------------\n");
    printf("Lexical analysis completed.\n");
}

void cleanup_temp_file(void) {
    if (access(temp_filename, F_OK) == 0) {
        remove(temp_filename);
    }
}
