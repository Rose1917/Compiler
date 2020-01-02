/*
 *file: C-lexical-analyzer.l 
 *auther: RenYanjie
 *system: CentOS x86_64
 */
%option yylineno
%{
#include<stdio.h>
extern int yylineno;
%}

/*数字定义*/
/*科学计数表示*/
science {decimal}(\.[0-9]+)?([Ee][-+]?[0-9]+)?
/*十进制*/
decimal ([-+])?(0|[1-9][0-9]*)
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

/*标识符定义*/
identifier [a-z_A-Z][a-z_A-Z0-9]*

/*其它字符*/
comment (\/\/.*)|(\/\*(.|\n)*\/)
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
{AUTO} {printf("Key Word:  %s\n",yytext);}
{BREAK} {printf("Key Word:  %s\n",yytext);}
{CASE} {printf("Key Word:  %s\n",yytext);}
{CHAR} {printf("Key Word:  %s\n",yytext);}
{CONST} {printf("Key Word:  %s\n",yytext);}
{CONTINUE} {printf("Key Word:  %s\n",yytext);}
{DEFAULT} {printf("Key Word:  %s\n",yytext);}
{DO} {printf("Key Word:  %s\n",yytext);}
{DOUBLE} {printf("Key Word:  %s\n",yytext);}
{ELSE} {printf("Key Word:  %s\n",yytext);}
{ENUM} {printf("Key Word:  %s\n",yytext);}
{EXTERN} {printf("Key Word:  %s\n",yytext);}
{FLOAT} {printf("Key Word:  %s\n",yytext);}
{FOR} {printf("Key Word:  %s\n",yytext);}
{GOTO} {printf("Key Word:  %s\n",yytext);}
{IF} {printf("Key Word:  %s\n",yytext);}
{INT} {printf("Key Word:  %s\n",yytext);}
{LONG} {printf("Key Word:  %s\n",yytext);}
{REGISTER} {printf("Key Word:  %s\n",yytext);}
{RETURN} {printf("Key Word:  %s\n",yytext);}
{SHORT} {printf("Key Word:  %s\n",yytext);}
{SIGNED} {printf("Key Word:  %s\n",yytext);}
{SIZEOF} {printf("Key Word:  %s\n",yytext);}
{STATIC} {printf("Key Word:  %s\n",yytext);}
{STRUCT} {printf("Key Word:  %s\n",yytext);}
{SWITCH} {printf("Key Word:  %s\n",yytext);}
{TYPEDEF} {printf("Key Word:  %s\n",yytext);}
{UNSIGNED} {printf("Key Word:  %s\n",yytext);}
{UNION} {printf("Key Word:  %s\n",yytext);}
{VOID} {printf("Key Word:  %s\n",yytext);}
{VOLATILE} {printf("Key Word:  %s\n",yytext);}
{WHILE} {printf("Key Word:  %s\n",yytext);}

 /*提前处理浮点数+uU的异常*/
{floatexcption} {printf("Float Execption: %s\n",yytext);} 
 /*数字表示*/
{number} {printf("Number:  %s\n",yytext);}
 /*异常数字处理*/
{excption} {printf("Number Execption:  %s\n",yytext);}

 /*跳过空白和注释*/
{whitespace} {}
{comment} {printf("This is a commit.\n");}

 /*运算符*/
 /*算术运算符*/
{ADD} {printf("Operator:  %s\n",yytext);}
{SUB} {printf("Operator:  %s\n",yytext);}
{MUL} {printf("Operator:  %s\n",yytext);}
{QUO} {printf("Operator:  %s\n",yytext);}
{REM} {printf("Operator:  %s\n",yytext);}
{INC} {printf("Operator:  %s\n",yytext);}
{DEC} {printf("Operator:  %s\n",yytext);}
 /*逻辑运算符*/
{LAND} {printf("Operator:  %s\n",yytext);}
{LOR} {printf("Operator:  %s\n",yytext);}
{NOT} {printf("Operator:  %s\n",yytext);}
 /*赋值运算符*/
{ASSIGN} {printf("Operator:  %s\n",yytext);}
{ADD_ASSIGN} {printf("Operator:  %s\n",yytext);}
{SUB_ASSIGN} {printf("Operator:  %s\n",yytext);}
{MUL_ASSIGN} {printf("Operator:  %s\n",yytext);}
{QUO_ASSIGN} {printf("Operator:  %s\n",yytext);}
{REM_ASSIGN} {printf("Operator:  %s\n",yytext);}
{AND_ASSIGN} {printf("Operator:  %s\n",yytext);}
{OR_ASSIGN} {printf("Operator:  %s\n",yytext);}
{XOR_ASSIGN} {printf("Operator:  %s\n",yytext);}
{SHL_ASSIGN} {printf("Operator:  %s\n",yytext);}
{SHR_ASSIGN} {printf("Operator:  %s\n",yytext);}
{AND_NOT_ASSIGN} {printf("Operator:  %s\n",yytext);}
 /*位运算符*/
{AND} {printf("Operator:  %s\n",yytext);}
{OR} {printf("Operator:  %s\n",yytext);}
{XOR} {printf("Operator:  %s\n",yytext);}
{SHL} {printf("Operator:  %s\n",yytext);}
{SHR} {printf("Operator:  %s\n",yytext);}
{AND_NOT} {printf("Operator:  %s\n",yytext);}
 /*关系运算符*/
{EQL} {printf("Operator:  %s\n",yytext);}
{LSS} {printf("Operator:  %s\n",yytext);}
{GTR} {printf("Operator:  %s\n",yytext);}
{NEQ} {printf("Operator:  %s\n",yytext);}
{LEQ} {printf("Operator:  %s\n",yytext);}
{GEQ} {printf("Operator:  %s\n",yytext);}
 /*标点符号*/
{LPAREN} {printf("Punctuation:  %s\n",yytext);}
{LBRACK} {printf("Punctuation:  %s\n",yytext);}
{LBRACE} {printf("Punctuation:  %s\n",yytext);}
{COMMA} {printf("Punctuation:  %s\n",yytext);}
{PERIOD} {printf("Punctuation:  %s\n",yytext);}
{RPAREN} {printf("Punctuation:  %s\n",yytext);}
{RBRACK} {printf("Punctuation:  %s\n",yytext);}
{RBRACE} {printf("Punctuation:  %s\n",yytext);}
{SEMICOLON} {printf("Punctuation:  %s\n",yytext);}
{COLON} {printf("Punctuation:  %s\n",yytext);}
{POT} {printf("Punctuation:  %s\n",yytext);}
{DQUA} {printf("Punctuation:  %s\n",yytext);}
{SQUA} {printf("Punctuation:  %s\n",yytext);}


{identifier} {printf("ID:  %s\n",yytext);}
{errno} {printf("On line %d,mystery character:  %s\n",yylineno,yytext);}
%%
int main(int argc,char **argv)
{
	freopen("test1.cpp","r",stdin);
	freopen("LexResult","w",stdout);
        yylineno = 1;
        yylex();
        return 0;
}
int yywarp(){
        return 1;
}
