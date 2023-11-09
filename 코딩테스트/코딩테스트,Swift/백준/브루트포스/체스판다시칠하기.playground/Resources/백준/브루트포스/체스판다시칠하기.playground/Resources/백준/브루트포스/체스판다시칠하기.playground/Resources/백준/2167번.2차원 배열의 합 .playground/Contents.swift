import Foundation

let testCase1 = readLine()!.components(separatedBy: " ").map { Int($0)! }
let N = testCase1[0]
let M = testCase1[1]

var array = [[Int]](repeating: [Int](), count: N)

var dp = [[Int]](repeating: [Int](repeating: 0, count: M + 1), count: N + 1)

for n in 0..<N {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    array[n] = testArray
}


for i in 1...N {
    for j in 1...M {
        dp[i][j] = dp[i-1][j] + dp[i][j-1] - dp[i-1][j-1] + array[i-1][j-1]
    }
}

for _ in 0..<Int(readLine()!)! {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    let i = testArray[0]
    let j = testArray[1]
    let x = testArray[2]
    let y = testArray[3]
    
    print(dp[x][y] - dp[x][j-1] - dp[i-1][y] + dp[i-1][j-1])
}
