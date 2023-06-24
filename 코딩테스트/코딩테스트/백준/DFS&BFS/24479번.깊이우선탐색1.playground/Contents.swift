import Foundation

let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

var graph = [[Int]](repeating:[Int](),count: testCase[0] + 1)
var visited = [Int](repeating: 0, count: testCase[0] + 1)

for _ in 0..<testCase[1] {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let n = testArray[0]
    let m = testArray[1]
    
    graph[n].append(m)
    graph[m].append(n)
}

var depth = 1

var start = testCase[2]

func dfs(start: Int) {
    visited[start] = depth
    
    for i in graph[start].sorted() {
        if visited[i] == 0 {
            depth += 1
            dfs(start: i)
        }
    }
}

dfs(start: start)

print(visited[1...].map { String($0) }.joined(separator: "\n"))
