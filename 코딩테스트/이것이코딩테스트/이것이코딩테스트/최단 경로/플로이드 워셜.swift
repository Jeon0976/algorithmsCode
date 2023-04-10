////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/05.
////
//
//import Foundation
//
//
//let INF = 100000
//
//// 노드의 개수와 간선의 개수
//let n = Int(readLine()!)!
//let m = Int(readLine()!)!
//
//// 2차원 그래프 표현 만들고, 모든 값을 무한으로 초기화
//var graph = [[Int]](repeating: [Int](repeating: INF, count: n+1), count: n+1)
//
//
//// 자기 자신에서 자기 자신으로 가는 비용은 0으로 초기화
//for i in 1...n {
//    for j in 1...n {
//        if i == j {
//            graph[i][j] = 0
//        }
//    }
//}
//
//
//// 각 간선에 대한 정보를 입력받아, 그 값으로 초기화
//for _ in 0..<m {
//    let array = readLine()!.components(separatedBy: " ").map { Int($0)!}
//    let a = array[0]
//    let b = array[1]
//    let c = array[2]
//    graph[a][b] = c
//}
//
//// 점화식에 따라 플로이드 워셜 알고리즘 수행
//for a in 1...n {
//    for b in 1...n {
//        for c in 1...n{
//            graph[b][c] = min(graph[b][c], graph[b][a] + graph[a][c])
//        }
//    }
//}
//
//
//for a in 1...n {
//    for b in 1...n {
//        if graph[a][b] == INF {
//            print("INFINITY", terminator: " ")
//        } else {
//            print(graph[a][b], terminator: " ")
//        }
//    }
//    print()
//}
