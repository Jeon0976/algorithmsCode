////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/08.
////
//
//import Foundation
//
//// 개미 전사
//
//let n = Int(readLine()!)!
//let array = readLine()!.components(separatedBy:" ").map {Int($0)!}
//
//var dp = [Int]()
//
//dp.append(array[0])
//// 짝수일 때 규칙적인 위치가 아니라 끝과 끝의 최대값이 올 수 있으니 0,1위치의 둘 중 최대 값 더하기
//dp.append(max(array[0], array[1]))
//
//for i in 2..<n {
//    dp.append(max(dp[i - 1],dp[i - 2] + array[i]))
//}
//
//print(dp[n-1])
