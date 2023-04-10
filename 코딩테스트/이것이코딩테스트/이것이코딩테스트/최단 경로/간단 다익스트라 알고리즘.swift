////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/03.
////
//
//import Foundation
//
//// 간단한 다익스트라 알고리즘 소스 코드
//
//// 최댓값
//let INF = Int.max
//
//// 노드의 개수
//let nodeCount: Int = 6
//
//// 간선의 개수
//let link: Int = 11
//
//// 시작 노드 번호
//let start: Int = 1
//
//// 각 노드에 연결되어 있는 노드에 대한 정보를 담는 배열
//var graph = [[[Int]]](repeating: [[Int]](), count: nodeCount + 1)
//
//// 방문한 적이 있는지 체크하는 목적의 베열
//var visited = [Bool](repeating: false, count: nodeCount + 1)
//
//// 최단 거리 테이블을 모두 무한으로 초기화
//var distance = [Int](repeating: INF, count: nodeCount + 1)
//
//// 모든 간선 정보를 입력받기
//// a번 노드에서 b번 노드로 가는 비용이 c라는 의미
//for _ in 1...link {
//    let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
//    let a = array[0]
//    let b = array[1]
//    let c = array[2]
//    graph[a].append([b,c])
//}
//
//print(graph)
//print(visited)
//print(distance)
//
//
//// 방문하지 않은 노드 중에서, 가장 최단 거리가 짧은 노드의 번호를 반환
//func get_smallest_node() -> Int {
//    var min_value = INF
//
//    // 가장 최단 거리가 짧은 노드(인덱스)
//    var index = 0
//
//    for i in 1...nodeCount {
//        if distance[i] < min_value && !visited[i] {
//            min_value = distance[i]
//            index = i
//            print("index: ",index)
//        }
//    }
//
//    return index
//}
//
//func dijkstra(_ start: Int) {
//    distance[start] = 0
//    visited[start] = true
//
//    for i in graph[start] {
//        distance[i[0]] = i[1]
//        print(distance)
//    }
//    // 시작 노드를 제외한 전체 n-1개의 노드에 대해 반복
//    for _ in 0..<nodeCount {
//        // 현재 최단 거리가 가장 짧은 노드를 꺼내서, 방문 처리
//        let now = get_smallest_node()
//        print("now", now)
//        visited[now] = true
//        // 현재 노드와 연결된 다른 노드를 확인
//        for j in graph[now] {
//            let cost = distance[now] + j[1]
//            // 현재 노드를 거쳐서 다른 노드로 이동하는 거리가 더 짧은 경우
//            if cost < distance[j[0]] {
//                distance[j[0]] = cost
//            }
//        }
//        print(distance)
//    }
//}
//
//// 다익스트라 알고리즘 수행
//dijkstra(start)
//
//
//// 모든 노드로 가기 위한 최단 거리를 출력
//for i in 1...nodeCount {
//    // 도달할 수 없는 경우, 무한으로 출력
//    if distance[i] == INF {
//        print("INFINITY")
//    } else {
//        print(distance[i])
//    }
//}
