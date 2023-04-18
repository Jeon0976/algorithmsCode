import Foundation

// 네트워크

func solution(_ n:Int, _ computers:[[Int]]) -> Int {
    var condition = [[Bool]](repeating: [Bool](repeating: false, count: n), count: n)
    
    func dfs(_ graph: [[Int]], _ v: Int, _ visited: inout [Bool]) {
        visited[v] = true
        for i in 0..<graph[v].count {
            if !visited[i] && graph[v][i] == 1 {
                dfs(graph, i, &visited)
            }
        }
    }
    
    for i in 0..<n {
        dfs(computers, i, &condition[i])
    }
    
    print(condition)
    
    var result = 1
    
    for i in 0..<n-1 {
        if condition[i] != condition[i+1] {
            result += 1
        }
    }
    
    return result
}

func solutionH(_ n:Int, _ computers:[[Int]]) -> Int {
    var visits = Array(repeating: false, count: n)
    var numOfNetwork:Int = 0
    
    func dfs(_ com:Int) {
        visits[com] = true
        for i in 0..<n {
            if computers[com][i] == 1 && !visits[i] {
                dfs(i)
            }
        }
    }
    for i in 0..<n {
        if !visits[i] {
            numOfNetwork += 1
            dfs(i)
        }
    }
    print(visits)

    return numOfNetwork
}
solution(3,[[1, 1, 0], [1, 1, 0], [0, 0, 1]]     )

solutionH(3,[[1, 1, 0], [1, 1, 0], [0, 0, 1]]     )


func roomNumber(_ arr: [Int]) -> Int {
    var checkNum = [Int](repeating: 0, count: 10)
    var sixAndNine = 0
    
    var arr = arr
    
    for i in 1...9 {
        for int in arr {
            if i == int {
                checkNum[i] += 1
            }
        }
    }
    
    print(checkNum)
    
    return 0
}


roomNumber([9,9,9,9])
