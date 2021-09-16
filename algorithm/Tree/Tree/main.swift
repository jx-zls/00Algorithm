//
//  main.swift
//  Tree
//
//  Created by Tocce on 2021/9/15.
//

import Foundation

print("Hello, World!")

class TreeNode {
    
    var val: Int?
    var leftNode: TreeNode?
    var rightNode: TreeNode?
    
 
    
    init(val: Int, left:TreeNode?, right:TreeNode?) {
        self.val = val
        self.leftNode = left
        self.rightNode = right
    }
    
    convenience init(val: Int) {
        self.init(val: val, left: nil, right: nil)
    }
}
//
class Tree {
    var root: TreeNode?
    
    // 添加
    func add(value: Int) {
           root = addHelper(node: root, val: value)
    }
    
    private func addHelper(node: TreeNode?, val: Int) -> TreeNode {
        
        if node == nil {
           return TreeNode(val: val)
        }
        
        if (node?.val)! < val {
            node?.rightNode = addHelper(node: node?.rightNode, val: val)
        }
        
        if (node?.val)! > val {
            node?.leftNode = addHelper(node: node?.leftNode, val: val)
        }
        
        return node!
    }
    
    // 删除
    func remove(value: Int) {
        
        root = removeHelper(node: root, val: value)
    }
    
    private func removeHelper(node: TreeNode?, val: Int) -> TreeNode? {
        var cur_node = node
        if cur_node == nil {
            return nil
        }
        
        if (cur_node?.val)! > val {
            cur_node?.leftNode = removeHelper(node: cur_node?.leftNode, val: val)
        }
        
        if (cur_node?.val)! < val {
            cur_node?.rightNode = removeHelper(node: cur_node?.rightNode, val: val)
        }
        
        if (cur_node?.val)! == val  {
            if cur_node?.leftNode == nil {
                cur_node = cur_node?.rightNode
            } else if cur_node?.rightNode == nil {
                cur_node = cur_node?.leftNode
            } else if cur_node?.leftNode != nil, cur_node?.rightNode != nil {
                cur_node?.val = getMax(node: cur_node?.leftNode)
                node?.leftNode = removeHelper(node: cur_node?.leftNode, val: (cur_node?.val)!)
                
            }
        }
        return cur_node
    }
    
    // 查询
    func getValue(value: Int) -> Int? {
        
        return getValueHelper(node: root, val: value)
    }
    
    private func getValueHelper(node: TreeNode?, val: Int) -> Int? {
        
        if node == nil {
            return nil
        }
        if node?.val == val {
            return node?.val
        }
        
        if (node?.val)! > val {
           return getValueHelper(node: node?.leftNode, val: val)
        } else {
            return getValueHelper(node: node?.rightNode, val: val)
        }
    }
    
    
    // 查最大值
    func getMax(node: TreeNode?) -> Int {
        var cur_node = node
        if node == nil {
            return -1
        }
        
        while cur_node?.rightNode != nil {
            cur_node = cur_node?.rightNode
        }
        return (cur_node?.val)!
    }
    
    func prevTree(node: TreeNode?) -> [Int] {
        var result: [Int] = []
        if node == nil {
            return []
        }
        
        result.append((node?.val)!)
        result += prevTree(node: node?.leftNode)
        result += prevTree(node: node?.rightNode)
        return result
    }
    
    
    func getSize(node: TreeNode?) -> Int {
        
        if node == nil {
            return 0
        }
        return 1 + getSize(node: node?.leftNode) + getSize(node: node?.rightNode)
    }
    
    func getMaxDepth(node: TreeNode?) -> Int {
        
        if node == nil {
            return 0
        }
        let left_depth = getMaxDepth(node: node?.leftNode)
        let right_depth = getMaxDepth(node: node?.rightNode)
        
        return max(left_depth, right_depth) + 1
        
    }
}


var arr = [5, 4, 3, 6]
let treeObj = Tree()
for i in arr {
    // 增
    treeObj.add(value: i)
}

