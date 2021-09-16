//
//  main.swift
//  Stack
//
//  Created by Tocce on 2021/9/13.
//

import Foundation


extension Array where Self.Element == Int {
    func printF() {
        var cString = ""
        for i in self {
            cString = cString + String(i) + " "
        }
        print("====== ", cString)
    }
}


// stack
class CusStack<T> {
    private var stackArr: [T] = []
    
    
    func push(data: T) {
        stackArr.append(data)
    }
    
    func pop() -> T? {
        if stackArr.count == 0 {
            return nil
        }
      return stackArr.removeLast()
    }
    
    func top() -> T {
        return stackArr[stackArr.count - 1]
    }
    
    func length() -> Int {
        
        return stackArr.count
    }
    
    func printF() {
//        var cString = ""
        for i in stackArr {
            print("stack element ==", i)
        }
    }
    
}

//let cusStack = CusStack()
//cusStack.push(data: 1)
//cusStack.push(data: 2)
//cusStack.push(data: 3)
//cusStack.pop()
//cusStack.pop()
//cusStack.pop()
//cusStack.pop()
////let top = cusStack.top()
////print("top ==", top)
//cusStack.printF()


class CusQuene {
    
    private var quene: [Int] = []
    var head: Int = 0
    var trail: Int = 0
    
    func push(data: Int){

        
    }
    
    func pop() {
       
    }
    
    func printF() {
        quene.printF()
    }
}

//let cusQuene = CusQuene()
//cusQuene.push(data: 1)
//cusQuene.push(data: 3)
//cusQuene.push(data: 8)
//cusQuene.push(data: 2)
//cusQuene.pop()
//cusQuene.pop()
//cusQuene.printF()

print("Begin ---")

// symbol
let symbolStr = "[({})]"

func symbolF() -> Bool {
    
    let cusStack = CusStack<String>()
    for i in symbolStr {
        if i == "[" || i == "{" || i == "(" {
            cusStack.push(data: String(i))
        }
        if (String(i) == "]" && cusStack.top() == "[") || (String(i) == "}" && cusStack.top() == "{") ||  (String(i) == ")" && cusStack.top() == "(")  {
            let _ = cusStack.pop()
        }
    }
    
//    cusStack.printF()
    return cusStack.length() == 0
}

let symbolResult = symbolF()

//print("symbolResult ==", symbolResult)


// Decoding String 3[a]2[bc]


class StackObj {
    var num: Int?
    var str: String?
    
    init(num: Int, str: String) {
        self.num = num
        self.str = str
    }
}

let decodString = "3[a]2[bc]"

func decodingString() -> String {
    
    var privateStack: [StackObj] = [StackObj(num: 1, str: "")]
    var num = ""
    for i in decodString {
        if i.isNumber {
            num += String(i)
        } else if i == "[" {
            // 左边
            let stackObj = StackObj(num: Int(num)!, str: "")
            privateStack.append(stackObj)
            num = ""
        } else if i == "]" {
            // 右边
            let lastObj = privateStack.popLast()
            let newLastObj = privateStack.last
            newLastObj?.str = (newLastObj?.str)! + String(repeating: (lastObj?.str)!, count: (lastObj?.num)!)
            
        } else {
            let lastObj = privateStack.last
            lastObj?.str! += String(i)
        }
    }
    
    let lastObj = privateStack.last
    let resultDecode = String(repeating: (lastObj?.str)!, count: (lastObj?.num)!)
        
    return resultDecode
}

//let decodResult = decodingString()
//print("decodResult ==", decodResult)



