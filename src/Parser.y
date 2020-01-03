%{
#include <stdio.h>
%}
%union {
struct {
int tokenType;
char* tokenString;
}token;
}
%token  <token>TIDENTIFIER TINTEGER TFLOAT TDOUBLE TLITERAL
%token  <token>TYINT TYDOUBLE TYFLOAT TYCHAR TYBOOL TYVOID TYSTRING 
%token  <token>TCEQ TCNE TCLT TCLE TCGT TCGE
%token  <token>TEQUAL
%token  <token>TLPAREN TRPAREN TLBRACE TRBRACE TLBRACKET TRBRACKET TCOMMA TDOT TSEMICOLON
%token  <token>TPLUS TMINUS TMUL TDIV 
%token  <token>TAND TOR TXOR TMOD TNEG TNOT TSHIFTL TSHIFTR
%token  <token>TIF TELSE TFOR TWHILE TRETURN TSTRUCT TEXTERN



%left TPLUS TMINUS
%left TMUL TDIV TMOD
%start program

%%
program: declaration_list {printf("rule1\n");}
				;
declaration_list: declaration_list declaration  {  }
	| declaration {printf("rule2\n"); }
			;
declaration: var_declaration {printf("rule3\n");}| fun_declaration{printf("rule4\n"); };
var_declaration: type_specifier TIDENTIFIER TSEMICOLON{printf("rule5\n");}
				|type_specifier TIDENTIFIER TLBRACKET TINTEGER TRBRACKET TSEMICOLON
				;
type_specifier: TYINT{printf("rule 5\n");}|TYVOID{printf("rule6\n"); };
fun_declaration: type_specifier TIDENTIFIER TLPAREN params TRPAREN compound_stmt;
params:params_list|TYVOID;
params_list:params_list TCOMMA param|param;
param:type_specifier TIDENTIFIER|type_specifier TIDENTIFIER TLBRACKET TRBRACKET;
compound_stmt:TLBRACE local_declarations statement_list TRBRACE;
local_declarations:|local_declarations var_declaration;
statement_list:|statement_list statement;
statement:expression_stmt|compound_stmt|selection_stmt|iteration_stmt|return_stmt;
expression_stmt:expression TSEMICOLON|TSEMICOLON;
selection_stmt:TIF TLPAREN expression TRPAREN statement|TIF TLPAREN expression TRPAREN statement TELSE statement;
iteration_stmt:TWHILE TLPAREN expression TRPAREN statement;
return_stmt:TRETURN TSEMICOLON|TRETURN expression{printf("rule return_stmt");} TSEMICOLON;
expression:var TEQUAL expression|simple_expression;
var:TIDENTIFIER|TIDENTIFIER TLBRACKET expression TRBRACKET;
simple_expression:additive_expression relop additive_expression|additive_expression;
relop:TCEQ|TCNE|TCLT|TCLE|TCGT|TCGE;
additive_expression:additive_expression addop term|term;
addop:TPLUS|TMINUS;
term:term mulop factor|factor;
mulop:TMUL|TDIV;
factor:TLPAREN expression TRPAREN|var|call|TINTEGER;
call:TIDENTIFIER TLPAREN args TRPAREN;
args:|arg_list;
arg_list:arg_list TCOMMA expression|expression
%%
void yyerror(const char* s){
	printf("Error:%s\n",s);
}
int main(){
    yyparse();
    return 0;
}
