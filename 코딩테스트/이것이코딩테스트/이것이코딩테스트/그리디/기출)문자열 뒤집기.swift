////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/11.
////
//
//import Foundation
//
//let n = readLine()!
//
//func splitString(_ n:String)  -> Int {
//    var nArray = n.map { Int(String($0))! }
//    var array = [[Int]](repeating: [Int](), count: nArray.count)
//
//    var count = 0
//
//    for i in 0..<nArray.count {
//        if count == i {
//            for j in i..<nArray.count {
//                if i + 1 < nArray.count && nArray[i] == nArray[j] {
//                    array[i].append(nArray[i])
//                    count += 1
//                } else {
//                    break
//                }
//            }
//        }
//    }
//
//    array = array.filter { !$0.isEmpty }
//
//    return array.count/2
//}
//
//print(splitString(n))
