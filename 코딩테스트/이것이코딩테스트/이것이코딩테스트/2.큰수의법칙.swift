//
//  큰수의법칙.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/03/29.
//

//import Foundation
//
//let line1 = readLine()
//let line2 = readLine()
//
//var n: Int = 0
//var m: Int = 0
//var k: Int = 0
//var array:[Int] = []
//
//if let line1 = line1 {
//    let array = line1.components(separatedBy: " ")
//    n = Int(array[0])!
//    m = Int(array[1])!
//    k = Int(array[2])!
//}
//
//
//if let line2 = line2 {
//    array = line2.components(separatedBy: " ").map { Int($0)!}
//}
//func bigNumber() -> Int {
//    // 큰 수 더하기 위해 배열 큰 순서대로 정렬
//    array = array.sorted(by: >)
//
//    // k 차례 뽑기위해 k만큼 카운트
//    var count = 0
//
//    var result = 0
//
//    for _ in 1...m {
//        if count != k {
//           result += array[0]
//            count += 1
//        } else {
//            result += array[1]
//            count = 0
//        }
//    }
//
//    return result
//    
//}
//
//print(bigNumber())
//
//// 책에서는 while을 사용하거나, 수열의 법칙을 찾아서 수학적으로 풀었음
