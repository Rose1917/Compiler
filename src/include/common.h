#ifndef CMINUS_COMPILER_COMMON_H
#define CMINUS_COMPILER_COMMON_H

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <fstream>
#include <functional>
#include <unordered_map>
#include <string>
#include <iomanip>
#include <regex>
#include "ast.h"
#include "util.h"
#include "symbol.h"
#include "analyze.h"

using namespace std;

// flex 读取文件的行数
extern int row;
extern int column;
extern char *yytext;

// 输入代码文件指针
extern FILE *yyin;

extern int yylex();

int yyparse();


// type_specifier:INT|VOID 的数量
extern int typeSpecifierNum;

// 语法分析之后需要执行的
void executeAfterSyntaxAnalysis();

// 遍历抽象语法树
QuadArg traverseAST(ASTNode *root);

#endif //CMINUS_COMPILER_COMMON_H
