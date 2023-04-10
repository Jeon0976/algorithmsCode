////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//
//
//import Foundation
///// 내가 푼 방식은 각 각의 원소를 나눠서  각 각의 배열을 만들어서 다 일일히 계산했다.
///// 생각보다 높은 숫자가 나왔을 때 시간이 오래걸림
//func binary_search(_ array:[Int], _ target:Int,_ start:Int,_ end:Int) -> Int {
//    if start > end {
//        return 0
//    }
//    let mid = (start + end) / 2
//
//    if array[mid] == target {
//        return 1
//    } else if array[mid] > target {
//        return binary_search(array, target, start, mid - 1)
//    } else {
//        return binary_search(array, target, mid + 1, end)
//    }
//}
//
//
//let line = readLine()
//
//var n = 0
//var m = 0
//
//if let line = line {
//    let array = line.components(separatedBy: " ").map { Int($0)! }
//    n = array[0]
//    m = array[1]
//}
//
//let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//var riceCakeArray = [[Int]](repeating: [Int](), count: n)
//
//for i in 0..<n {
//    for j in 1...array[i] {
//        riceCakeArray[i].append(j)
//    }
//}
//
//var riceValue = array.max()!
//
//var customerNeed = 0
//
//while customerNeed < m {
//    for cake in riceCakeArray {
//        customerNeed += binary_search(cake, riceValue, 0, cake.count-1)
//    }
//    riceValue -= 1
//}
//
//print(riceValue)
//
