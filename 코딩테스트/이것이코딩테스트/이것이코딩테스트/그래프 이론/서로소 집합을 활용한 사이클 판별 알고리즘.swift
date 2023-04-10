////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/05.
////
//
//import Foundation
//
//// 서로소 집합 알고리즘을 활용한 사이클 판별 소스코드
//
//// 특정 원소가 속한 집합 찾기
//func find_parent(_ parent: inout [Int], _ x: Int) -> Int {
//    if parent[x] != x {
//        parent[x] = find_parent(&parent, parent[x])
//    }
//    return parent[x]
//}
//
//// 두 원소가 속한 집합을 합치기
//func union_parent(_ parent: inout [Int], _ a: Int, _ b: Int) {
//    let a = find_parent(&parent, a)
//    let b = find_parent(&parent, b)
//
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
//
//var cycle = false
//
//for _ in 0..<e {
//    let array = readLine()!.components(separatedBy: " ").map { Int($0)!}
//    let a = array[0]
//    let b = array[1]
//
//    if find_parent(&parent, a) == find_parent(&parent, b) {
//        cycle = true
//        break
//    } else {
//        union_parent(&parent, a, b)
//    }
//}
//print(parent)
//if cycle {
//    print("사이클 발생")
//} else {
//    print("사이클 발생 x")
//}
