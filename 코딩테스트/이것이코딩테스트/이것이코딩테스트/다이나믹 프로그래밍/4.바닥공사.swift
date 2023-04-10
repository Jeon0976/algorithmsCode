////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/09.
////
//
//import Foundation
//
//// 바닥 공사
//// 점화식 만들기
//
//let n = Int(readLine()!)!
//
//var dp = [Int](repeating: 0, count: n)
//
//dp[0] = 1
//dp[1] = 3
//
//
//for i in 2..<n {
//    dp[i] = (dp[i - 1] + (2 * dp[i - 2])) % 796796
//}
//
//print(dp)
//print(dp[n-1])
//
