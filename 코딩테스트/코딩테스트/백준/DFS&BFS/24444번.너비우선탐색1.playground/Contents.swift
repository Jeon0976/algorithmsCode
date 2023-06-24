import Foundation

let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

var graph = [[Int]](repeating: [Int](), count: testArray[0] + 1)
var visited = [Int](repeating: 0, count: testArray[0] + 1)

for _ in 0..<testArray[1] {
    let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    graph[testCase[0]].append(testCase[1])
    graph[testCase[1]].append(testCase[0])
}

var depth = 1

func bfs(start: Int) {
    var queue = [start]
    var index = 0
    
    visited[start] = depth
    
    while queue.count > index {
        let currentNode = queue[index]
        
        for i in graph[currentNode].sorted() {
            if visited[i] == 0 {
                depth += 1
                visited[i] = depth
                queue.append(i)
            }
        }
        index += 1
    }
}

bfs(start: testArray[2])

print(visited[1...].map { String($0) }.joined(separator: "\n"))
