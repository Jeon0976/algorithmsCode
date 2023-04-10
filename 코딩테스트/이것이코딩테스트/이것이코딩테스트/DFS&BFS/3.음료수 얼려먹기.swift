////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/01.
////
//
//import Foundation
//
//
//let line = readLine()
//
//var n: Int = 0
//var m: Int = 0
//
//if let line = line {
//    let array = line.components(separatedBy: " ").map { Int($0)!}
//    n = array[0]
//    m = array[1]
//}
//
//var graph:[[Int]] = []
//
//for _ in 1...n {
//    let input = Array(readLine()!)
//    let array = input.map { Int(String($0))!}
//    
//    graph.append(array)
//}
//
//// DFS로 특정한 노드를 방문한 뒤에 연결된 모든 노드들로 방문
//func dfs(_ x:Int, _ y:Int) -> Bool {
//    // 주어진 범위를 벗어나는 경우에는 즉시 종료
//    if x <= -1 || x >= n || y <= -1 || y >= m {
//        return false
//    }
//    // 현재 노드를 아직 방문하지 않았다면
//    if graph[x][y] == 0 {
//        graph[x][y] = 1
//        dfs(x-1, y)
//        dfs(x,y-1)
//        dfs(x+1,y)
//        dfs(x,y+1)
//        return true
//    }
//    return false
//}
//
//var result = 0
//
//for i in 0...n-1 {
//    for j in 0...m-1 {
//        if dfs(i, j) == true {
//            result += 1
//        }
//    }
//}
//
//print(result)
