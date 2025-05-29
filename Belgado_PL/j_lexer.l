%{
#include <stdio.h>
#include <string.h>

int java_line_number = 1;

void print_java_token(const char* type, const char* value) {
    printf("%-15s %-20s %d\n", type, value, java_line_number);
}

void print_java_error(const char* value) {
    printf("%-15s %-20s %d <- ERROR: Invalid token\n", "UNKNOWN", value, java_line_number);
}
%}

%option prefix="java_"
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

    /* Java Keywords */
"abstract"      { print_java_token("KEYWORD", yytext); }
"boolean"       { print_java_token("KEYWORD", yytext); }
"break"         { print_java_token("KEYWORD", yytext); }
"byte"          { print_java_token("KEYWORD", yytext); }
"case"          { print_java_token("KEYWORD", yytext); }
"catch"         { print_java_token("KEYWORD", yytext); }
"char"          { print_java_token("KEYWORD", yytext); }
"class"         { print_java_token("KEYWORD", yytext); }
"const"         { print_java_token("KEYWORD", yytext); }
"continue"      { print_java_token("KEYWORD", yytext); }
"default"       { print_java_token("KEYWORD", yytext); }
"do"            { print_java_token("KEYWORD", yytext); }
"double"        { print_java_token("KEYWORD", yytext); }
"else"          { print_java_token("KEYWORD", yytext); }
"extends"       { print_java_token("KEYWORD", yytext); }
"final"         { print_java_token("KEYWORD", yytext); }
"finally"       { print_java_token("KEYWORD", yytext); }
"float"         { print_java_token("KEYWORD", yytext); }
"for"           { print_java_token("KEYWORD", yytext); }
"goto"          { print_java_token("KEYWORD", yytext); }
"if"            { print_java_token("KEYWORD", yytext); }
"implements"    { print_java_token("KEYWORD", yytext); }
"import"        { print_java_token("KEYWORD", yytext); }
"instanceof"    { print_java_token("KEYWORD", yytext); }
"int"           { print_java_token("KEYWORD", yytext); }
"interface"     { print_java_token("KEYWORD", yytext); }
"long"          { print_java_token("KEYWORD", yytext); }
"native"        { print_java_token("KEYWORD", yytext); }
"new"           { print_java_token("KEYWORD", yytext); }
"package"       { print_java_token("KEYWORD", yytext); }
"private"       { print_java_token("KEYWORD", yytext); }
"protected"     { print_java_token("KEYWORD", yytext); }
"public"        { print_java_token("KEYWORD", yytext); }
"return"        { print_java_token("KEYWORD", yytext); }
"short"         { print_java_token("KEYWORD", yytext); }
"static"        { print_java_token("KEYWORD", yytext); }
"strictfp"      { print_java_token("KEYWORD", yytext); }
"super"         { print_java_token("KEYWORD", yytext); }
"switch"        { print_java_token("KEYWORD", yytext); }
"synchronized"  { print_java_token("KEYWORD", yytext); }
"this"          { print_java_token("KEYWORD", yytext); }
"throw"         { print_java_token("KEYWORD", yytext); }
"throws"        { print_java_token("KEYWORD", yytext); }
"transient"     { print_java_token("KEYWORD", yytext); }
"try"           { print_java_token("KEYWORD", yytext); }
"void"          { print_java_token("KEYWORD", yytext); }
"volatile"      { print_java_token("KEYWORD", yytext); }
"while"         { print_java_token("KEYWORD", yytext); }
"true"          { print_java_token("KEYWORD", yytext); }
"false"         { print_java_token("KEYWORD", yytext); }
"null"          { print_java_token("KEYWORD", yytext); }

    /* Operators */
"+"             { print_java_token("OPERATOR", yytext); }
"-"             { print_java_token("OPERATOR", yytext); }
"*"             { print_java_token("OPERATOR", yytext); }
"/"             { print_java_token("OPERATOR", yytext); }
"%"             { print_java_token("OPERATOR", yytext); }
"="             { print_java_token("OPERATOR", yytext); }
"=="            { print_java_token("OPERATOR", yytext); }
"!="            { print_java_token("OPERATOR", yytext); }
"<"             { print_java_token("OPERATOR", yytext); }
">"             { print_java_token("OPERATOR", yytext); }
"<="            { print_java_token("OPERATOR", yytext); }
">="            { print_java_token("OPERATOR", yytext); }
"&&"            { print_java_token("OPERATOR", yytext); }
"||"            { print_java_token("OPERATOR", yytext); }
"!"             { print_java_token("OPERATOR", yytext); }
"++"            { print_java_token("OPERATOR", yytext); }
"--"            { print_java_token("OPERATOR", yytext); }
"+="            { print_java_token("OPERATOR", yytext); }
"-="            { print_java_token("OPERATOR", yytext); }
"*="            { print_java_token("OPERATOR", yytext); }
"/="            { print_java_token("OPERATOR", yytext); }
"%="            { print_java_token("OPERATOR", yytext); }
"&"             { print_java_token("OPERATOR", yytext); }
"|"             { print_java_token("OPERATOR", yytext); }
"^"             { print_java_token("OPERATOR", yytext); }
"~"             { print_java_token("OPERATOR", yytext); }
"<<"            { print_java_token("OPERATOR", yytext); }
">>"            { print_java_token("OPERATOR", yytext); }
">>>"           { print_java_token("OPERATOR", yytext); }

    /* Punctuation/Symbols */
"{"             { print_java_token("SYMBOL", yytext); }
"}"             { print_java_token("SYMBOL", yytext); }
"("             { print_java_token("SYMBOL", yytext); }
")"             { print_java_token("SYMBOL", yytext); }
"["             { print_java_token("SYMBOL", yytext); }
"]"             { print_java_token("SYMBOL", yytext); }
";"             { print_java_token("SYMBOL", yytext); }
","             { print_java_token("SYMBOL", yytext); }
"."             { print_java_token("SYMBOL", yytext); }

    /* String literals */
\"([^\"\\]|\\.)*\"  { print_java_token("STRING", yytext); }

    /* Character literals */
'([^'\\]|\\.)'      { print_java_token("CHAR", yytext); }

    /* Comments */
"/*"([^*]|\*+[^*/])*\*+"/"  { print_java_token("COMMENT", "/* ... */"); }
"//".*                      { print_java_token("COMMENT", yytext); }

    /* Numbers */
{FLOAT}         { print_java_token("FLOAT", yytext); }
{INTEGER}       { print_java_token("INTEGER", yytext); }

    /* Identifiers */
{IDENTIFIER}    { print_java_token("IDENTIFIER", yytext); }

    /* Whitespace */
{WHITESPACE}    { /* ignore whitespace */ }

    /* Newline */
{NEWLINE}       { java_line_number++; }

    /* Invalid characters */
.               { print_java_error(yytext); }

%%