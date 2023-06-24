import Foundation

struct queueArray {
    private var leftArray = [(Int,Int)]()
    private var rightArray = [(Int,Int)]()
    
    var isEmpty: Bool {
        leftArray.isEmpty && rightArray.isEmpty
    }
    
    mutating func push(_ value: (Int,Int)) {
        rightArray.append(value)
    }
    
    mutating func pop() -> (Int,Int) {
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
var visitedDepth = [Int](repeating: -1, count: testArray[0] + 1)


for _ in 0..<testArray[1] {
    let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

    graph[testCase[0]].append(testCase[1])
    graph[testCase[1]].append(testCase[0])
}

func bfs(_ start: Int) {
    var queue = queueArray()
    let depth = 0
    
    visited[start] = true
    visitedDepth[start] = depth
    queue.push((start,depth))
    
    while !queue.isEmpty  {
        let value = queue.pop()
        let currentNode = value.0
        let depth = value.1
        
        visitedDepth[currentNode] = depth
        
        for nextNode in graph[currentNode] {
            if !visited[nextNode] {
                queue.push((nextNode, depth + 1))
                visited[nextNode] = true
            }
        }
    }
}
 
bfs(testArray[2])

for i in 1...testArray[0] {
    print(visitedDepth[i])
}

