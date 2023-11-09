import Foundation

let testCase = Int(readLine()!)!

var dp = [Int](repeating: 0, count: testCase)

var stairs = [Int](repeating: 0, count: testCase)

for i in 1...testCase {
    stairs[i] = Int(readLine()!)!
}

for i in 0..<testCase {
    if i == 0 { dp[0] = stairs[0] }
    else if i == 1 { dp[1] = max(stairs[0] + stairs[1] , stairs[1])}
    else if i == 2 { dp[2] = max(stairs[0] + stairs[2], stairs[1] + stairs[2])}
    else { dp[i] = max(dp[i-3] + stairs[i-1] + stairs[i], dp[i-2] + stairs[i])}
}

print(dp[testCase-1])
