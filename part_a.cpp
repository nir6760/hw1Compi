#include "tokens.hpp"
#include <iostream>
using namespace std;
int main()
{
	int token;
	string tokens_arr[] ={
	"VOID", 
	"INT", 
	"BYTE", 
	"B", 
	"BOOL", 
	"AND", 
	"OR", 
	"NOT", 
	"TRUE", 
	"FALSE", 
	"RETURN", 
	"IF", 
	"ELSE", 
	"WHILE", 
	"BREAK", 
	"CONTINUE",
	"SWITCH",
	"CASE",
	"DEFAULT",
	"COLON",
	"SC",
	"COMMA",
	"LPAREN",
	"RPAREN",
	"LBRACE",
	"RBRACE",
	"ASSIGN",
	"RELOP",
	"BINOP",
	"COMMENT",
	"ID",
	"NUM",
	"STRING"
	};
		
	while(token = yylex()) {
	// Your code here
	
		switch (token)  {
			case COMMENT:
				cout<<yylineno<<" " <<tokens_arr[token-1]<<" //"<<endl;
        	break;
    		case STRING:
				cout<<yylineno<<" " <<tokens_arr[token-1] <<" " << string_buf<<endl;
        	break;
      
    		default:
				cout<<yylineno<<" " <<tokens_arr[token-1] <<" " << yytext<<endl;
		}

	}
	return 0;
}