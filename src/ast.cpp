#include "include/common.h"

// 开辟节点
ASTNode *newNode(int nodeKind, int minorKind) {
    int i = 0;
    ASTNode* node = (ASTNode *) malloc(sizeof(ASTNode));
    // 把孩子节点全指向NULL
    //for (auto &i : node->children) i = NULL;
    // 兄弟节点指向NULL
    for(i = 0; i < 3; i++){
        node->children[i] = NULL;
    }
    node->sibling = NULL;
    node->mainKind = nodeKind;
    node->minorKind = minorKind;
    node->row = row;
//    node->identifierIndex = 0;
    return node;
}
