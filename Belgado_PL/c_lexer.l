%{
#include <stdio.h>
#include <string.h>

int c_line_number = 1;

void print_token(const char* type, const char* value) {
    printf("%-15s %-20s %d\n", type, value, c_line_number);
}

void print_error(const char* value) {
    printf("%-15s %-20s %d <- ERROR: Invalid token\n", "UNKNOWN", value, c_line_number);
}
%}

%option prefix="c_"
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

    /* C Keywords */
"auto"          { print_token("KEYWORD", yytext); }
"break"         { print_token("KEYWORD", yytext); }
"case"          { print_token("KEYWORD", yytext); }
"char"          { print_token("KEYWORD", yytext); }
"const"         { print_token("KEYWORD", yytext); }
"continue"      { print_token("KEYWORD", yytext); }
"default"       { print_token("KEYWORD", yytext); }
"do"            { print_token("KEYWORD", yytext); }
"double"        { print_token("KEYWORD", yytext); }
"else"          { print_token("KEYWORD", yytext); }
"enum"          { print_token("KEYWORD", yytext); }
"extern"        { print_token("KEYWORD", yytext); }
"float"         { print_token("KEYWORD", yytext); }
"for"           { print_token("KEYWORD", yytext); }
"goto"          { print_token("KEYWORD", yytext); }
"if"            { print_token("KEYWORD", yytext); }
"int"           { print_token("KEYWORD", yytext); }
"long"          { print_token("KEYWORD", yytext); }
"register"      { print_token("KEYWORD", yytext); }
"return"        { print_token("KEYWORD", yytext); }
"short"         { print_token("KEYWORD", yytext); }
"signed"        { print_token("KEYWORD", yytext); }
"sizeof"        { print_token("KEYWORD", yytext); }
"static"        { print_token("KEYWORD", yytext); }
"struct"        { print_token("KEYWORD", yytext); }
"switch"        { print_token("KEYWORD", yytext); }
"typedef"       { print_token("KEYWORD", yytext); }
"union"         { print_token("KEYWORD", yytext); }
"unsigned"      { print_token("KEYWORD", yytext); }
"void"          { print_token("KEYWORD", yytext); }
"volatile"      { print_token("KEYWORD", yytext); }
"while"         { print_token("KEYWORD", yytext); }
"#include"      { print_token("PREPROCESSOR", yytext); }
"#define"       { print_token("PREPROCESSOR", yytext); }

    /* Operators */
"+"             { print_token("OPERATOR", yytext); }
"-"             { print_token("OPERATOR", yytext); }
"*"             { print_token("OPERATOR", yytext); }
"/"             { print_token("OPERATOR", yytext); }
"%"             { print_token("OPERATOR", yytext); }
"="             { print_token("OPERATOR", yytext); }
"=="            { print_token("OPERATOR", yytext); }
"!="            { print_token("OPERATOR", yytext); }
"<"             { print_token("OPERATOR", yytext); }
">"             { print_token("OPERATOR", yytext); }
"<="            { print_token("OPERATOR", yytext); }
">="            { print_token("OPERATOR", yytext); }
"&&"            { print_token("OPERATOR", yytext); }
"||"            { print_token("OPERATOR", yytext); }
"!"             { print_token("OPERATOR", yytext); }
"++"            { print_token("OPERATOR", yytext); }
"--"            { print_token("OPERATOR", yytext); }
"+="            { print_token("OPERATOR", yytext); }
"-="            { print_token("OPERATOR", yytext); }
"*="            { print_token("OPERATOR", yytext); }
"/="            { print_token("OPERATOR", yytext); }
"&"             { print_token("OPERATOR", yytext); }
"|"             { print_token("OPERATOR", yytext); }
"^"             { print_token("OPERATOR", yytext); }
"~"             { print_token("OPERATOR", yytext); }
"<<"            { print_token("OPERATOR", yytext); }
">>"            { print_token("OPERATOR", yytext); }

    /* Punctuation/Symbols */
"{"             { print_token("SYMBOL", yytext); }
"}"             { print_token("SYMBOL", yytext); }
"("             { print_token("SYMBOL", yytext); }
")"             { print_token("SYMBOL", yytext); }
"["             { print_token("SYMBOL", yytext); }
"]"             { print_token("SYMBOL", yytext); }
";"             { print_token("SYMBOL", yytext); }
","             { print_token("SYMBOL", yytext); }
"."             { print_token("SYMBOL", yytext); }
"->"            { print_token("SYMBOL", yytext); }

    /* String literals */
\"([^\"\\]|\\.)*\"  { print_token("STRING", yytext); }

    /* Character literals */
'([^'\\]|\\.)'      { print_token("CHAR", yytext); }

    /* Comments */
"/*"([^*]|\*+[^*/])*\*+"/"  { print_token("COMMENT", "/* ... */"); }
"//".*                      { print_token("COMMENT", yytext); }

    /* Numbers */
{FLOAT}         { print_token("FLOAT", yytext); }
{INTEGER}       { print_token("INTEGER", yytext); }

    /* Identifiers */
{IDENTIFIER}    { print_token("IDENTIFIER", yytext); }

    /* Whitespace */
{WHITESPACE}    { /* ignore whitespace */ }

    /* Newline */
{NEWLINE}       { c_line_number++; }

    /* Invalid characters */
.               { print_error(yytext); }

%%