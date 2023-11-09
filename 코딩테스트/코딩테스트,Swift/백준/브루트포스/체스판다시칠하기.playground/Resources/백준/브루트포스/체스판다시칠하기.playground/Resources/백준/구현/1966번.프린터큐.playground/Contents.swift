import Foundation

struct Queue {
    var leftArray = [(Int, Int)]()
    var rightArray = [(Int, Int)]()
    
    var empty: Bool {
        return leftArray.isEmpty && rightArray.isEmpty
    }
    
    var peek: (Int, Int) {
        leftArray.isEmpty ? rightArray.first! : leftArray.last!
    }
    
    var max: Int? {
        let allValues = leftArray + rightArray
        let maxNum = allValues.max { $0.1 < $1.1 }
        
        return maxNum?.1
    }
    
    mutating func push(_ value: (Int,Int)) {
        rightArray.append(value)
    }
    
    mutating func pop() -> (Int, Int) {
        
        if leftArray.isEmpty {
            leftArray = rightArray.reversed()
            rightArray.removeAll()
        }
        
        return leftArray.removeLast()
    }
}

let testCase = Int(readLine()!)!

for _ in 0..<testCase {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    let M = testArray[1]
    
    let queueArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    var maxNum = queueArray.max()

    var queue = Queue()

    var result = 0
    
    for (index, value) in queueArray.enumerated() {
        queue.push((index, value))
    }
    
    while !queue.empty {
        if queue.peek.0 == M && queue.peek.1 == maxNum {
            queue.pop()
            result += 1
            break
        } else {
            if queue.peek.1 == maxNum {
                let test = queue.pop()
                result += 1
                maxNum = queue.empty ? nil : queue.max
            } else {
                queue.push(queue.pop())
            }
        }
    }
    print(result)
}
