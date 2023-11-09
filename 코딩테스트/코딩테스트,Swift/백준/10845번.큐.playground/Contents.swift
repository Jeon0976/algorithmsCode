import Foundation

public struct QueueStack {
    private var leftStack: [Int] = []
    private var rightStack: [Int] = []
    
    public var isEmpty: Int {
        leftStack.isEmpty && rightStack.isEmpty ? 1 : 0
    }
    
    public var size: Int {
        leftStack.count + rightStack.count
    }
    
    public var front: Int {
        leftStack.isEmpty ? rightStack.first ?? -1 : leftStack.last ?? -1
    }
    
    public var back: Int {
        rightStack.isEmpty ? leftStack.first ?? -1 : rightStack.last ?? -1
    }
    
    public mutating func push(_ element: Int) {
        rightStack.append(element)
    }
    
    public mutating func pop() -> Int {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast() ?? -1
    }
}


let queueCount = Int(readLine()!)!
var queue = QueueStack()

var resultArray = [Int]()

for _ in 0..<queueCount {
    let valueArray = readLine()!.components(separatedBy: " ")
    
    if valueArray[0] == "push" {
        queue.push(Int(valueArray[1])!)
    } else if valueArray[0] == "front" {
        resultArray.append(queue.front)
    } else if valueArray[0] == "back" {
        resultArray.append(queue.back)
    } else if valueArray[0] == "empty" {
        resultArray.append(queue.isEmpty)
    } else if valueArray[0] == "size" {
        resultArray.append(queue.size)
    } else {
        resultArray.append(queue.pop())
    }
}

for result in resultArray {
    print(result)
}
