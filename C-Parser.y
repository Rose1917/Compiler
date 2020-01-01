/*
 *file: C-Parser.y
 *auther: RenYanjie
 *system: manjaro
 */
%{
#include<stdio.h>
#include<stdlib.h>
#define YYSTYPE char*
%}

%token identifier AUTO BREAK CASE CHAR 
%token CONST CONTINUE DEFAULT DO DOUBLE 
%token ELSE ENUM EXTERN FLOAT FOR GOTO 
%token IF INT LONG REGISTER RETURN AND_NOT
%token SHORT SIGNED SIZEOF STATIC STRUCT 
%token SWITCH TYPEDEF UNSIGNED UNION 
%token DEC INC LPAREN NOT RPAREN SEMICOLON
%token VOID VOLATILE WHILE number array
%token LBRACE RBRACE RBRACK LBRACK
%token COMMA AND_NOT_ASSIGN PERIOD 
%token RBRAEN COLON POT DQUA SQUA
%left ASSIGN    ADD_ASSIGN  SUB_ASSIGN  MUL_ASSIGN  QUO_ASSIGN REM_ASSIGN  AND_ASSIGN  OR_ASSIGN  XOR_ASSIGN  SHL_ASSIGN  SHR_ASSIGN AND_NOASSIGN
/*条件运算符?:还未实现*/

/*以下操作符有优先级，顺序不可改变*/
%left LOR
%left LAND
%left OR
%left XOR
%left AND
%left NEQ EQL
%left LSS GTR LEQ GEQ
%left SHR SHL
%left ADD SUB
%left MUL QUO REM
/*单目运算符未声明*/
%start translation_unit
%%
/*C代码入口*/
translation_unit: 
    external_declaration
    | translation_unit external_declaration
    ;
/* 
 *代码块
 *分为函数块、变量块
 */
external_declaration
    : function_definition
    | declaration
    ;
/*
 *函数块
 *分为4种情况：
 * 1. int print(int a, int b){int a = 0;}
 * 2. int print();
 * 3. int print(){int a = 0;}
 * 4. int print(int a, int b);
 */
function_definition
    : type_specifier identifier LPAREN parameter_list RPAREN compound_statement
    | type_specifier identifier LPAREN RPAREN compound_statement
    | type_specifier identifier LPAREN parameter_list RPAREN SEMICOLON
    |   type_specifier identifier LPAREN RPAREN SEMICOLON
    ;
/*变量块*/
declaration
    : type_specifier declarator SEMICOLON
    | type_specifier assignmenexpression SEMICOLON
    ;
/*参数列表*/
parameter_list
    : parameter_declaration
    | parameter_list COMMA parameter_declaration
    ;
/*参数声明*/
parameter_declaration
    : type_specifier declarator
    ;
/*变量*/
declarator
    : identifier
    | array
    ;
/*函数实现块*/
compound_statement
    : LBRACE RBRACE
    | LBRACE block_item_list RBRACE
    ;
/*C语句块列表*/
block_item_list
    : block_item
    | block_item_list block_item
    ;
/*C语句块
 *分为声明语句和操作语句
 */
block_item
    : declaration
    | statement
    | RETURN arithmetic_expression_list SEMICOLON
    | RETURN conditional_expression_list SEMICOLON
    ;
/*操作语句*/
statement
    : compound_statement
    | expression_statement
    | selection_statement
    | iteration_statement
    ;
/*操作语句：多条语句*/
expression_statement
    : SEMICOLON
    | expression SEMICOLON
    ;
/*
 *操作语句：选择
 *分成两个，以消除偏移/规约冲突
 */
selection_statement
    : IF LPAREN expression RPAREN statement statement
    |   IF LPAREN expression RPAREN statement ELSE statement
    | SWITCH LPAREN expression RPAREN statement
    ;
/*操作语句：迭代循环*/
iteration_statement
    : WHILE LPAREN expression RPAREN statement
    | DO statement WHILE LPAREN expression RPAREN SEMICOLON
    | FOR LPAREN expression_statement expression_statement RPAREN statement
    | FOR LPAREN expression_statement expression_statement expression RPAREN statement
    | FOR LPAREN declaration expression_statement RPAREN statement
    | FOR LPAREN declaration expression_statement expression RPAREN statement
    ;
/*
 *表达式
 *分为条件表达式、赋值表达式、算数表达式
 */
expression
    : conditional_expression_list
    | assignmenexpression
    |   arithmetic_expression_list
    ;
/*赋值表达式*/
assignmenexpression
    :   declarator assignmenoperator expression
    ;
/*
 *算数表达式
 *  拆分成两个，以消除偏移/规约冲突
 */
arithmetic_expression_list
    :   arithmetic_expression_list arithmetic_operator arithmetic_expression
    |   arithmetic_expression_list arithmetic_operator LPAREN arithmetic_expression_list RPAREN 
    |   arithmetic_expression
    |   LPAREN arithmetic_expression_list RPAREN 
    ;
arithmetic_expression
    : value
    | identifier    INC
    | identifier    DEC
    |   ADD identifier
    |   SUB identifier
 /*
  *函数调用
  *特性与算数表达式比较类似
  */
    |   identifier LPAREN RPAREN 
    |   identifier LPAREN value_list RPAREN
    ;
/*传参*/
value_list
    :   value
    | value COMMA value
/*
 *值
 *分为标识符和数字(这里变量只实现数字)
 */
value   
    :   number
    | declarator
    ;
/*
 *条件表达式
 *拆分成两个，以消除偏移/规约冲突
 */
conditional_expression_list
    :   conditional_expression
    |   conditional_expression logical_operator conditional_expression
conditional_expression
    ;
conditional_expression
    :   arithmetic_expression relational_operator arithmetic_expression 
    |   NOT conditional_expression
    ;
/*算数/位运算符*/
arithmetic_operator
    :   ADD
    |   SUB
    |   MUL
    |   QUO
    |   REM
    |   AND
    |   OR
    |   XOR
    |   SHL
    |   SHR
    |   AND_NOT
    ;
/*逻辑运算符*/
logical_operator
    :   LAND
    |   LOR
    ; 
//NOT是单目运算符比较特殊
/*关系运算符*/
relational_operator
    :   EQL
    |   LSS
    |   GTR
    |   NEQ
    |   LEQ
    |   GEQ
    ;
/*赋值符号*/    
assignmenoperator
    : ASSIGN
    |   ADD_ASSIGN
    |   SUB_ASSIGN
    |   MUL_ASSIGN
    |   QUO_ASSIGN
    |   REM_ASSIGN
    |   AND_ASSIGN
    |   OR_ASSIGN
    |   XOR_ASSIGN
    |   SHL_ASSIGN
    |   SHR_ASSIGN
    |   AND_NOASSIGN
    ;
/*类型*/
type_specifier
    : VOID
    | CHAR
    | SHORT
    | INT
    | LONG
    | FLOAT
    | DOUBLE
    | SIGNED
    | UNSIGNED
    ;
%%
main(int argc,char **argv){
        yyparse();
}
yyerror(char *s)
{
    fprintf(stderr,"error: %s\n",s);
}
