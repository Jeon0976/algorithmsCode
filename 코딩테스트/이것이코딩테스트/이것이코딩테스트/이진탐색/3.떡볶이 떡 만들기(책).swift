////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//import Foundation
//
//// 책 풀이방법
//// 각 각 원소를 숫자 그대로 나타내도 풀 수 있음
//// 큰 수 계산 거의 99프로 속도 줄임
//// 굳이 배열로 나눌 필요 없음
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
//var start = 0
//var end = array.max()!
//
//var result = 0
//
//while(start <= end) {
//    var total = 0
//    let mid = (start + end) / 2
//
//    for x in array {
//        if x > mid {
//            total += x - mid
//        }
//    }
//
//    if total < m {
//        end = mid - 1
//    } else {
//        result = mid
//        start = mid + 1
//    }
//}
//
//print(result)
