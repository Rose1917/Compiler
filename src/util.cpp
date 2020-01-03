#include "include/common.h"

// 复制字符串
char *stringCopy(const char *str) {
    char *newStr = (char *) malloc(sizeof(char) * strlen(str) + 1);
    strcpy(newStr, str);
    return newStr;
}
/*
int yyerror(const char *message) {
    printf("error at line %d:%d -> %s\n", row, column, message);
    cout << "current token: " << yytext << endl;

    if (strcmp(yytext, "=") == 0) {
        cout << "声明变量不能同时赋值" << endl;
    }
    exit(-1);
}*/

/*
// ASTNode 主类型名字字符串数组
static const char *nodeKindName[] = {
        "Stmt_Node", "Exp_Node", "Decl_Node", "Param_Node", "Type_Node"
};

// 以下是次级类型名字字符串数组
static const char *stmtKindName[] = {
        "Compound_Stmt", "Iteration_Stmt", "Return_Stmt", "Selection_Stmt"
};

static const char *expKindName[] = {
        "Relop_Exp", "Assign_Exp", "Id_Exp", "ArrayId_Exp", "Constant_Exp", "Call_Exp"
};

static const char *declKindName[] = {
        "Fun_Declaration", "Var_Declaration", "Array_Declaration"
};

static const char *valueKindName[] = {
        "INT_Value", "VOID_Value"
};

static const char *paramKindName[] = {
        "Array_Param", "Array_Param"
};

*/
/*
 * 将ast.h中的一系列枚举根据其值返回字符串，用于符号表的输出
 * @param: type 枚举值，ASTNode 的 nodeKind, minorKind
 * @return: 返回枚举值对应的字符串
 *//*

char *typeToChars(int type) {
    // 指针数组，获取字符串要需要经过两级指针
    int *astNodeTypeName[] = {
            (int *) nodeKindName,
            (int *) stmtKindName,
            (int *) expKindName,
            (int *) declKindName,
            (int *) valueKindName,
            (int *) paramKindName
    };
    // 几个枚举类型都是整千开始的
    int nodeMainKindIndex = type / 1000; // 得到主类型枚举次序
    int kindInnerIndex = type % 1000; // 得到次级类型枚举次序
    return (char *) astNodeTypeName[nodeMainKindIndex - 1][kindInnerIndex];
}

// 统计文件行数
int countFileLine(const char *filename) {
    fstream in(filename, ios::in);
    if (!in) {
        cout << "fatal error: file " << filename << " not exists.";
        exit(-1);
    }
    int lineCount = 0;
    string unused;
    while (getline(in, unused)) lineCount++;
    return lineCount;
}*/
