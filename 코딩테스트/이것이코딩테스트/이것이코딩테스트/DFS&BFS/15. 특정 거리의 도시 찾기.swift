////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/12.
////
//// 백준에서는 시간초과 뜸
//
//import Foundation
//
//struct QueueStack<T> {
//    private var leftStack:[T] = []
//    private var rightStack:[T] = []
//    public init() { }
//
//    public var isEmpty: Bool {
//        leftStack.isEmpty && rightStack.isEmpty
//    }
//
//    public var peek: T? {
//        !leftStack.isEmpty ? leftStack.last : rightStack.first
//    }
//
//    @discardableResult public mutating func enqueue(_ element: T) -> Bool {
//        rightStack.append(element)
//        return true
//    }
//
//    public mutating func dequeue() -> T? {
//        if leftStack.isEmpty {
//            leftStack = rightStack.reversed()
//            rightStack.removeAll()
//        }
//        return leftStack.popLast()
//    }
//}
//
//
//let arr = readLine()!.components(separatedBy: " ").map{ Int($0)! }
//
//let N = arr[0]
//let M = arr[1]
//let K = arr[2]
//let X = arr[3]
//
//var nodeInfo = [[Int]](repeating: [Int](), count: N + 1)
//
//var distance = [Int](repeating: -1, count: N + 1)
//
//for _ in 1...M {
//    let arr2 = readLine()!.components(separatedBy: " ").map { Int($0)! }
//    let a = arr2[0]
//    let b = arr2[1]
//    // 출발 -> 도착
//    nodeInfo[a].append(b)
//}
//
//// 출발 도시 0으로 설정
//distance[X] = 0
//
//var queue = QueueStack<Int>()
//queue.enqueue(X)
//
//while !queue.isEmpty {
//    let now = queue.dequeue()!
//
//    // 현재 이동할 수 있는 모든 도시 확인
//    for next_node in nodeInfo[now] {
//        if distance[next_node] == -1 {
//            // 최단 거리 갱신
//            distance[next_node] = distance[now] + 1
//            queue.enqueue(next_node)
//        }
//    }
//}
//var check = false
//
//for i in 1...N {
//    if distance[i] == K {
//        print(i)
//        check = true
//    }
//}
//
//if check == false {
//    print(-1)
//}
