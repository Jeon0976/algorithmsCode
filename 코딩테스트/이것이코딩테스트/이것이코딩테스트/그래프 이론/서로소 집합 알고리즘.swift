////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/05.
////
// 서로소 집합은 무방향 그래프 내에서 사이클을 판별할 때 사용할 수 있다.
//
//import Foundation
//
//// 특정 원소가 속한 집합 찾기
//func find_parent(_ parent: [Int], _ x: Int) -> Int {
//    if parent[x] != x {
//        return find_parent(parent, parent[x])
//    }
//    return x
//}
//
//// 특정 원소가 속한 집합 찾기
//// 개선된 코드
//// 경로 압축 기법
//// 하지만 내부 원소를 바꿈
//func find_parent2(_ parent:inout [Int], _ x: Int) -> Int {
//    if parent[x] != x {
//        parent[x] = find_parent2(&parent, parent[x])
//    }
//    return parent[x]
//}
//
//// 두 원소가 속한 집합을 합치기
//func union_parent(_ parent:inout [Int], _ a: Int, _ b: Int) {
//    let a = find_parent(parent, a)
//    let b = find_parent(parent, b)
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
//// Union 연산을 각각 수행
//for _ in 0..<e {
//    let array2 = readLine()!.components(separatedBy: " ").map { Int($0)! }
//    union_parent(&parent, array2[0], array2[1])
//}
//
//
////// 각 원소가 속한 집합 출력
////print("각 원소가 속한 집합 출력: ", terminator: " ")
////for i in 1...v {
////    print(find_parent2(&parent, i), terminator: " ")
////}
////
////print()
//
//// 부모 테이블 출력
//print("부모 테이블: ", terminator: " ")
//for i in 1...v {
//    print(parent[i], terminator: " ")
//}
//
//print()
//
//// 각 원소가 속한 집합 출력
//print("각 원소가 속한 집합 출력: ", terminator: " ")
//for i in 1...v {
//    print(find_parent2(&parent, i), terminator: " ")
//}
//
//print()
