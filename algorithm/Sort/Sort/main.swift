//
//  main.swift
//  Sort
//
//  Created by Tocce on 2021/9/6.
//

import Foundation

print("Hello, World!")

var lst: [String] = []
var resultData: [[String]] = []

func subset(data: [String]) {
   
    subset_helper(nums: data, pos: 0)
}

func subset_helper(nums:[String], pos: Int)  {
    
    resultData.append(lst)
    for i in pos ..< nums.count {
        lst.append(nums[i])
        subset_helper(nums: nums, pos: i + 1)
        lst.removeLast()
    }
}
var datas = ["a", "b", "c"]
subset(data: datas)
print("resultData ==", resultData)

// 二分

func br_sort(datas:[Int], target: Int) -> Int {
    
    var left = 0
    var right = datas.count - 1
    var middle = 0
    while left <= right {
        middle = left + (right - left) / 2
        let value = datas[middle]
        if value < target {
            left = middle + 1
        } else if (value > target) {
            right = middle - 1
        } else if value == target {
            return middle
        }
    }
    return -1
}

var br = br_sort(datas: [1, 3, 5, 9, 12, 15, 18, 20, 22], target: 23)
print("br ====== \(br)")


// 插入
var in_datas = [1, 20, 8, 3, 10, 1, 7, 2]
func inserSort() {
    for i in 0 ..< in_datas.count {
        for j in 0 ..< i {
            if in_datas[j] > in_datas[i] {
                let temp = in_datas[j]
                in_datas[j] = in_datas[i]
                in_datas[i] = temp
            }
        }
    }
}
//inserSort()
//print("插入 ==== \(in_datas)")

// var in_datas = [1, 20, 8, 3, 10, 1, 7, 2]
// 选择 降序
func selectSort() {
   var maxIndex = 0
   var maxValue = 0
    for i in 0 ..< in_datas.count {
        maxIndex = i
        maxValue = in_datas[maxIndex]
        for j in (i + 1) ..< in_datas.count {
            if maxValue < in_datas[j] {
                maxValue = in_datas[j]
                maxIndex = j
            }
        }
        
        if(maxIndex != i){
            let temp = in_datas[maxIndex]
            in_datas[maxIndex] = in_datas[i]
            in_datas[i] = temp
        }
//        print(in_datas)
    }

}

// var in_datas = [1, 20, 8, 3, 10, 7, 2]
// 升序
//func selectSort() {
//
//    var minIndex = 0
//    var minValue = 0
//    for i in 0 ..< in_datas.count {
//        minIndex = i
//        minValue = in_datas[i]
//        for j in (i + 1) ..< in_datas.count {
//            if (in_datas[j] < minValue) {
//                minIndex = j
//                minValue = in_datas[j]
//            }
//        }
//        if minIndex != i {
//            let temp = in_datas[minIndex]
//            in_datas[minIndex] = in_datas[i]
//            in_datas[i] = temp
//        }
//    }
//}

//selectSort()
//print("选择 ==== \(in_datas)")

// 计数排序(桶排序)


var count_datas = [1, 20, 8, 3, 10, 1, 7, 2]

func countSort() {
    
    var max: Int = 0
    var min: Int = count_datas.first!
    for i in count_datas {
        if min > i {
            min = i
        }
        
        if max < i {
            max = i
        }
    }
    
    let count = max - min + 1
    var allArr: [Int] = Array(repeating: 0, count: count)
    var idx = 0
    for i in count_datas {
        allArr[i - min] += 1
    }
    print(allArr)
    for (i, _) in allArr.enumerated() {
        while allArr[i] > 0 {
            count_datas[idx] = i + min
            idx += 1
            allArr[i] -= 1
        }
    }
}

//countSort()
//print(count_datas)

// 归并

var merge_datas = [1, 20, 8, 3, 10, 1, 7, 2]

func mergeSort(arr: [Int]) -> [Int] {
   
    print("mergeSort ==", arr)
    if arr.count <= 1 {
        return arr
    }
    let mid = arr.count / 2

    let firstArr = mergeSort(arr: Array(arr[0 ..< mid]))
    let secondArr = mergeSort(arr: Array(arr[mid ..< arr.count]))

    let mergeData = merage(data1: firstArr, data2: secondArr)
    return mergeData
}

