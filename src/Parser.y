%{
#include <stdio.h>
//#include "include/util.h"
//#include "include/common.h"
char* parentScopeName;
void yyerror(const char* s);
extern int yylex();
%}
%code requires{
#include"include/common.h"
}
%union {
Token token;
ASTNode* node;
}

%{
ASTNode* root;
%}
%token  <token>TIDENTIFIER TINTEGER TFLOAT TDOUBLE TLITERAL
%token  <token>TYINT TYDOUBLE TYFLOAT TYCHAR TYBOOL TYVOID TYSTRING 
%token  <token>TCEQ TCNE TCLT TCLE TCGT TCGE
%token  <token>TEQUAL
%token  <token>TLPAREN TRPAREN TLBRACE TRBRACE TLBRACKET TRBRACKET TCOMMA TDOT TSEMICOLON
%token  <token>TPLUS TMINUS TMUL TDIV 
%token  <token>TAND TOR TXOR TMOD TNEG TNOT TSHIFTL TSHIFTR
%token  <token>TIF TELSE TFOR TWHILE TRETURN TSTRUCT TEXTERN

%type   <node>program declaration_list var_declaration  declaration
%type   <node>id num type_specifier params param compound_stmt local_declarations statement_list
%type   <node>statement selection_stmt expression_stmt iteration_stmt return_stmt
%type   <node>expression var simple_expression additive_expression term factor call arg_list args
%type   <node>param_list  fun_declaration



%left TPLUS TMINUS
%left TMUL TDIV TMOD
%start program

%%
program: { /*updateParentScopeName("program");*/ } declaration_list { root = $2;}
                   	;
declaration_list: declaration_list declaration {
							ASTNode* t = $1;
                          	if (t != NULL){
                          		while (t->sibling != NULL) t = t->sibling;
                            		t->sibling = $2;
                            		$$ = $1;
                          	}
                         	else $$ = $2;
                        }
                    	| declaration  { $$ = $1; }
                    	;
declaration         	: var_declaration  { $$ = $1; }
                    	| fun_declaration  { $$ = $1; }
                    	;
id    		: TIDENTIFIER {
				$$ = newNode(0,0); /* 没有类型，此节点不构成抽象语法树 */
				$$->attr.name = stringCopy(yytext); /* stringCopy在ast.h中定义 */
			}
            		;
num		: TINTEGER {
				$$ = newNode(0, 0); /* 没有类型，此节点不构成抽象语法树 */
				$$->attr.val = atof(yytext);
			}
             		;
var_declaration     	: type_specifier id TSEMICOLON {
			  				$$ = newNode(Decl_Node, Var_Declaration);
                          	$$->children[0] = $1; /* 类型 */
                          	$$->attr.name = $2->attr.name;
                          	insertSymbol($$->attr.name, $$);
                       	}
                    	| type_specifier id TLBRACKET num TRBRACKET TSEMICOLON {
                    		$$ = newNode(Decl_Node, Array_Declaration);
                          	$$->children[0] = $1;
                          	$$->attr.arr.name = $2->attr.name;
                          	$$->attr.arr.size = $4->attr.val;
                          	insertSymbol($$->attr.arr.name, $$);
                        }
                    	;
type_specifier: TYINT { $$ = newNode(Type_Node, INT_Value);  }
                    	| TYVOID { $$ = newNode(Type_Node, VOID_Value); }
                    	| TYFLOAT { $$ = newNode(Type_Node, FLOAT_Value); }
                    	;
fun_declaration: type_specifier id TLPAREN params TRPAREN compound_stmt {
							$$ = newNode(Decl_Node, Fun_Declaration);
							$$->attr.name = $2->attr.name;
							insertSymbol($$->attr.name, $$); /* 要在更新scopeName之前插入 */
							//updateParentScopeName($2->attr.name);
                          	$$->children[0] = $1; /* 返回值类型 */
                          	$$->children[1] = $4;    /* 函数参数 */
                          	$$->children[2] = $6; /* 函数体 */
                          	//updateParentScopeName("program");
                      	}
                    	;
params              	: param_list  { $$ = $1; }
                    	| TYVOID { $$ = newNode(Type_Node, VOID_Value); }
                        ;
param_list          	: param_list TCOMMA param {
							ASTNode* t = $1;
                          	if (t != NULL) {
                          		while (t->sibling != NULL) t = t->sibling;
                            		t->sibling = $3;
                            		$$ = $1;
                            	} else $$ = $3;
                        }
                    	| param { $$ = $1; };
param               	: type_specifier id {
			  	$$ = newNode(Param_Node, NotArray_Param);
                          	$$->children[0] = $1;
                          	$$->attr.name = $2->attr.name;
                          	insertSymbol($$->attr.name, $$);
                        }
                    	| type_specifier id TLBRACKET TRBRACKET {
                    		$$ = newNode(Param_Node, Array_Param);
                          	$$->children[0] = $1;
                          	$$->attr.name = $2->attr.name;
                          	insertSymbol($$->attr.name, $$);
                        }
                    	;
compound_stmt       	: TLBRACE local_declarations statement_list TRBRACE {
							$$ = newNode(Stmt_Node, Compound_Stmt);
                          	$$->children[0] = $2; /* local variable declarations */
                          	$$->children[1] = $3; /* statements */
                        }
                    	;
