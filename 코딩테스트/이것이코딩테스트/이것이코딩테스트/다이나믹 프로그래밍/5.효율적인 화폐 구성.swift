////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/10.
////
//
//import Foundation
//
//// 효율적인 화폐 구성
//
//let NMarray = readLine()!.components(separatedBy: " ").map { Int($0)! }
//let N = NMarray[0]
//let M = NMarray[1]
//
//var array = [Int]()
//
//for _ in 0..<N {
//    array.append(Int(readLine()!)!)
//}
//
//let INF = Int.max
//var dp = [Int](repeating: INF, count: M+1)
//// 0 일 때는 갯수가 0
//dp[0] = 0
//print(array)
//// dp 개수가 m+1 인경우는 0번째 1번째 ~ M번째 까지 다 계산하기 때문
//for i in 0..<N {
//    if array[i] <= M {
//        for j in array[i]...M {
//            if dp[j - array[i]] != INF {
//                dp[j] = min(dp[j], dp[j - array[i]] + 1)
//            }
//        }
//    }
//}
//
//print(dp)
//if dp[M] == INF {
//    print(-1)
//} else {
//    print(dp[M])
//}
