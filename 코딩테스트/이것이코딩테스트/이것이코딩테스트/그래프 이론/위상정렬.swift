////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/05.
////
//
//import Foundation
//
//// Queue 만들기
//public struct QueueStack {
//    // pop 하는곳
//    private var leftStack:[Int] = []
//    // append 되는곳
//    private var rightStack:[Int] = []
//
//    public init() { }
//
//    public var isEmpty: Bool {
//        leftStack.isEmpty && rightStack.isEmpty
//    }
//
//    public var peek: Int? {
//        !leftStack.isEmpty ? leftStack.last : rightStack.first
//    }
//
//    @discardableResult public mutating func enquene(_ element: Int) -> Bool {
//        rightStack.append(element)
//        return true
//    }
//
//    public mutating func dequene() -> Int? {
//        if leftStack.isEmpty {
//            leftStack = rightStack.reversed()
//            rightStack.removeAll()
//        }
//        return leftStack.popLast()
//    }
//}
//
//// 노드의 개수와 간선의 개수 입력받기
//let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
//let v = line[0]
//let e = line[1]
//
//// 모든 노드에 대한 진입차수는 0으로 초기화
//var indegree = [Int](repeating: 0, count: v + 1)
//// 각 노드에 연결된 간선 정보를 담기 위한 그래프 초기화
//var graph = [[Int]](repeating: [Int](), count: v + 1)
//
//// 방향 그래프의 모든 간선 정보를 입력받기
//for _ in 0..<e {
//    let line = readLine()!.components(separatedBy: " ").map { Int($0)! }
//    // 정점 a에서 b로 이동
//    let a = line[0]
//    let b = line[1]
//    graph[a].append(b)
//
//    indegree[b] += 1
//}
//
//print(indegree)
//print(graph)
//
//
//// 위상 정렬 함수
//func topology_sort() {
//    var result = [Int]()
//    var queue = QueueStack()
//
//    for i in 1...v {
//        if indegree[i] == 0 {
//            queue.enquene(i)
//        }
//    }
//
//    while !queue.isEmpty {
//        let now = queue.dequene()!
//
//        result.append(now)
//        for i in graph[now] {
//            indegree[i] -= 1
//            if indegree[i] == 0 {
//                queue.enquene(i)
//            }
//        }
//    }
//
//    for i in result {
//        print(i, terminator: " ")
//    }
//}
//topology_sort()
//print()
//
//print(indegree)
//print(graph)
