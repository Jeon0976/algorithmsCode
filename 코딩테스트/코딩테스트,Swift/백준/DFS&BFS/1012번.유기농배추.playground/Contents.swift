import Foundation

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    let M = testArray[0]
    let N = testArray[1]
    let K = testArray[2]
    
    var lend = [[Int]](repeating: [Int](repeating: 0, count: M), count: N)
    
    var result = 0
    
    for _ in 0..<K {
        let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
        let x = testArray[1]
        let y = testArray[0]
        lend[x][y] = 1
        
    }
    
    for i in 0..<N {
        for j in 0..<M {
            if dfs(i, j) {
                result += 1
            }
        }
    }
    
    func dfs(_ x: Int, _ y: Int) -> Bool {
        if x <= -1 || x >= N || y <= -1 || y >= M {
            return false
        }
        
        if lend[x][y] == 1 {
            lend[x][y] = 0
            _ = dfs(x-1, y)
            _ = dfs(x, y-1)
            _ = dfs(x+1,y)
            _ = dfs(x,y+1)
            return true
        }
        return false
    }

    
    print(result)
}
