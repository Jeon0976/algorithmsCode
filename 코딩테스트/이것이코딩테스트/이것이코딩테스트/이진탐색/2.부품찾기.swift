////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//import Foundation
//
//let n = Int(readLine()!)!
//let nArray = readLine()!.components(separatedBy: " ").map {Int($0)!}.sorted()
//let m = Int(readLine()!)!
//let mArray = readLine()!.components(separatedBy: " ").map {Int($0)!}
//
//var checkArray: [String] = []
//
//// 이진탐색
//func binary_search(_ array:[Int], _ target:Int, _ start:Int, _ end:Int) -> Int? {
//    if start > end {
//        return nil
//    }
//    
//    let mid = (start + end) / 2
//    
//    if array[mid] == target {
//        return mid
//    } else if array[mid] > target {
//        return binary_search(array, target, start, mid - 1)
//    } else {
//        return binary_search(array, target, mid + 1, end)
//    }
//}
//
//
//for mElement in mArray {
//    let result = binary_search(nArray, mElement, 0, nArray.count-1) ?? -1
//    if result == -1 {
//        checkArray.append("no")
//    } else {
//        checkArray.append("yes")
//    }
//}
//
//print(checkArray)
