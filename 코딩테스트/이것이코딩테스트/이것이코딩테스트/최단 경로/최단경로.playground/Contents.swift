import Foundation

let INF = Int.max

let nodeCount = 6
let link = 11
let start = 1

var graph =  [[[Int]]](repeating: [[Int]](), count: nodeCount + 1)

var visited = [Bool](repeating: false, count: nodeCount + 1)

var distance = [Int](repeating: INF, count: nodeCount + 1)


for _ in 1...link {
    let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let a = array[0]
    let b = array[1]
    let c = array[2]
    graph[a].append([b,c])
}


func get_smallest_node() -> Int {
    var min_value = INF
    
    var index = 0
    
    for i in 1...nodeCount {
        if distance[i] < min_value && !visited[i] {
            min_value = distance[i]
            index = i
        }
    }
    return index
}

func dijkstra(_ start: Int) {
    distance[start] = 0
    visited[start] = true
    
    for i in graph[start] {
        distance[i[0]] = i[1]
    }
    
    for _ in 0..<nodeCount {
        let now = get_smallest_node()
        visited[now] = true
        for j in graph[now] {
            let cost = distance[now] + j[1]
            if cost < distance[j[0]] {
                distance[j[0]] = cost
            }
        }
    }
}

for i in 1...nodeCount {
    if distance[i] == INF {
        print("INFINITY")
    } else {
        print(distance[i])
    }
}

