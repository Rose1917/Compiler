//
// Created by SUDOCS on 2019/12/8.
//

#ifndef CMINUS_COMPILER_SYMBOL_H
#define CMINUS_COMPILER_SYMBOL_H
#include<unordered_map>

// 符号表输出文件名
#define SYMBOL_TABLE_OUTPUT_FILE "output/symbol.table"
typedef struct {
    char *name;// 标识符名字
    char *parent;//
    ASTNode *node;
    int row;
    int column;
} Symbol, *SymbolTable;
// 符号表

extern std::unordered_map<unsigned int, Symbol *> symbolMap;

// 新增
void insertSymbol(char *name, ASTNode *declarationNode);

// 查找
Symbol *searchSymbol(char *name);

// 删除
void deleteSymbol(char *name);

// 打印符号表
void outputSymbolTable();

#endif //CMINUS_COMPILER_SYMBOL_H
