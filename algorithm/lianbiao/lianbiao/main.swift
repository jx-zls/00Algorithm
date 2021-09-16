//
//  main.swift
//  lianbiao
//
//  Created by Tocce on 2021/9/10.
//

import Foundation

print("Hello, World!")

class Node {
    var value: Int?
    var next: Node?
    
    init(value:Int?, next:Node?) {
        self.value = value
        self.next = next
    }
    
    convenience init(currentValue: Int? = -1) {
        
        self.init(value:currentValue, next: nil)
    }
    
}

class NodeList {
    
    var size: Int = 0
    var headNode: Node = Node()
    
    // 头部添加
    func addFirst(value: Int) {
        let node = Node(currentValue: value)
        node.next = headNode.next
        headNode.next = node
        size += 1
    }

    // 末尾添加
    func addLast(value: Int) {
        
        let node = Node(currentValue: value)
        var newHeadNode = headNode
        while newHeadNode.next != nil {
            newHeadNode = newHeadNode.next!
        }
        newHeadNode.next = node
        size += 1
    }
    
    // 任意位置添加，如果位置小于0、大于最大长度直接在最前或者最后添加
    func insertAt(value: Int, idx: Int) {
       
        if idx <= 0 {
            addFirst(value: value)
            return
        }
        
        if idx >= size {
            addLast(value: value)
            return
        }
        
        let node = Node(currentValue: value)
        var newHeadNode = headNode
        var index = 0

        
        while idx != index {
            newHeadNode = newHeadNode.next!
            index += 1
        }
        
        node.next = newHeadNode.next
        newHeadNode.next = node
        size += 1
    }
    
    // 返回链表长度
    func length() -> Int {

        return size
    }
    
    // 打印当前链表的值
    func printList() {
        var node: Node = headNode
        var resutlt_string = ""
        while node.next != nil {
            node = node.next!
            resutlt_string = resutlt_string + " " + String(node.value!)
        }
       print("printList ==== ", resutlt_string)
    }
    
    // 打印当前链表的值
    func printListP(currentNode: Node) {
        var node: Node = currentNode
        var resutlt_string = String(node.value!)
        while node.next != nil {
            node = node.next!
            resutlt_string = resutlt_string + " " + String(node.value!)
        }
       print("printList ==== ", resutlt_string)
    }
    
    
    // 删除头部
    func removeFirst() {
        
        headNode.next = headNode.next?.next
        size -= 1
        
        
    }
    
    // 删除尾部
    func removeLast() {
        
        var newHeadNode = headNode
        while newHeadNode.next?.next != nil {
            
            newHeadNode = (newHeadNode.next)!
        }
        
        newHeadNode.next = nil
        size -= 1
    }
    
    // 删除任意位置
    
    func removeAt(idx: Int)  {
        
        if idx <= 0 {
            removeFirst()
            return
        }
        if idx >= size {
            removeLast()
            return
        }
        
        var newHeadNode = headNode
        var index = 0
        while idx != index {
            newHeadNode = newHeadNode.next!
            index += 1
        }
        newHeadNode.next = newHeadNode.next?.next
        size -= 1
    }
}

let nodeObj = NodeList()
//nodeObj.addFirst(value: 10)
//nodeObj.addFirst(value: 12)
//nodeObj.addFirst(value: 14)


//nodeObj.addLast(value: 1)
nodeObj.addLast(value: 1)
nodeObj.addLast(value: 2)
nodeObj.addLast(value: 3)
//nodeObj.addLast(value: 13)
//nodeObj.addLast(value: 14)
//nodeObj.addLast(value: 12)
//nodeObj.addLast(value: 18)
//nodeObj.addLast(value: 12)

print("===== 插入前")
//nodeObj.printList()

//nodeObj.insertAt(value: 5, idx: 10)

//print("======= 插入后")
//print("length ===== ", nodeObj.length())
//nodeObj.printList()

// 删除操作
//print("======= 删除操作")
//nodeObj.removeFirst()
//nodeObj.removeLast()
//nodeObj.removeLast()
//nodeObj.removeAt(idx: 4)

//nodeObj.printList()

print("length ===== ", nodeObj.length())

// 判断是否有环
func isHaveLoop(nodeObj: NodeList?) -> Bool {
    
    var fast = nodeObj?.headNode
    var slow = nodeObj?.headNode
    
    while fast != nil, fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
        if fast?.value == slow?.value {
            return true
        }
    }
    
    return false
    
}

//let haveLoop = isHaveLoop(nodeObj: nodeObj)
//print("haveLoop ==", haveLoop)

// 判断中间位置

func isMiddleNode(node: NodeList?) -> Node {
    var slow = node?.headNode
    var fast = node?.headNode

    while let curNode = fast, let tmpNode = curNode.next {
        slow = slow?.next
        fast = tmpNode.next
    }
    return slow!
}

//let middleNode = isMiddleNode(node: nodeObj)
//print("end ===", middleNode.value!)


// 删除倒数第N个节点
func deleteNode( nodeList: NodeList?, k: Int) {
    var step =  k - 1
    let head = nodeList?.headNode
    var newNode = head
    var deleteNode = head
    while let _ = newNode?.next  {
        if step >= 0 {
            newNode = newNode?.next
            step -= 1
        }else{
            newNode = newNode?.next
            deleteNode = deleteNode?.next
        }
    }
    
    if deleteNode != nil {
        deleteNode?.next = nil
    }
}
//nodeObj.printList()
//deleteNode(nodeList: nodeObj, k: 1)
//nodeObj.printList()
print("separateTabel == \n")


