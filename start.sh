#!/bin/bash

if (( $# != 1 ));then 
        echo "输入参数不正确"
        exit 1
fi
flex -o C-lexical-analyzer.yy.c C-lexical-analyzer.l 
echo "flex编译完成"
bison -o C-Parser.tab.h C-Parser.y
echo "bison编译完成"
gcc -o C-Parser -w C-Parser.tab.* C-lexical-analyzer.yy.c -lfl
echo "gcc编译完成"
rm C-Parser.tab.* C-lexical-analyzer.yy.c
echo "正在运行:(没有错误便说明通过)"
./C-Parser < $1
echo "运行结束"
rm C-Parser