let size = treeObj.getSize(node: treeObj.root)
print("size ==", size)

// 删
//treeObj.remove(value: 8)

// 查
let getResult = treeObj.getValue(value: 8)

print("getResult -- ", getResult as Any)
let printResult = treeObj.prevTree(node: treeObj.root)
print(" printResult ==  ", printResult)

let maxDepth = treeObj.getMaxDepth(node: treeObj.root)
print("maxDepth ==", maxDepth)

print(" ======== end")


// 前序遍历
// 根 -> 左 -> 右
// 递归实现
func prevTree(node:TreeNode?) -> [Int]{
    
    if node == nil {
        return []
    }
    var result: [Int] = []
    result.append(node!.val!)
    result += prevTree(node: node?.leftNode!)
    result += prevTree(node: node?.rightNode!)
    
    return result
}
// 遍历实现
func prevTree_2(node: TreeNode?) -> [Int] {
    
    var result: [Int] = []
    var nodeArr: [TreeNode] = []
    if node == nil {
        return result
    }

    while nodeArr.count != 0 {
        let popNode = nodeArr.popLast()
        result.append((popNode?.val)!)
        
        if popNode?.leftNode != nil {
            nodeArr.append((popNode?.leftNode)!)
        }
        
        if popNode?.rightNode != nil {
            nodeArr.append((popNode?.rightNode)!)
        }

    }
    
    return [0]
}


// 顺序 左 -> 根 -> 右
func inorderTree(node: TreeNode?) -> [Int] {
    if node == nil {
        return []
    }
    
    var result: [Int] = []
    result += inorderTree(node: node?.leftNode)
    result.append(node!.val!)
    result += inorderTree(node: node?.rightNode)
    return result
}

// 后序遍历 左 -> 右 -> 根
func postTree(node: TreeNode?) -> [Int] {
    
    var result: [Int] = []
    if node == nil {
        return result
    }
    result += postTree(node: node?.leftNode)
    result += postTree(node: node?.rightNode)
    result.append(node!.val!)
    return result
}

// 判断是否平衡
func isBalanced(root: TreeNode?) -> Bool {
    
    if root == nil {
        return true
    }
    return abs(nodeHeight(node: root?.leftNode)) - abs(nodeHeight(node: root?.rightNode)) <= 1 && isBalanced(root: root?.leftNode) && isBalanced(root: root?.rightNode)
    
}

private func nodeHeight(node: TreeNode?) -> Int {

    if node == nil {
        return 0
    }

    let left = nodeHeight(node: node?.leftNode)
    let right = nodeHeight(node: node?.rightNode)

    return max(left, right) + 1
}

// 最小深度
func minDepth(node: TreeNode?) -> Int {
    
    if node == nil {
        return 0
    }
    
    if node?.leftNode == nil {
        return minDepth(node: node?.rightNode)
    }
    if node?.rightNode == nil {
        return minDepth(node: node?.leftNode)
    }
    return min(minDepth(node: node?.leftNode), minDepth(node: node?.rightNode)) + 1
}

// 对称镜像 [1,2,2,3,4,4,2]
func isSymmetric(_ root: TreeNode?) -> Bool {
    
    return isCheck(leftNode: root, rightNode: root)
}

func isCheck(leftNode: TreeNode?, rightNode: TreeNode?) -> Bool {
    
    if leftNode == nil, rightNode == nil {
        
        return true
    }
    
    if leftNode?.val == rightNode?.val && isCheck(leftNode: leftNode?.leftNode, rightNode: rightNode?.rightNode) && isCheck(leftNode: leftNode?.rightNode, rightNode: rightNode?.leftNode) {
       
        return true
        
    } else {
        
        return false
    }
}

// 翻转
func invertTree(_ root: TreeNode?) -> TreeNode? {
    
    if root == nil {
        return nil
    }
    
    let leftNode  = invertTree(root?.leftNode)
    let rightNode = invertTree(root?.rightNode)
    
    root?.leftNode = rightNode
    root?.rightNode = leftNode
    return root
}
