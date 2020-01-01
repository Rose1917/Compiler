/*
 *file: C-lexical-analyzer.l
 *auther: Ren Yanjie
 *system: manjaro
 */
%option yylineno
%{
#include<stdio.h>
#include<stdlib.h>
#include"C-Parser.tab.h"
extern int yylineno;
%}
/*数字定义*/
/*科学计数表示*/
science {decimal}(\.[0-9]+)?([Ee][-+]?[0-9]+)?
/*十进制*/
decimal 0|[1-9][0-9]*
/*十六进制*/
hexadecimal 0[xX][a-fA-F0-9]+
/*二进制*/
binary 0[bB][01]+
/*八进制*/
octal 0[0-7]+
/*总表示*/
number ({hexadecimal}|{binary}|{science}|{octal})(([uU]?[Ll]?)|([Ll]?[Uu]?)|([fF]?))
/*注意浮点数总是有符号，不需要Uu后缀，所以在接下来单做一个浮点数异常处理*/
/*数字异常处理*/
floatexcption {decimal}\.[0-9]+([Ee]?[-+]?[0-9]+)?[Uu]
excption [0-9][0-9a-zA-Z\.]+

/*关键字*/
AUTO auto 
BREAK break
CASE case
CHAR char
CONST const
CONTINUE continue
DEFAULT default
DO do
DOUBLE double
ELSE else
ENUM enum
EXTERN extern
FLOAT float
FOR for
GOTO goto
IF if
INT int
LONG long 
REGISTER register
RETURN return
SHORT short
SIGNED signed
SIZEOF sizeof
STATIC static
STRUCT struct
SWITCH switch
TYPEDEF typedef
UNSIGNED unsigned
UNION union
VOID void 
VOLATILE volatile
WHILE while

/*注释*/
COMMENT (\/\/.*)|(\/\*(.|\n)*\/)

/*数组*/
array {identifier}\[(0|([1-9][0-9]*))\]

/*标识符定义*/
identifier [a-z_A-Z][a-z_A-Z0-9]*

/*其它字符*/
whitespace [ \t\n\r\f\v]+
errno .
 
 /*运算符*/
 /*算术运算符*/
ADD  \+
SUB  \-
MUL  \*
QUO  \/
REM  %
INC    \+\+
DEC    \-\-
 /*赋值运算符*/
ASSIGN  =
ADD_ASSIGN  \+=
SUB_ASSIGN  \-=
MUL_ASSIGN  \*=
QUO_ASSIGN  \/=
REM_ASSIGN  %=
AND_ASSIGN  \&=
OR_ASSIGN  \|=
XOR_ASSIGN  \^=
SHL_ASSIGN  <<=
SHR_ASSIGN  >>=
AND_NOT_ASSIGN  ~=
 /*位运算符*/
AND      &
OR       \|
XOR      \^
SHL      <<
SHR      >>
AND_NOT  ~
 /*逻辑运算符*/
LAND   &&
LOR    \|\|
NOT    \!
 /*关系运算符*/
EQL     ==
LSS     <
GTR     >
NEQ       !=
LEQ       <=
GEQ       >=
 /*标点符号*/
LPAREN  \(
LBRACK  \[
LBRACE  \{
COMMA   ,
PERIOD  \.
RPAREN     \)
RBRACK     \]
RBRACE     \}
SEMICOLON  ;
COLON      :
POT         \->
DQUA       \"
SQUA       \'
%%
 
 /*关键字*/
{AUTO} {return AUTO;}
{BREAK} {return BREAK;}
{CASE} {return CASE;}
{CHAR} {return CHAR;}
{CONST} {return CONST;}
{CONTINUE} {return CONTINUE;}
{DEFAULT} {return DEFAULT;}
{DO} {return DO;}
{DOUBLE} {return DOUBLE;}
{ELSE} {return ELSE;}
{ENUM} {return ENUM;}
{EXTERN} {return EXTERN;}
{FLOAT} {return FLOAT;}
{FOR} {return FOR;}
{GOTO} {return GOTO;}
{IF} {return IF;}
{INT} {return INT;}
{LONG} {return LONG;}
{REGISTER} {return REGISTER;}
{RETURN} {return RETURN;}
{SHORT} {return SHORT;}
{SIGNED} {return SIGNED;}
{SIZEOF} {return SIZEOF;}
{STATIC} {return STATIC;}
{STRUCT} {return STRUCT;}
{SWITCH} {return SWITCH;}
{TYPEDEF} {return TYPEDEF;}
{UNSIGNED} {return UNSIGNED;}
{UNION} {return UNION;}
{VOID} {return VOID;}
{VOLATILE} {return VOLATILE;}
{WHILE} {return WHILE;}

 /*提前处理浮点数+uU的异常*/
{floatexcption} {printf("Float Execption: %s\n",yytext);} 
 /*数字表示*/
{number} {return number;}
 /*数组*/
{array} {return array;}
 /*异常数字处理*/
{excption} {printf("Number Execption:  %s\n",yytext);}

 /*跳过空白和注释*/
{whitespace} {}
{COMMENT} {}

 /*运算符*/
 /*算术运算符*/
{ADD} {return ADD;}
{SUB} {return SUB;}
{MUL} {return MUL;}
{QUO} {return QUO;}
{REM} {return REM;}
{INC} {return INC;}
{DEC} {return DEC;}
 /*逻辑运算符*/
{LAND} {return LAND;}
{LOR} {return LOR;}
{NOT} {return NOT;}
 /*赋值运算符*/
{ASSIGN} {return ASSIGN;}
{ADD_ASSIGN} {return ADD_ASSIGN;}
{SUB_ASSIGN} {return SUB_ASSIGN;}
{MUL_ASSIGN} {return MUL_ASSIGN;}
{QUO_ASSIGN} {return QUO_ASSIGN;}
{REM_ASSIGN} {return REM_ASSIGN;}
{AND_ASSIGN} {return AND_ASSIGN;}
{OR_ASSIGN} {return OR_ASSIGN;}
{XOR_ASSIGN} {return XOR_ASSIGN;}
{SHL_ASSIGN} {return SHL_ASSIGN;}
{SHR_ASSIGN} {return SHR_ASSIGN;}
{AND_NOT_ASSIGN} {return AND_NOT_ASSIGN;}
 /*位运算符*/
{AND} {return AND;}
{OR} {return OR;}
{XOR} {return XOR;}
{SHL} {return SHL;}
{SHR} {return SHR;}
{AND_NOT} {return AND_NOT;}
 /*关系运算符*/
{EQL} {return EQL;}
{LSS} {return LSS;}
{GTR} {return GTR;}
{NEQ} {return NEQ;}
{LEQ} {return LEQ;}
{GEQ} {return GEQ;}
 /*标点符号*/
{LPAREN} {return LPAREN;}
{LBRACK} {return LBRACK;}
{LBRACE} {return LBRACE;}
{COMMA} {return COMMA;}
{PERIOD} {return PERIOD;}
{RPAREN} {return RPAREN;}
{RBRACK} {return RBRAEN;}
{RBRACE} {return RBRACE;}
{SEMICOLON} {return SEMICOLON;}
{COLON} {return COLON;}
{POT} {return POT;}
{DQUA} {return DQUA;}
{SQUA} {return SQUA;}


{identifier} {return identifier;}

{errno} {fprintf(stderr,"Mystery character:  %s\n",yytext);}
%%
