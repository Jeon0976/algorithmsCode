////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/12.
////
//
//import Foundation
//
//let line = Int(readLine()!)!
//
//var doClass = [(String,Int,Int,Int)]()
//
//
//for _ in 0..<line {
//    let array = readLine()!.components(separatedBy: " ")
//    let name = array[0]
//    let kor = Int(array[1])!
//    let math = Int(array[3])!
//    let eng = Int(array[2])!
//
//    doClass.append((name,kor,eng,math))
//}
//// 국어 점수가 감소하느 순서
//doClass = doClass.sorted(by: { $0.1 > $1.1 })
//// 국어 점수가 같으면 영어 점수가 증가하는 순서
//doClass = doClass.sorted {
//    if $0.1 == $1.1 {
//        return $0.2 < $1.2
//    }
//    return false
//}
//// 국어 점수와 영어 점수가 같으면 수학 점수가 감소하는 순서
//doClass = doClass.sorted {
//    if $0.1 == $1.1 && $0.2 == $1.2 {
//        return $0.3 > $1.3
//    }
//    return false
//}
//
//doClass = doClass.sorted {
//    if $0.1 == $1.1 && $0.3 == $1.3 && $0.2 == $1.2 {
//        return $0.0 < $1.0
//    }
//    return false
//}
//
//for dod in doClass {
//    print(dod.0)
//}
//
