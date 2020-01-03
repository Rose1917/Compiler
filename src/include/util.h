#ifndef CMINUS_COMPILER_UTIL_H
#define CMINUS_COMPILER_UTIL_H

/*
int yyerror(const char *message){
    printf("error at line %d:%d -> %s\n", row, column, message);
    cout << "current token: " << yytext << endl;

    if (strcmp(yytext, "=") == 0) {
        cout << "声明变量不能同时赋值" << endl;
    }
    exit(-1);

}

*/
char *stringCopy(const char *str);
/*
// 将ast.h中的一系列枚举根据其值返回字符串
char *typeToChars(int type);

int countFileLine(const char *filename);
*/
#endif //CMINUS_COMPILER_UTIL_H
