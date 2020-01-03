#ifndef CMINUS_COMPILER_UTIL_H
#define CMINUS_COMPILER_UTIL_H

int yyerror(const char *message);

char *stringCopy(const char *str);

/*// 将ast.h中的一系列枚举根据其值返回字符串
char *typeToChars(int type);

int countFileLine(const char *filename);*/

#endif //CMINUS_COMPILER_UTIL_H
