import Foundation

var testCase = [Int]()
var result = 0

for _ in 0..<Int(readLine()!)! {
    let value = Int(readLine()!)!
    
    testCase.append(value)
}

testCase.sort()

for (index, value) in testCase.enumerated() {
    result = max(value * (index + 1), result)
}

print(result)
