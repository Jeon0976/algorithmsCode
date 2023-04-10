////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/01.
////
//
//import Foundation
//
//public struct Queue<Value> {
//    private var array: [Value] = []
//
//    public init() { }
//
//    public var isEmpty: Bool {
//        array.isEmpty
//    }
//
//    public var peek: Value? {
//        array.first
//    }
//
//    public mutating func enqueue(_ element: Value) {
//        array.append(element)
//    }
//
//    public mutating func dequeue() -> Value? {
//        isEmpty ? nil : array.removeLast()
//    }
//}
//
//let line = readLine()
//
//var n = 0
//var m = 0
//var graph:[[Int]] = []
//
//if let line = line {
//    let array = line.components(separatedBy: " ").map { Int($0)!}
//    n = array[0]
//    m = array[1]
//}
//
//// 북, 남, 서, 동
//let dx = [-1,1,0,0]
//let dy = [0,0,-1,1]
//
//var nowLocation = [0,0]
//
//for _ in 1...n {
//    let input = Array(readLine()!)
//    let array = input.map { Int(String($0))!}
//    graph.append(array)
//}
//
//
//func bfs(_ x:Int, _ y:Int) -> Int {
//    var queue = Queue<[Int]>()
//
//    queue.enqueue([x,y])
//
//    while !queue.isEmpty {
//        nowLocation  = queue.dequeue()!
//
//        for i in 0...3 {
//            let nx = nowLocation[0] + dx[i]
//            let ny = nowLocation[1] + dy[i]
//
//            if nx < 0 || ny < 0 || nx >= n || ny >= m {
//                continue
//            }
//
//            if graph[nx][ny] == 0 {
//                continue
//            }
//
//            if graph[nx][ny] == 1 {
//                graph[nx][ny] = graph[nowLocation[0]][nowLocation[1]] + 1
//                queue.enqueue([nx,ny])
//            }
//        }
//    }
//    for i in 0...n-1 {
//        print(graph[i],separator: "\n")
//    }
//    return graph[n-1][m-1]
//}
//
//print(bfs(0, 0))
