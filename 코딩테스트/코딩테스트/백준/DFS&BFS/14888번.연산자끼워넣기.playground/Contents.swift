// + 백트래킹

import Foundation

let testCase = Int(readLine()!)!

let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

var FFAO = readLine()!.components(separatedBy: " ").map { Int($0)! }

var maxNum = Int.min
var minNum = Int.max

func dfs(answer: Int, d: Int) {
    if d == testCase {
        maxNum = max(maxNum, answer)
        minNum = min(minNum, answer)
        return
    }
    
    for i in 0..<4 {
        if FFAO[i] < 1 {
            continue
        }
        FFAO[i] -= 1
        switch i {
        case 0:
            dfs(answer: answer + testArray[d], d: d + 1)
        case 1:
            dfs(answer: answer - testArray[d], d: d + 1)
        case 2:
            dfs(answer: answer * testArray[d], d: d + 1)
        case 3:
            dfs(answer: answer / testArray[d], d: d + 1)
        default:
            break
        }
        FFAO[i] += 1
    }
}

dfs(answer: testArray[0], d: 1)

print(maxNum)
print(minNum)
