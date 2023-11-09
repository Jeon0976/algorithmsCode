import Foundation

let T = Int(readLine()!)!

var dp = [[Int]](repeating: [Int](repeating: 0, count: 31), count: 31)

func combination(_ m: Int, _ n: Int) -> Int {
    if dp[m][n] > 0 {
        return dp[m][n]
    }
    
    if m == n || n == 0 {
        dp[m][n] = 1
        return dp[m][n]
    }
    
    dp[m][n] = combination(m - 1, n - 1) + combination(m - 1, n)
    return dp[m][n]
}

for _ in 0..<T {
    let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    print(combination(array[1], array[0]))
}
