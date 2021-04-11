%{

/* Declarations section */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tokens.hpp"
char addHexa(char* hex);
void unclosedErr();
void undefinedErr(char* hex);
char string_buf[MAX_STR_CONST];
char *string_buf_ptr;
bool string_err=false;
char string_error[MAX_STR_CONST]={'\0'};
%}

%option yylineno 
%option noyywrap
%x comment
%x str
relop           ([==|!=|<|>|<=|>=])
binop           ([+|-|*|/])
digit   		([0-9])
letter			([a-zA-Z])
id  			([a-zA-Z][a-zA-Z0-9]*)
whitespace		([\r\t\n ])

%%
{whitespace}+				;
void                        return VOID;
int                        return INT;
byte                        return BYTE;
b                        return B;
bool                        return BOOL;
and                        return AND;
or                        return OR;
not                        return NOT;
true                        return TRUE;
false                     return FALSE;
return                        return RETURN;
if                        return IF;
else                        return ELSE;
while                        return WHILE;
break                        return BREAK;
continue                        return CONTINUE;
switch                        return SWITCH;
case                        return CASE;
default                        return DEFAULT;
:                        return COLON;
;                        return SC;
,                        return COMMA;
\(                        return LPAREN;
\)                        return RPAREN;
\{                        return LBRACE;
\}                        return RBRACE;
=                        return ASSIGN;
{relop}                        return RELOP;
{binop}                        return BINOP;
"//"         BEGIN(comment);
<comment>{
	[^\r|\n]*		{BEGIN(INITIAL);return COMMENT;}
	\n	{        
        BEGIN(INITIAL);
        
        }/* eat anything that's not LF */
	\r	{
        BEGIN(INITIAL);
        
        }/* eat anything that's not CR */
	<<EOF>> 	{BEGIN(INITIAL);return COMMENT;}
	}
{id}+ return ID;
0 return NUM;
[1-9]+{digit}* return NUM;
\"      {string_buf_ptr = string_buf; BEGIN(str);}
<str>{
	 
	\"	{ /* saw closing quote - all done */
		BEGIN(INITIAL);
        *string_buf_ptr = '\0';
		if (string_err) /*when there was error inside the string*/
		{
			printf("%s",string_error);
			exit(0);
		}
		return STRING;
		}

		\\\\  *string_buf_ptr++ = '\\';
		\\\"   *string_buf_ptr++ = '"';		
        \\n  *string_buf_ptr++ = '\n';
        \\t  *string_buf_ptr++ = '\t';
        \\r  *string_buf_ptr++ = '\r';
        \\0  *string_buf_ptr++ = '\0'; 
		\\x[0-7][0-9a-fA-F]		*string_buf_ptr++ =addHexa(yytext);
		\n	{
			unclosedErr();
		}		
		\\x[^\"]{0,2}		{
			if (string_error[0] == '\0')
		{
			undefinedErr(++yytext);
		}
			
                        
		}
		\\[^\"]		{
			undefinedErr(++yytext);
		}
		[^\r|\n|\\"]        {
        char *yptr = yytext;
        while ( *yptr )
                *string_buf_ptr++ = *yptr++;
        }
		<<EOF>>	{
			unclosedErr();
		}
		.	{
			unclosedErr();
		}
		
	}
.		{
			printf("Error %s\n",yytext);
			exit(0);
		}

%%
/* c code */
char addHexa(char* hex){
	hex=hex+2;
	char ret =strtoul(hex,NULL,16);
	return ret;
	
	
}	
void unclosedErr(){
	printf("Error unclosed string\n");
	exit(0);
}
void undefinedErr(char* hex){
	if(!string_err){
		strcpy(string_error,"Error undefined escape sequence \0");
		strcat(string_error, hex);
		strcat(string_error, "\n\0");
		string_err = true;
	}
	
}

