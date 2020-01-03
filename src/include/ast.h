#ifndef CMINUS_COMPILER_AST_H
#define CMINUS_COMPILER_AST_H

// 最大子节点数量
#define MAX_CHILDREN 3

// 树节点类别，主类型
typedef enum {
    Stmt_Node = 1000, Exp_Node, Decl_Node, Param_Node, Type_Node
} NodeKind;
// 以下是次级类型
// 句子类别
typedef enum {
    Compound_Stmt = 2000, Iteration_Stmt, Return_Stmt, Selection_Stmt
} StmtKind;
// 表达式类别
// Additive_Exp 代表加减表达式，Mul_Exp代表乘除表达式
typedef enum {
    Relop_Exp = 3000, Assign_Exp, Id_Exp, ArrayId_Exp, Constant_Exp, Call_Exp, Additive_Exp, Mul_Exp
} ExpKind;
// 声明...
typedef enum {
    Fun_Declaration = 4000, Var_Declaration, Array_Declaration
} DeclKind;
// 类型
typedef enum {
    INT_Value = 5000, VOID_Value, FLOAT_Value
} ValueKind;
// 参数列表的参数类型
typedef enum {
    NotArray_Param = 6000, Array_Param
} ParamKind;

typedef struct {
    int tokenType;
    char *name;
    int size;
} ArrayAttr;

// 抽象语法树节点
typedef struct AST {
    struct AST *children[MAX_CHILDREN]; // 子节点指针数组
    struct AST *sibling; // 兄弟节点链表
    int row; // 对应代码的行号
    int column; // 对应代码的列号
    int mainKind; // 主类型，NodeKind里的，比如 Stmt_Node
    int minorKind;// 次类型，比如 StmtKind 里的 Compound_Stmt

    union {
        int relop;
        float val; // 数值
        char *name;
        ArrayAttr arr;
    } attr;
} ASTNode;

// 新建节点
ASTNode *newNode(int nodeKind, int minorKind);

// 抽象语法树根节点
extern ASTNode *astRoot;

#endif //CMINUS_COMPILER_AST_H
