%{
#include <stdio.h>
#include <string.h>

int python_line_number = 1;

void print_python_token(const char* type, const char* value) {
    printf("%-15s %-20s %d\n", type, value, python_line_number);
}

void print_python_error(const char* value) {
    printf("%-15s %-20s %d <- ERROR: Invalid token\n", "UNKNOWN", value, python_line_number);
}
%}

%option prefix="python_"
%option noyywrap

/* Define patterns */
DIGIT       [0-9]
LETTER      [a-zA-Z_]
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*
INTEGER     {DIGIT}+
FLOAT       {DIGIT}+\.{DIGIT}+
WHITESPACE  [ \t]+
NEWLINE     \n

%%

    /* Python Keywords */
"and"           { print_python_token("KEYWORD", yytext); }
"as"            { print_python_token("KEYWORD", yytext); }
"assert"        { print_python_token("KEYWORD", yytext); }
"break"         { print_python_token("KEYWORD", yytext); }
"class"         { print_python_token("KEYWORD", yytext); }
"continue"      { print_python_token("KEYWORD", yytext); }
"def"           { print_python_token("KEYWORD", yytext); }
"del"           { print_python_token("KEYWORD", yytext); }
"elif"          { print_python_token("KEYWORD", yytext); }
"else"          { print_python_token("KEYWORD", yytext); }
"except"        { print_python_token("KEYWORD", yytext); }
"exec"          { print_python_token("KEYWORD", yytext); }
"finally"       { print_python_token("KEYWORD", yytext); }
"for"           { print_python_token("KEYWORD", yytext); }
"from"          { print_python_token("KEYWORD", yytext); }
"global"        { print_python_token("KEYWORD", yytext); }
"if"            { print_python_token("KEYWORD", yytext); }
"import"        { print_python_token("KEYWORD", yytext); }
"in"            { print_python_token("KEYWORD", yytext); }
"is"            { print_python_token("KEYWORD", yytext); }
"lambda"        { print_python_token("KEYWORD", yytext); }
"not"           { print_python_token("KEYWORD", yytext); }
"or"            { print_python_token("KEYWORD", yytext); }
"pass"          { print_python_token("KEYWORD", yytext); }
"print"         { print_python_token("KEYWORD", yytext); }
"raise"         { print_python_token("KEYWORD", yytext); }
"return"        { print_python_token("KEYWORD", yytext); }
"try"           { print_python_token("KEYWORD", yytext); }
"while"         { print_python_token("KEYWORD", yytext); }
"with"          { print_python_token("KEYWORD", yytext); }
"yield"         { print_python_token("KEYWORD", yytext); }
"True"          { print_python_token("KEYWORD", yytext); }
"False"         { print_python_token("KEYWORD", yytext); }
"None"          { print_python_token("KEYWORD", yytext); }

    /* Operators */
"+"             { print_python_token("OPERATOR", yytext); }
"-"             { print_python_token("OPERATOR", yytext); }
"*"             { print_python_token("OPERATOR", yytext); }
"/"             { print_python_token("OPERATOR", yytext); }
"//"            { print_python_token("OPERATOR", yytext); }
"%"             { print_python_token("OPERATOR", yytext); }
"**"            { print_python_token("OPERATOR", yytext); }
"="             { print_python_token("OPERATOR", yytext); }
"=="            { print_python_token("OPERATOR", yytext); }
"!="            { print_python_token("OPERATOR", yytext); }
"<"             { print_python_token("OPERATOR", yytext); }
">"             { print_python_token("OPERATOR", yytext); }
"<="            { print_python_token("OPERATOR", yytext); }
">="            { print_python_token("OPERATOR", yytext); }
"+="            { print_python_token("OPERATOR", yytext); }
"-="            { print_python_token("OPERATOR", yytext); }
"*="            { print_python_token("OPERATOR", yytext); }
"/="            { print_python_token("OPERATOR", yytext); }
"//="           { print_python_token("OPERATOR", yytext); }
"%="            { print_python_token("OPERATOR", yytext); }
"**="           { print_python_token("OPERATOR", yytext); }
"&"             { print_python_token("OPERATOR", yytext); }
"|"             { print_python_token("OPERATOR", yytext); }
"^"             { print_python_token("OPERATOR", yytext); }
"~"             { print_python_token("OPERATOR", yytext); }
"<<"            { print_python_token("OPERATOR", yytext); }
">>"            { print_python_token("OPERATOR", yytext); }

    /* Punctuation/Symbols */
"{"             { print_python_token("SYMBOL", yytext); }
"}"             { print_python_token("SYMBOL", yytext); }
"("             { print_python_token("SYMBOL", yytext); }
")"             { print_python_token("SYMBOL", yytext); }
"["             { print_python_token("SYMBOL", yytext); }
"]"             { print_python_token("SYMBOL", yytext); }
":"             { print_python_token("SYMBOL", yytext); }
";"             { print_python_token("SYMBOL", yytext); }
","             { print_python_token("SYMBOL", yytext); }
"."             { print_python_token("SYMBOL", yytext); }

    /* String literals */
\"\"\"([^\"\\]|\\.)*\"\"\"      { print_python_token("STRING", "\"\"\"...\"\"\""); }
'''([^'\\]|\\.)*'''            { print_python_token("STRING", "'''...'''"); }
\"([^\"\\]|\\.)*\"             { print_python_token("STRING", yytext); }
'([^'\\]|\\.)*'                { print_python_token("STRING", yytext); }

    /* Comments */
"#".*           { print_python_token("COMMENT", yytext); }

    /* Numbers */
{FLOAT}         { print_python_token("FLOAT", yytext); }
{INTEGER}       { print_python_token("INTEGER", yytext); }

    /* Identifiers */
{IDENTIFIER}    { print_python_token("IDENTIFIER", yytext); }

    /* Whitespace */
{WHITESPACE}    { /* ignore whitespace */ }

    /* Newline */
{NEWLINE}       { python_line_number++; }

    /* Invalid characters */
.               { print_python_error(yytext); }

%%