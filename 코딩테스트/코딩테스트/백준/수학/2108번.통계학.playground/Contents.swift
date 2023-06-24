import Foundation

let testCase = Int(readLine()!)!

var numArray = [Int]()

for _ in 0..<testCase {
    let value = Int(readLine()!)!
    numArray.append(value)
}

func mean (_ numArray: [Int]) -> Int {
    let mean = Double(numArray.reduce(0, +))/Double(numArray.count)

    return Int(round(mean))
}

func median (_ numArray: [Int]) -> Int {
    let numArray = numArray.sorted()
    
    return numArray[numArray.count/2]
}

func mode (_ numArray: [Int]) -> Int {
    var checkDict = [Int: Int]()
    
    for num in numArray {
        checkDict[num, default: 0] += 1
    }
    
    let maxCount = checkDict.values.max()
    
    let mode = checkDict.filter { $1 == maxCount }.keys.sorted()
        
    if mode.count > 1 {
        return mode[1]
    }
    return mode[0]
}

func range (_ numArray: [Int]) -> Int {
    return numArray.max()! - numArray.min()!
}

let functionArray = [mean(numArray), median(numArray), mode(numArray), range(numArray)]

functionArray.forEach {
    print($0)
}
