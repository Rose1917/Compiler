#!/bin/bash
flex -o C-lexical-analyzer.yy.c token.l 
echo "flex编译完成"
gcc -o C-lexical-analyzer C-lexical-analyzer.yy.c -lfl
echo "gcc编译完成"
rm C-lexical-analyzer.yy.c
echo "正在执行：(Ctrl+D可结束输入)"
./C-lexical-analyzer
rm C-lexical-analyzer