func merage(data1: [Int], data2: [Int]) -> [Int] {
    print(data1, data2)
    var i = 0
    var j = 0
    var k = 0
    let p = data1.count
    let q = data2.count
    var arr = Array(repeating: 0, count: p+q)
    
    while i < p, j < q {
        if data1[i] <= data2[j] {
            arr[k] = data1[i]
            i += 1
            k += 1
        } else {
            arr[k] = data2[j]
            j += 1
            k += 1
        }
    }
    
    while i < p {
        arr[k] = data1[i]
        i += 1
        k += 1
    }
    
    while j < q {
        arr[k] = data2[j]
        j += 1
        k += 1
    }
    return arr
}


//let mergedData = mergeSort(arr: merge_datas)
//print("========= ", mergedData)


// 快速排序
//func quickSort(quickData: inout [Int]) -> [Int] {
//
//    if quickData.count > 1 {
//        let s = quickSortHelper(currentData: &quickData)
//        print(s, quickData)
//
//        var leftArr = Array(quickData[0..<s])
//        var rightArr = Array(quickData[s..<quickData.count])
//        quickData.replaceSubrange(0 ..< s, with: quickSort(quickData: &leftArr))
//        quickData.replaceSubrange(s ..< quickData.count, with: quickSort(quickData: &rightArr))
//
//    }
//    return quickData
//}
//func quickSortHelper(currentData: inout [Int]) -> Int {
//
////    var currentData = array
//
//    let l = 0
//    let i = l + 1
//    var s = l
//    for idx in i ..< currentData.count {
//        if currentData[idx] < currentData[l] {
//            s += 1
//            let temp = currentData[idx]
//            currentData[idx] = currentData[s]
//            currentData[s] = temp
//        }
//    }
//
//    let l_temp = currentData[s]
//    currentData[s] = currentData[l]
//    currentData[l] = l_temp
//
//
//    return s
//}
//
//var quick_datas = [5, 20, 8, 3, 6, 1, 7, 2]
//
//print("end ===", quick_datas)
//// 5 3. 8 20. 6 1  7 2
//// 5 3  1. 20 6 8. 7 2
//// 5 3  1. 2. 6 8  7 20
//// 2 3  1  5  6 8  7 20
//
//
//
//let arr = quickSort(quickData: &quick_datas)
//
//print("quick_data == ", arr)




// power action
func powerFC(a: Int, n: Int) -> Int {
    
    if a == 0 {
        return 0
    }
    
    if n == 0 {
        return 1
    }
    
    if n % 2 == 0 {
        let odd = powerFC(a: a * a, n: n / 2)
        return odd
    } else {
        let evv = powerFC(a: a * a, n: n / 2) * a
        return evv
    }
}

let result = powerFC(a: 2, n: 4)
print("powerFC result ==", result)


var mon_datas = [-1, 5, 6, 8, 9, 1, 2, 7, -1]

func monAction() -> Int {
    var l = 0
    var r = mon_datas.count - 1
    var middle = 0
    while l + 1 < r {
        middle = l + (r - l) / 2
        if mon_datas[middle] > mon_datas[middle - 1], mon_datas[middle] > mon_datas[middle + 1] {
            return middle
        }
        
        if mon_datas[middle] > mon_datas[middle - 1], mon_datas[middle] < mon_datas[middle + 1] {
            l = middle - 1
        }
        
        if mon_datas[middle] < mon_datas[middle - 1], mon_datas[middle] > mon_datas[middle + 1] {
            r = middle + 1
        }
        
        if mon_datas[middle] < mon_datas[middle - 1], mon_datas[middle] < mon_datas[middle + 1] {
            r = middle + 1
        }
    }
    
    return -1
}

let idx = monAction()
print("idx= == ", idx)


var firstArr = [3, 5, 5, 8, 5, 2, 4]
var secondArr = [5, 8, 5, 6]

func inserCollection(data1: [Int], data2: [Int]) -> [Int] {
    
    var i = 0
    var j = 0
    var result: [Int] = []
    let localData = data1.count > data2.count ? data1 : data2
    
    for (_, val) in localData.enumerated() {
        if j < secondArr.count, data1[i] == data2[j] {
            result.append(val)
            i += 1
            j += 1
        } else {
            i += 1
        }
    }
    return result
}

let inserArr = inserCollection(data1: firstArr, data2: secondArr)
print("inserArr ==", inserArr)


