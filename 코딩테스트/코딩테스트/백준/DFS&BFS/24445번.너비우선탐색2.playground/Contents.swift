//import Foundation
//
//let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//var graph = [[Int]](repeating: [Int](), count: testArray[0] + 1)
//var visitedOrder = [Int](repeating: 0, count: testArray[0] + 1)
//
//for _ in 0..<testArray[1] {
//    let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//    graph[testCase[0]].append(testCase[1])
//    graph[testCase[1]].append(testCase[0])
//}
//
//var depth = 1
//
//// sorted graph는 탐색하지 못하는 부분에서도 정렬하기 때문에 시간초과인건가??
//
//func bfs(_ graph: [[Int]], _ start: Int) {
//    var index = 0
//    var queue = [Int]()
//
//    queue.append(start)
//    visitedOrder[start] = depth
//
//    while queue.count > index  {
//        let currentNode = queue[index]
//
//        for i in graph[currentNode].sorted(by: >) {
//            if visitedOrder[i] == 0 {
//                depth += 1
//                visitedOrder[i] = depth
//                queue.append(i)
//            }
//        }
//        index += 1
//    }
//}
//
//bfs(graph, testArray[2])
//
//for i in 1...testArray[0] {
//    print(visitedOrder[i])
//}
//
//

import Foundation

struct queueArray {
    private var leftArray = [Int]()
    private var rightArray = [Int]()
    
    var isEmpty: Bool {
        leftArray.isEmpty && rightArray.isEmpty
    }
    
    mutating func push(_ value: Int) {
        rightArray.append(value)
    }
    
    mutating func pop() -> Int {
        if leftArray.isEmpty {
            leftArray = rightArray.reversed()
            rightArray.removeAll()
        }
        
        return leftArray.popLast()!
    }
}


let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

var graph = [[Int]](repeating: [Int](), count: testArray[0] + 1)
var visited = [Bool](repeating: false, count: testArray[0] + 1)
var visitedOrder = [Int](repeating: 0, count: testArray[0] + 1)

for _ in 0..<testArray[1] {
    let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

    graph[testCase[0]].append(testCase[1])
    graph[testCase[1]].append(testCase[0])
}

for i in 1..<graph.count {
    graph[i] = graph[i].sorted(by: >)
}

func bfs(_ start: Int) {
    var count = 0
    var queue = queueArray()
    
    visited[start] = true
    queue.push(start)
    
    while !queue.isEmpty  {
        count += 1
        
        let value = queue.pop()
        
        visitedOrder[value] = count
                
        for i in graph[value] {
            if !visited[i] {
                queue.push(i)
                visited[i] = true
            }
        }
    }
}
 
bfs(testArray[2])

for i in 1...testArray[0] {
    print(visitedOrder[i])
}
