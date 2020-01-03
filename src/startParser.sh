#!/bin/bash

if (( $# != 1 ));then 
        echo "输入参数不正确"
        exit 1
fi
bison  -vdty -o  Parser.c Parser.y
echo "bison 编译完成"
flex -o Lexer.c Lexer.l 
echo "flex编译完成"
g++ -std=c++11 -Wall -o Parser -w Parser.c Lexer.c ast.cpp symbol.cpp util.cpp -lfl
echo "gcc编译完成"

rm Lexer.c Parser.c Parser.h Parser.output y.output y.tab.cpp
echo "正在运行:(没有错误便说明通过)"

./Parser < $1
echo "运行结束"
rm Parser
