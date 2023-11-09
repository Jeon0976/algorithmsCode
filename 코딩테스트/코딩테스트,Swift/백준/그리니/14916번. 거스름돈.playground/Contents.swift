import Foundation

let money = Int(readLine()!)!

var max = -1

var dp = [Int](repeating: -1, count: money)

for i in 1...money {
    let index = i - 1
    
    if i == 1 {
        dp[index] = -1
        continue
    } else if i == 2 {
        dp[index] = 1
        continue
    } else if i == 3 {
        dp[index] = -1
        continue
    }
    
    if i % 5 == 0 {
        dp[index] = i / 5
    } else {
        dp[index] = dp[index - 2] + 1
    }
}

if let last = dp.last {
    print(last)
}