// 分半链表
func separateTabel(nodeList: NodeList?) -> Node {
    
    // 找到中间位置
    var slow = nodeList?.headNode
    var fast = nodeList?.headNode
    let newHeadNode: Node = Node()
    while let cur_node = fast, let cur_next_node = cur_node.next  {
        fast = cur_next_node.next
        slow = slow?.next
    }
    newHeadNode.next = slow?.next
    slow?.next = nil
    
    return newHeadNode
}

//let sepatateResult = separateTabel(nodeList: nodeObj)
//nodeObj.printListP(currentNode: nodeObj.headNode)
//nodeObj.printListP(currentNode: sepatateResult)



//// 反转
func reversalTable(nodeList: NodeList?) -> Node {

    if nodeList?.headNode == nil {
        return nodeList!.headNode
    }
    var current = nodeList?.headNode.next
    var prev: Node? = nil

    while current != nil {
        let temp = current?.next
        current?.next = prev
        prev = current
        current = temp
        print("==== ", current?.value, prev?.value)
        
    }
    return prev!
}

//nodeObj.printListP(currentNode: nodeObj.headNode.next!)
//let reversalResult = reversalTable(nodeList: nodeObj)
//nodeObj.printListP(currentNode: reversalResult)


print("============= sort \n")

// 排序
func sortTable(headNode: Node?) -> Node? {
    
    if headNode == nil {
        return headNode
    }
    
    if headNode == nil || headNode!.next == nil {
        return headNode
    }
    
    var slow = headNode
    var fast = headNode?.next
    while fast != nil, fast?.next != nil{
        slow = slow?.next
        fast = fast?.next?.next
    }
    let last = slow?.next
    slow?.next = nil
    
    let frontList = sortTable(headNode: headNode)
    let lastList = sortTable(headNode: last)
    let result = mergeList(leftNode: frontList!, rightNode: lastList!)
    
    return result
}



func mergeList(leftNode: Node, rightNode: Node) -> Node {
    var left: Node? = leftNode
    var right:Node? = rightNode
    
    let headNode: Node = Node(currentValue: -1)
    var trailNode = headNode
    while left != nil, right != nil {
        if (left?.value)! >= (right?.value)! {
            trailNode.next = left
            left = left?.next
            trailNode = trailNode.next!
        }else{
            trailNode.next = right
            right = right?.next
            trailNode = trailNode.next!
        }
    }
    
    trailNode.next = left != nil ? left : right
    
    
    return headNode.next!
}

//nodeObj.printListP(currentNode: nodeObj.headNode.next!)
//let sortResult = sortTable(headNode: nodeObj.headNode.next)
//nodeObj.printListP(currentNode: sortResult!)

// 合并

 public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 }

class Solution {
    
    // [1,2,3]  2
    func splitListToParts(_ head: ListNode?, _ k: Int) -> [ListNode?] {
              if head == nil {
                   return [head]
               }
               var result: [ListNode?] = []
               var n = 0
               var currentHead = head
               while currentHead != nil {
                   n += 1
                   currentHead = currentHead?.next
               }
               
               var count = 0
               currentHead = head
               var pre: ListNode? = currentHead!
               if n <= k {
                   while count != k {
                       if currentHead != nil {
                           result.append(ListNode(currentHead!.val))
                           currentHead = currentHead?.next
                       } else {
                           result.append(nil)
                       }
                       count += 1
                   }
                   return result
               }
               count = n % k
               var sum = count
               var c_count = 1
               pre = ListNode()
        
               while currentHead != nil {
                    pre?.next = currentHead
                    pre?.val = (currentHead?.val)!
                    currentHead = currentHead?.next
                     if sum != 0 {
                         c_count += 1
                         if c_count == k {
                            pre?.next = nil
                            result.append(pre?.next)
                             pre = ListNode()
                             sum -= 1
                             c_count = 1
                         }
                        
                     } else {
                         if c_count == k - 1 {
                              result.append(pre?.next)
                              pre?.next = nil
                              pre = ListNode()
                             c_count += 1
                         }
                     }
                 }
           
               return result
    }
    
    
    // 合并链表
    func mergeKLists(_ lists: [ListNode?]) -> ListNode? {
        
        if lists.count == 1 {
            return lists[0]
        }
        
        
//        if lists.count <= 0 {
//            return nil
//        }
//
//        var head = lists[0]
//        for i in 1 ..< lists.count {
//          head = mergeNode(leftNode: head, rightNode: lists[i])
//        }
//
//        return head
//        return nil
       
        let middle = lists.count / 2
        
        let leftArr = mergeKLists(Array(lists[0 ..< middle]))
        let rightArr = mergeKLists(Array(lists[ middle ..< lists.count]))
        let result = mergeNode(leftNode: leftArr, rightNode: rightArr)
        return result
        
    }
    
    func mergeNode(leftNode: ListNode?, rightNode: ListNode?) -> ListNode? {
       
        if leftNode == nil, rightNode == nil {
            return leftNode
        }
        if leftNode == nil {
            return rightNode!
        }
        if rightNode == nil {
            return leftNode!
        }
        var left: ListNode? = leftNode
        var right:ListNode? = rightNode

        let headNode: ListNode = ListNode()
        var trailNode = headNode
        while left != nil, right != nil {
            if (left?.val)! <= (right?.val)! {
                trailNode.next = left
                left = left?.next
                trailNode = trailNode.next!
            }else{
                trailNode.next = right
                right = right?.next
                trailNode = trailNode.next!
            }
        }

        trailNode.next = left != nil ? left : right


        return headNode.next!
    }

}