let parArr: [String] = ["5","2","C","D","+"]
func gameFC(arr: [String]) -> Int {
    
    let cusStack = CusStack<Int>()
     
    var result = 0
    for i in arr {
        if i == "C" {
           let pop = cusStack.pop()
            result -= pop!
        } else if i == "D" {
            let prev = cusStack.top()
            cusStack.push(data: prev * 2)
            result += prev * 2
        } else if i == "+" {
            let prev = cusStack.pop()
            let top = cusStack.top()
            cusStack.push(data: prev!)
            cusStack.push(data: prev! + top)
            result += cusStack.top()
        } else {
            cusStack.push(data: Int(i)!)
            result += cusStack.top()
        }
    }
    
   // 此处 while 循环可省略，将结果计算在上次循环中
//    while cusStack.length() != 0 {
//        let pop = cusStack.pop()
//        result += pop!
//    }
    return result
}

//let gameResult = gameFC(arr: parArr)
//print("gameResult = ", gameResult)

//


func asteroidCollision(_ asteroids: [Int]) -> [Int] {

    var pri_stack: [Int] = []
    for i in asteroids {
//        let top = pri_stack[pri_stack.count - 1]
        if pri_stack.count == 0 ||  (pri_stack[pri_stack.count - 1] < 0) || (pri_stack[pri_stack.count - 1] > 0 && i > 0) {
            pri_stack.append(i)
        } else if ((pri_stack[pri_stack.count - 1] != i && abs(pri_stack[pri_stack.count - 1]) == abs(i))) {
            pri_stack.popLast()
        } else {
            var count = pri_stack.count
            while count != 0 {
                if (pri_stack[pri_stack.count - 1] * i > 0) {
                    pri_stack.append(i)
                    break
                } else if (abs(pri_stack[pri_stack.count - 1]) < abs(i)) {
                    pri_stack.popLast()
                    if pri_stack.count == 0 {
                        pri_stack.append(i)
                    }
                } else if (pri_stack[pri_stack.count - 1] * i < 0 && abs(pri_stack[pri_stack.count - 1]) == abs(i)) {
                    pri_stack.popLast()
                    break
                }
                count -= 1
            }
           
        }
    }
    return pri_stack
}

//var asteroids = [2,-1,1,-2]
//let asteroidResult = asteroidCollision(asteroids)
//print("asteroidResult =", asteroidResult)


// 不带循环
var greatPar = [33, 32, 35, 38, 22]
func nextGreat() -> [(Int, Int)] {
    var stack: [Int] = []
    var result: [(Int, Int)] = []  // 不按顺序的结果
    var index_result: [Int] = Array(repeating: 0, count: greatPar.count) // 按照顺序的结果
    
    for (i, val) in greatPar.enumerated() {
        if stack.count == 0 {
            stack.append(i)
            continue
        }
        var cur_count = stack.count
        while cur_count != 0 {
            if val > greatPar[stack[stack.count - 1]] {
                let pop = stack.popLast()
                result.append((greatPar[pop!], val))
                index_result[pop!] = val
                if stack.count == 0 {
                    stack.append(i)
                }
                
            } else {
                stack.append(i)
            }
            cur_count -= 1
        }
    }
    
    var cur_count = stack.count
    while cur_count != 0 {
        let pop = stack.popLast()
        result.append((greatPar[pop!], -1))
        index_result[pop!] = -1
        cur_count -= 1
    }
    
    
    for i in result {
        print("result --", i)
    }

    return result
}


//let greatResult = nextGreat()
//print("greatResult = ", greatResult)




// 带循环
var c_greatPar = [120,44,49,96,13,74,100,110]
func c_nextGreat() -> [Int] {
    var stack: [Int] = []
    var index_result: [Int] = Array(repeating: -1, count: c_greatPar.count) // 按照顺序的结果
    
    for (i, val) in c_greatPar.enumerated() {
        while let last = stack.last, c_greatPar[last] < val {
                let pop = stack.popLast()
                index_result[pop!] = val
        }
        stack.append(i)
    }
    
    for (_, val) in c_greatPar.enumerated() {
        while let last = stack.last, c_greatPar[last] < val {
                let pop = stack.popLast()
                index_result[pop!] = val
        }
    }
    return index_result
}


let c_greatResult = c_nextGreat()
print("greatResult = ", c_greatResult)

