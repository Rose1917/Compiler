#include "include/common.h"
#include<fstream>
using namespace std;
extern int row;
extern int column;

// 符号表，<hash, Symbol>
std::unordered_map<unsigned int, Symbol *> symbolMap;
// cpp 自带的hash函数
//std::hash<char *> symbolKey;
// hash记录表 <name, hash>
std::unordered_map<string, unsigned int> keyMap;
// 变量名计数器
unsigned declarationCount = 0;

unsigned int symbolKey(char *name) {
    string key = name;
    auto it = keyMap.find(key); // 查找
    if (it == keyMap.end()) { // 没找到，就新插入，返回hash
        keyMap.insert(make_pair(name, declarationCount));
        return declarationCount++;
    } else { // 找到了，返回hash
        return it->second;
    }
}

/*
 * 新增Symbol，在语法分析中是Param_Node，Decl_Node时需要新增Symbol
 */
void insertSymbol(char *name, ASTNode *declarationNode) {
//    cout << "insert symbol: " << name << endl;
    unsigned int key = symbolKey(name);
    // 进行插入
    auto *symbol = (Symbol *) malloc(sizeof(Symbol));
    symbol->name = name;
    symbol->parent = parentScopeName;
    symbol->node = declarationNode;
    symbol->row = row;
    symbol->column = column;
    symbolMap.insert(make_pair(key, symbol));
}

/*
 * 查找符号表
 */
Symbol *searchSymbol(char *name) {
    unsigned int key = symbolKey(name);
    auto it = symbolMap.find(key);
    if (it != symbolMap.end()) { // 找到了返回符号表结构体指针
        return it->second;
    } else { // 没找到返回空指针
        return nullptr;
    }
}

//删除指定表项
void deleteSymbol(char *name) {
    cout << "delete symbol: " << name << endl;
    unsigned int key = symbolKey(name);
    // 进行删除
    symbolMap.erase(key);
}


// 打印输出符号表
void outputSymbolTable() {
    fstream output;
    output.open(SYMBOL_TABLE_OUTPUT_FILE, ios::out);
    if (!output) {
        cout << "符号表输出文件创建失败" << endl;
        exit(-1);
    }
    output << left;// 左对齐
    output << setw(12) << "Name" << setw(12) << "Parent" << setw(12) << setw(24) << "Type" << setw(12) << "Is Array"
           << setw(12) << "Array Size" << setw(12) << "Row" << setw(12) << "Column" << endl;

    // 遍历所有符号
    for (auto &it:symbolMap) {
        Symbol *s = it.second;
        output << "------------------------------------------------------------------------------------------" << endl;
        output << setw(12) << s->name << setw(12) << s->parent;
        string type;
        ASTNode *typeSpecifier = s->node->children[0];
        switch (typeSpecifier->minorKind) {
            case INT_Value:
                type = "int ";
                break;
            case FLOAT_Value:
                type = "float ";
                break;
            case VOID_Value:
                type = "void ";
        }
        switch (s->node->minorKind) {
            case Fun_Declaration:
                type += "function";
                break;
            case NotArray_Param:
            case Var_Declaration:
                type += "variable";
                break;
            case Array_Declaration:
            case Array_Param:
                type += "array variable";
                break;
        }
        output << setw(24) << type;
        if (s->node->minorKind == Array_Param || s->node->minorKind == Array_Declaration) {
            output << setw(12) << "yes";
        } else {
            output << setw(12) << "no";
        }
        int size = 0;
        if (s->node->minorKind == Array_Declaration) {
            size = s->node->attr.arr.size;
        }
        output << setw(12) << (size == 0 ? "-" : to_string(size));
        output << setw(12) << s->row << setw(12) << s->column << endl;
    }
    output.close();
}
