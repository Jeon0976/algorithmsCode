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
//let line = Int(readLine()!)!
//
//var students = [String]()
//var score = [Int]()
//
//
//for _ in 1...line {
//    let array = readLine()!.components(separatedBy: " ")
//    students.append(array[0])
//    score.append(Int(array[1])!)
//}
//
//var dic = [String:Int]()
//
//for i in 0..<score.count {
//    dic.updateValue(score[i], forKey: students[i])
//}
//
//print(dic)
////print(score)
////let maxNum = score.max()!
////
////var count = [Int](repeating: 0, count: maxNum-1)
////var sortedScore = [Int]()
////
////for element in score {
////    count[element] += 1
////}
////
////for index in 0..<count.count {
////    for _ in 1...count[index] {
////        sortedScore.append(index)
////    }
////}
//
//
//var sortedDic = dic.sorted { $0.value < $1.value }
//print(sortedDic)
//for (key, _) in sortedDic {
//    print(key.precomposedStringWithCanonicalMapping, terminator: " ")
//}
