import Foundation

let channel = Int(readLine()!)!
let testCase = Int(readLine()!)!

var arr = [Int]()

var result = abs(channel-100)

if testCase != 0 {
    arr = readLine()!.components(separatedBy: " ").map { Int($0)! }
}

for i in 0...1000000 {
    let len = check(i)
    
    if len > 0 {
        let press = abs(channel-i)
        result = min(result, len + press)
    }
}

func check(_ i: Int) -> Int {
    var n = i
    
    if n == 0 {
        if arr.contains(0) {
            return 0
        } else {
            return 1
        }
    }
    
    var len = 0
    
    while n > 0 {
        if arr.contains(n % 10) { return 0 }
        n = n / 10
        len += 1
    }
    return len
}


print(result)
