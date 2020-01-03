#!/bin/bash

if (( $# != 1 ));then 
        echo "输入参数不正确"
        exit 1
fi
bison  -d -o  Parser.c Parser.y
echo "bison 编译完成"
flex -o Lexer.c Lexer.l 
echo "flex编译完成"
gcc -o Parser -w Parser.c Lexer.c -lfl
echo "gcc编译完成"
rm Lexer.c Parser.c Parser.h
echo "正在运行:(没有错误便说明通过)"

./Parser < $1
echo "运行结束"
rm Parser
