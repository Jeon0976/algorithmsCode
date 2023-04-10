////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//import Foundation
//
//// 1로 만들기
//
//let n = Int(readLine()!)!
//var dp = [Int](repeating: 0, count: n+1)
//
//for i in 2..<n+1 {
//    dp[i] = dp[i-1] + 1
//    if i % 3 == 0 {
//        dp[i] = min(dp[i], dp[i/3]+1)
//    }
//    if i % 2 == 0 {
//        dp[i] = min(dp[i], dp[i/2]+1)
//    }
//    if i % 5 == 0 {
//        dp[i] = min(dp[i], dp[i/5]+1)
//    }
//}
//
//print(dp[n])
//print(dp)
//
//

