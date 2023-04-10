////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/05.
////
//
//import Foundation
//
//// 크루스칼 알고리즘을 활용하여 신장 트리 확인
//
//func find_parent(_ parent: inout[Int], _ x: Int) -> Int {
//    if parent[x] != x {
//        parent[x] = find_parent(&parent, parent[x])
//    }
//    return parent[x]
//}
//
//func union_parent(_ parent: inout[Int], _ a: Int, _ b: Int) {
//    let a = find_parent(&parent, a)
//    let b = find_parent(&parent, b)
//    if a < b {
//        parent[b] = a
//    } else {
//        parent[a] = b
//    }
//}
//
//// 노드의 개수와 간선(Union 연산)의 개수 입력받기
//let array = readLine()!.components(separatedBy: " ").map { Int($0)!}
//let v = array[0]
//let e = array[1]
//
//var parent = [Int](repeating: 0, count: v + 1)
//
//// 부모 테이블상에서, 부모를 자기 자신으로 초기화
//for i in 1...v {
//    parent[i] = i
//}
//
//// 모든 간선을 담을 리스트와 최종 비용을 담을 변수
//var edges = [(Int,Int,Int)]()
//var result = 0
//
//
//// 모든 간선에 대한 정보를 입력받기
//for _ in 0..<e {
//    let array = readLine()!.components(separatedBy: " ").map { Int($0)!}
//    let cost = array[2]
//    let a = array[0]
//    let b = array[1]
//    edges.append((cost, a, b))
//}
//
//// 간선을 비용순으로 정렬
//edges = edges.sorted(by: { $0.0 < $1.0 })
//
//print(edges)
//
//// 간선을 하나씩 확인하며
//for edge in edges {
//    let cost = edge.0
//    let a = edge.1
//    let b = edge.2
//    
//    if find_parent(&parent, a) != find_parent(&parent, b) {
//        union_parent(&parent, a, b)
//        result += cost
//        print(cost)
//        print(parent)
//    }
//}
//
//
//print(result)
//print(parent)
