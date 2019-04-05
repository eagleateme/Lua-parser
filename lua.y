	%{
	#include <stdio.h>
	#include <stdlib.h>
	extern FILE* yyin;
	int yyerror();
	int yylex();
	extern char yytext[];
	extern int line_no;
	extern int col_no;

	typedef struct node
	{
		char name[100];
		int type;
	    int col;
	    int row;
	    int scope;
	}sym_tab;

	extern sym_tab symbol_table[];
	extern int counter; 	
%}

%define parse.error verbose
%token AND BREAK DO ELSE ELSEIF END FALSE FOR FUNCTION IF IN LOCAL NIL NOT OR REPEAT RETURN THEN TRUE UNTIL WHILE 
%token HASH BINOP EQUALS MINUS
%token LB RB LFB RFB LSB RSB
%token SEMICOLON COMMA COLON DOT VARDOT
%token ID NUM STRING
%token DOLLAR


%start s

%%

s               : block DOLLAR;

block 			: chunk ;

chunk 			: star_stat last_stat_opt 
				  |;

star_stat 		: star_stat stat opt_semicolon  
				  |;

last_stat_opt 	: last_stat opt_semicolon
				  |;

opt_semicolon	: SEMICOLON
				  |;

stat            :  var_list EQUALS exp_list
				  |function_call
				  |DO block END
				  |WHILE exp DO block END
				  |REPEAT block UNTIL exp 
				  |IF exp THEN block elseif_star else_opt END
				  |FOR ID EQUALS exp COMMA exp comma_exp_opt DO block END
				  |FOR name_list IN exp_list DO block END
			      |FUNCTION func_name func_body
				  |LOCAL FUNCTION ID func_body
				  |LOCAL name_list opt_equals;

comma_exp_opt	: COMMA exp
				  |;

elseif_star     : elseif_star ELSEIF exp THEN block 
				  |;

else_opt		: ELSE block
				  |;

opt_equals      : EQUALS exp_list
				  |;

last_stat   	: RETURN exp_list_opt
				  |BREAK;

exp_list_opt    : exp_list
				  |;

func_name 		: ID dot_id_star colon_id_opt;

dot_id_star     : dot_id_star DOT ID
				  |;

colon_id_opt    : COLON ID
				  |;

var_list 		: var var_star;

var_star 		: var_star COMMA var 
				  |;

var  			: ID 
				  |prefix_exp LSB exp RSB
				  |prefix_exp DOT ID;

name_list		: ID comma_id_star;

comma_id_star   : comma_id_star COMMA ID
				  |;

exp_list 		: exp_comma_star exp;

exp_comma_star  : exp_comma_star exp COMMA
				  |;

exp 			: NIL 
				  |FALSE
				  |TRUE 
				  |NUM 
				  |STRING 
				  |VARDOT 
				  |func 
				  |prefix_exp 
				  |table_const 
				  |LB exp BINOP exp RB
				  |LB exp OR exp RB
				  |LB exp AND exp RB
				  |unop exp;

prefix_exp 		:  var
				   |function_call
				   |LB exp RB;

function_call	:   prefix_exp args 
					|prefix_exp COLON ID args

args			:	 LB exp_list_opt RB
					|STRING 
					|table_const;
					

func 			:   FUNCTION func_body;

func_body 		:   LB par_list_opt RB block END;

par_list_opt    :   par_list
					|;

par_list		:   name_list comma_vardot_o 
					|VARDOT;

comma_vardot_o  :   COMMA VARDOT
					|;

table_const     :   LFB field_list_opt RFB;

field_list_opt :	field_list
					|;

field_list      :   field f_sep_f_star field_sep_op

f_sep_f_star    :   f_sep_f_star field_sep field
					|;

field_sep_op 	:   field_sep
					|;

field           :   LSB exp RSB EQUALS exp
					|ID EQUALS exp 
					|exp;


field_sep       :   COMMA
					|SEMICOLON;


unop            :   MINUS
					|NOT
					|HASH;
%%

int yyerror(const char *str)
{
    printf("\ninput.lua : ERROR %d.%d %s\n",line_no,col_no,str);
    return 1;
}

void main ()
{
	yyin = fopen("in","r");
	if(yyparse())
	{	printf("FAILURE\n");
		exit(0);
	}
	printf("\nSUCCESS\n");

	for(int i = 0 ; i < counter ; i++)
	{
		printf("Name : %s\tLine : %d\tColumn : %d\t",symbol_table[i].name,symbol_table[i].row,symbol_table[i].col);
		
		if(symbol_table[i].scope == 1)
			printf("Local\t");
		else
			printf("Global\t");

		if(symbol_table[i].type == 1)
			printf("Function\n");
		else
			printf("Identifier\n");
	}
}
