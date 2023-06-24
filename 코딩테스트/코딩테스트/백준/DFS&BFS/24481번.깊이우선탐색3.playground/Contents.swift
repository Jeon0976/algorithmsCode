import Foundation

let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

let N = testCase[0]
let M = testCase[1]
let start = testCase[2]

var graph = [[Int]](repeating: [Int](), count: N+1)
var result = [Int](repeating: -1, count: N+1)

for _ in 0..<M {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let from = testArray[0]
    let to = testArray[1]
    
    graph[from].append(to)
    graph[to].append(from)
}

var depth = 0

func dfs(_ start: Int, _ depth: Int) {
    result[start] = depth
    
    for i in graph[start].sorted(by: >) {
        if result[start] == -1 {
            dfs(i, depth + 1)
        }
    }
}


dfs(start, depth)


print(result[1...].map { String($0) }.joined(separator: "\n") )


//import Foundation
//
//let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }
//
//let N = testCase[0]
//let M = testCase[1]
//
//var graph = [[Int]](repeating: [Int](), count: N+1)
//var resultArray = [Int](repeating: -1, count: N+1)
//var visitied = [Int](repeating: 0, count: N+1)
//
//
//for _ in 0..<M {
//    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
//    let from = testArray[0]
//    let to = testArray[1]
//
//    graph[from].append(to)
//    graph[to].append(from)
//}
//
//var depth = 0
//var count = 1
//let start = testCase[2]
//
//func dfs(_ start: Int, _ depth: Int) {
//    var depth = depth
//
//    resultArray[start] = depth
//    visitied[start] = count
//
//    for i in graph[start].sorted() {
//        if resultArray[i] == -1 {
//            count += 1
//            dfs(i, depth + 1)
//        }
//    }
//}
//
//dfs(start, depth)
//
//var result = 0
//
//for i in 1...N {
//    result += resultArray[i] * visitied[i]
//}
//
//print(result)
