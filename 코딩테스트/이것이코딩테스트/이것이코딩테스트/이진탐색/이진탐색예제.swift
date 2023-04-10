////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//import Foundation
//
//// 순차 탐색
//func sequential_search(_ n:Int,_ target:Int, _ array:[Int]) -> Int {
//    for i in 0..<n {
//        if array[i] == target {
//            return array[i]
//        }
//    }
//    return -1
//}
//
//print(sequential_search(5, 2, [1,2,3,4,5]))
//
//
//// 재귀함수
//func binary_search1(_ array:[Int], _ target:Int, _ startIndex:Int, _ endIndex: Int) -> Int? {
//    if startIndex > endIndex {
//        return nil
//    }
//
//    let mid = (startIndex + endIndex) / 2
//
//    if array[mid] == target {
//        return mid
//    } else if array[mid] > target {
//        return binary_search1(array, target, startIndex, mid - 1)
//    } else {
//        return binary_search1(array, target, mid + 1, endIndex)
//    }
//}
//
//
//print(binary_search1([1,3,5,7,9,11,13,15,17,19], 19, 0, 9) ?? -1)
//
//// 반복문
//func binary_search2(_ array:[Int], _ target:Int, _ startIndex:Int, _ endIndex: Int) -> Int? {
//    var startIndex = startIndex
//    var endIndex = endIndex
//    while startIndex <= endIndex {
//        let mid = (startIndex + endIndex) / 2
//
//        if array[mid] == target {
//            return mid
//        } else if array[mid] > target {
//            endIndex = mid - 1
//        } else {
//            startIndex = mid + 1
//        }
//    }
//
//    return nil
//}
//
//print(binary_search2([1,3,5,7,9,11,13,15,17,19], 19, 0, 9) ?? -1)
