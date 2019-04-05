%{
	#include "lua.tab.h"
	#include <string.h>
	#include <stdio.h>
	#include <stdlib.h>

	int col_no = 1;
	int line_no = 1;
	int counter = 0;

	int check = 0;
	int s_check = 0;

	typedef struct node
	{
		char name[100];
		int type;
	    int col;
	    int row;
	    int scope;
	}sym_tab;

	sym_tab symbol_table[1000];

void LibFuc()
{
	symbol_table[0].type = 1;
	symbol_table[1].type = 1;
	symbol_table[2].type = 1;
	symbol_table[3].type = 1;
	symbol_table[4].type = 1;

	strcpy(symbol_table[0].name ,"print");
	strcpy(symbol_table[1].name ,"sub");
	strcpy(symbol_table[2].name ,"read");
	strcpy(symbol_table[3].name ,"random");
	strcpy(symbol_table[4].name ,"find");

	counter = 5;
}

	int Search_Symbol(char* str)
	{
		if(counter == 0)
			LibFuc();

		for(int i = 0 ; i < counter ; i++)
		{	
			//Functions and Identifiers cannot have Same Names
			if(strcmp(symbol_table[i].name,str) == 0)
			{
				return 1;//Found
			}
		}
		
		return 0;// Not Found
	}
	
%}

%option yylineno

%%
"$" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return DOLLAR;}
"--"(.)*"\n" {col_no = 0 ; line_no++;}
("\t"|" "|"\n") {if(strcmp(yytext,"\n")==0){col_no = 0;line_no++;} else if(strcmp(yytext,"\t")==0){col_no += 4;}else col_no += strlen(yytext);}
\"(\\.|[^"\\])*\" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return STRING;}
and {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return AND;}
break {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return BREAK;}
do {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return DO;}
else {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return ELSE;}
elseif {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return ELSEIF;}
end {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext); return END;}
false {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return FALSE;}
for {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return FOR;}
function {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext); check = 1;return FUNCTION;}
if {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return IF;}
in {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return IN;}
local {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext); s_check = 1;return LOCAL;}
nil {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return NIL;}
not {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return NOT;}
or {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return OR;}
repeat {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return REPEAT;}
return {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return RETURN;}
then {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return THEN;}
true {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return TRUE;}
until {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return UNTIL;}
while {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return WHILE;}
("#") {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return HASH;}
("+"|"*"|"/"|"^"|"%"|".."|"<"|"<="|">"|">="|"=="|"~=") {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return BINOP;}
";" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return SEMICOLON;}
"," {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return COMMA;}
"=" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return EQUALS;}
"(" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return LB;}
")" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);check = 0 ;col_no += strlen(yytext);return RB;}
"{" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return LFB;}
"}" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return RFB;}
"[" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return LSB;}
"]" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return RSB;}
":" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return COLON;}
"..." {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return VARDOT;}
"." {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return DOT;}
"-" {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return MINUS;}

[A-Za-z_][0-9A-Za-z_]* {
	printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);
	if(!Search_Symbol(yytext))
	{
		symbol_table[counter].col = col_no;
		symbol_table[counter].row = line_no;
		symbol_table[counter].type = check;
		symbol_table[counter].scope = s_check;

		check = 0;
		s_check = 0;

		strcpy(symbol_table[counter].name,yytext);
		counter++;
	}
		col_no += strlen(yytext);
		return ID;
}

[0-9]+ {printf(" Lexeme Name :%s, Colno: %d ,Line no: %d\n ",yytext,col_no,line_no);col_no += strlen(yytext);return NUM;}
(.) {col_no += strlen(yytext);}
%%
int yywrap()
{
	return 1;
}