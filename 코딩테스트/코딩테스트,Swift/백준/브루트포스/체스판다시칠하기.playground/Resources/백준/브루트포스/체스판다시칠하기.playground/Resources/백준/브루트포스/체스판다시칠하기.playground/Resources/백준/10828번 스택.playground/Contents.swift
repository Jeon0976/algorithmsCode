import Foundation

public struct Stack {
    private var storage: [Int] = []
    
    public init() { }
    
    public mutating func push(_ elements: Int) {
        storage.append(elements)
    }
    
    public mutating func pop() -> Int {
        storage.popLast() ?? -1
    }
    
    public func peek() -> Int {
        storage.last ?? -1
    }
    
    public var size: Int {
        storage.count
    }
    
    public var isEmpty: Int {
        storage.isEmpty ? 1 : 0
    }
}

let stackCount = Int(readLine()!)!

var resultArray = [Int]()

var stack = Stack()

for _ in 0..<stackCount {
    let insideArray = readLine()!.components(separatedBy: " ")
    
    if insideArray[0] == "push" {
        stack.push(Int(insideArray[1])!)
    } else if insideArray[0] == "top" {
        resultArray.append(stack.peek())
    } else if insideArray[0] == "size" {
        resultArray.append(stack.size)
    } else if insideArray[0] == "empty" {
        resultArray.append(stack.isEmpty)
    } else {
        resultArray.append(stack.pop())
    }
}

for result in resultArray {
    print(result)
}