local_declarations 	: local_declarations var_declaration {
							ASTNode* t = $1;
                          	if (t != NULL) {
                          		while (t->sibling != NULL) t = t->sibling;
                              		t->sibling = $2;
                              		$$ = $1;
                              	}
                          	else $$ = $2;
                        }
                    	| /* empty */ { $$ = NULL; }
                    	;
statement_list      	: statement_list statement {
							ASTNode* t = $1;
                          	if (t != NULL) {
                          		while (t->sibling != NULL) t = t->sibling;
                              		t->sibling = $2;
                              		$$ = $1;
                              	}
                          	else $$ = $2;
                        }
                    	| /* empty */ { $$ = NULL; }
                    	;
statement           	: expression_stmt { $$ = $1; }
                    	| compound_stmt { $$ = $1; }
                    	| selection_stmt { $$ = $1; }
                    	| iteration_stmt { $$ = $1; }
                    	| return_stmt { $$ = $1; }
                    	;
expression_stmt     	: expression TSEMICOLON { $$ = $1; }
                    	| TSEMICOLON { $$ = NULL; }
                    	;
selection_stmt      	: TIF TLPAREN expression TRPAREN statement {
				$$ = newNode(Stmt_Node, Selection_Stmt);
                          	$$->children[0] = $3;
                          	$$->children[1] = $5;
                          	$$->children[2] = NULL;
                        }
                    	| TIF TLPAREN expression TRPAREN statement TELSE statement {
                    		$$ = newNode(Stmt_Node, Selection_Stmt);
                           	$$->children[0] = $3;
                           	$$->children[1] = $5;
                          	$$->children[2] = $7;
                        }
                    	;
iteration_stmt      	: TWHILE TLPAREN expression TRPAREN statement {
							$$ = newNode(Stmt_Node, Iteration_Stmt);
                          	$$->children[0] = $3;
                          	$$->children[1] = $5;
                        }
                    	;
return_stmt         	: TRETURN TSEMICOLON {
				$$ = newNode(Stmt_Node, Return_Stmt);
                          	$$->children[0] = NULL;
                        }
                    	| TRETURN expression TSEMICOLON {
                    		$$ = newNode(Stmt_Node, Return_Stmt);
                          	$$->children[0] = $2;
                        }
                    	;
expression          	: var TEQUAL expression {
							$$ = newNode(Exp_Node, Assign_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                        }
                    	| simple_expression { $$ = $1; }
                    	;
var                 	: id {
							$$ = newNode(Exp_Node, Id_Exp);
                          	$$->attr.name = $1->attr.name;
                        }
                    	| id TLBRACKET expression TRBRACKET {
                    		$$ = newNode(Exp_Node, ArrayId_Exp);
                        	$$->attr.name = $1->attr.name;
                        	$$->children[0] = $3;
                        }
                    	;
simple_expression   	: additive_expression TCLE additive_expression {
				$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCLE;
                        }
                    	| additive_expression TCLT additive_expression {
                    		$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCLT;

                        }
                    	| additive_expression TCGT additive_expression{
                        	$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCGT;
                        }
                    	| additive_expression TCGE additive_expression {
                    		$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCGE;
                        }
                      	| additive_expression TCEQ additive_expression {
                      		$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCEQ;
                        }
                    	| additive_expression TCNE additive_expression {
                    		$$ = newNode(Exp_Node, Relop_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TCNE;
                        }
                    	| additive_expression { $$ = $1; }
                    	;
additive_expression 	: additive_expression TPLUS term {
							$$ = newNode(Exp_Node, Additive_Exp);
                           	$$->children[0] = $1;
                            	$$->children[1] = $3;
                            	$$->attr.relop = TPLUS;
                        }
                    	| additive_expression TMINUS term {
                    		$$ = newNode(Exp_Node, Additive_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TMINUS;
                        }
                     	| term { $$ = $1; }
                    	;
term                	: term TMUL factor {
							$$ = newNode(Exp_Node, Mul_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TMUL;
                        }
                    	| term TDIV factor {
                    		$$ = newNode(Exp_Node, Mul_Exp);
                          	$$->children[0] = $1;
                          	$$->children[1] = $3;
                          	$$->attr.relop = TDIV;
                        }
                    	| factor { $$ = $1; }
                    	;
factor              	: TLPAREN expression TRPAREN { $$ = $2; }
                    	| var { $$ = $1; }
                    	| call { $$ = $1; }
                    	| num {
                    		$$ = newNode(Exp_Node, Constant_Exp);
                        	$$->attr.val = $1->attr.val;
                        }
                    	;
call:id TLPAREN args TRPAREN {
							$$ = newNode(Exp_Node, Call_Exp);
                        	$$->attr.name = $1->attr.name;
                            $$->children[0] = $3;
                        }
                    	;
args                	: arg_list { $$ = $1; }
                    	| /* empty */ { $$ = NULL; }
                    	;
arg_list            	: arg_list TCOMMA expression {
							ASTNode* t = $1;
                          	if (t != NULL) {
                          		while (t->sibling != NULL) t = t->sibling;
                              		t->sibling = $3;
                              		$$ = $1;
                              	}
                          	else $$ = $3;
                        }
                    	| expression { $$ = $1; }
                    	;
%%
void yyerror(const char* s){
fprintf(stderr,"error:%s\n",s);
}

int main(){
    yyparse();
    return 0;
}
