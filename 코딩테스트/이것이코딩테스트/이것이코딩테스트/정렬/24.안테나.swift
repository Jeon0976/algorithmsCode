////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/12.
////
//
//import Foundation
//
//// 시간 초과
////
//let line = Int(readLine()!)!
//
//var array = readLine()!.components(separatedBy: " ").map { Int($0)! }
////
////var result = [Int:Int]()
////
////var temp = 0
////
////for i in 0..<array.count {
////    for j in array {
////        if array[i] > j {
////            temp += array[i] - j
////        } else if array[i] < j {
////            temp += j - array[i]
////        }
////    }
////    result.updateValue(temp, forKey: array[i])
////    temp = 0
////}
////
////let sortedResult = result.sorted(by: { $0.value < $1.value })
////
////let sorted2Result = sortedResult.sorted {
////    if $0.value == $1.value {
////        return $0.key < $1.key
////    }
////    return false
////}
////
////print(sorted2Result.first!.key)
//
//// 중앙 값보다 멀어지면 값은 항상 크다.
//// 즉 중앙 값이 가장 작음
//
//array.sort()
//
//print(array[(line - 1) / 2])
