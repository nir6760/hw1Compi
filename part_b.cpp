#include "tokens.hpp"
#include <iostream>
#include <stack>

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
    stack<char> s;
    string tab = "";


    while(token = yylex()) {
        // Your code here

        switch (token)  {
            case LPAREN :
                s.push('(');
                cout << tab << "("<<endl;
                tab +="\t";
                break;

            case LBRACE:
                s.push('{');
                cout << tab <<"{"<<endl;
                tab += "\t";
                break;

            case RPAREN :
                if (s.empty() || s.top()!='('){
                    cout<<"Error: Bad Expression"<<endl;
                    exit(0);
                }
                s.pop();
                tab.pop_back();
                cout << tab << ")"<<endl;
                break;

            case RBRACE :
                if (s.empty() || s.top()!='{'){
                    cout<<"Error: Bad Expression"<<endl;
                    exit(0);
                }
                s.pop();
                tab.pop_back();
                cout << tab << "}"<<endl;
                break;
                
            default:
                cout<<"Error: " <<tokens_arr[token-1] <<endl;
				exit(0);
        }

    }
	if (!s.empty())
                    cout<<"Error: Bad Expression"<<endl;;

    return 0;
}































