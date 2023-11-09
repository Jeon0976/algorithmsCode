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

var visitedOrder = [Int](repeating: 0, count: testArray[0] + 1)

for _ in 0..<testArray[1] {
    let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

    graph[testCase[0]].append(testCase[1])
    graph[testCase[1]].append(testCase[0])
}

func bfs(_ start: Int) {
    var count = 0
    var queue = queueArray()
    
    visited[start] = true
    queue.push((start,0))
    
    
    while !queue.isEmpty  {
        count += 1
        let value = queue.pop()
        let currentNode = value.0
        let depth = value.1
        
        visitedOrder[currentNode] = count
        visitedDepth[currentNode] = depth
        
        for nextNode in graph[currentNode].sorted() {
            if !visited[nextNode] {
                queue.push((nextNode, depth + 1))
                visited[nextNode] = true
            }
        }
    }
}
 
bfs(testArray[2])

var result = 0

for i in 1...testArray[0] {
   result += visitedDepth[i] * visitedOrder[i]
}

print(result)
