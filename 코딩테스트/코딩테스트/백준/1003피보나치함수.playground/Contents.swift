import Foundation

let testCount = Int(readLine()!)!

var testCase = [Int]()

for _ in 0..<testCount {
    testCase.append(Int(readLine()!)!)
}

func fibonacci(_ value: Int) {
    var zeros = [1,0,1]
    var ones = [0,1,1]
    
    if value >= 3 {
        for i in 2..<value {
            zeros.append(zeros[i-1] + zeros[i])
            ones.append(ones[i-1] + ones[i])
        }
    }
    print("\(zeros[value]) \(ones[value])")
}

for i in 0..<testCount {
    fibonacci(testCase[i])
}
