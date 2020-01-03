#include <vector>

#ifndef CMINUS_COMPILER_ANALYZE_H
#define CMINUS_COMPILER_ANALYZE_H

#define QUAD_TUPLE_CODE_OUTPUT_FILE "output/quad.code"

// 作用域标识，比如函数体里的变量的parentScope是函数名称
extern char *parentScopeName;

void updateParentScopeName(const char *str);

enum QuadArgType {
    VAR,
    TEMP,
    ARRAY
};

struct QuadArg {
    QuadArgType type;
    std::string name;
    std::string addition;
};

// 四元式结构体
typedef struct {
    std::string op;
    QuadArg arg1, arg2, result;
    int jump;// 跳转标号
} Quad;

// 输出四元式
void outputQuadCode();

#endif //CMINUS_COMPILER_ANALYZE_H
