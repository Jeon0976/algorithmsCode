////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/02.
////
//
//import Foundation
//
//
//let line = readLine()
//
//var n = 0
//var k = 0
//
//if let line = line {
//    let array = line.components(separatedBy: " ").map { Int($0)! }
//    n = array[0]
//    k = array[1]
//}
//
//var arrayA = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//var arrayB = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//
//arrayA = arrayA.sorted()
//arrayB = arrayB.sorted(by: >)
//
//for i in 0...k-1 {
//    arrayA[i] = arrayB[i]
//}
//
//print(arrayA.reduce(0, +))
