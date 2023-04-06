/// Stack의 예시
/// 1. iOS uses the navigation stack to push and pop view controllers into and out of view
/// 2. Memory allocation uses stacks at the architectural level. Memory for local variables is also managed using a stack.
/// 3. Search and conquer algorithms, such as finding a path out of a maze, use stacks to facilitate backtracking.

import Foundation

/// Stack 자료구조 생성
/// A stack is a LIFO, last-in first-out, data structure.
/// Despite being so simple, the stack is a key data structure for many problems.
/// The only two essential operations for the stack are the push method for adding elements and the pop method for removing elements.
public struct Stack<Element> {
    private var storage: [Element] = []
    
    public init() { }

    /// 배열을 받아서 Stack으로 전환
    public init(_ elements: [Element]) {
        storage = elements
    }
    /// Push Operation
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    /// Pop Operation
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    /// Non-essential operatation
    /// There are a couple of nice-to-have operations that make a stack easier to use.
    /// A stack interface often includes a peek operation. The idea of peek is to look at the top element of the stack without mutating its contents.
    public func peek() -> Element? {
        // 스택의 마지막 요소 확인하기
        storage.last
    }
    
    public var isEmpty: Bool {
        peek() == nil
    }
    
    ///Challenge1: Reverse an Array
    /// - My Solution
    /// - Create a function that uses a stack to print the contents of an array in reversed order.
    /// - 문제를 잘 못 이해함
    /// - stack을 써서 array을 반대로 프린트하는 방법을 출력하라...
    public func reversdOrder() -> [Element] {
        return storage
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

/// stack의 진행과정을 보기 쉽게 customizing
extension Stack: CustomStringConvertible {
    public var description: String {
        " Top: \(storage.map { "\($0)"}.reversed().joined(separator: " ")) : Bottom"
    }

}


///Challenge1: Reverse an Array
/// - Book Solution
/// - Create a function that uses a stack to print the contents of an array in reversed order.
/// - The time complexity of pushing the nodes into the stack is O(n). The time complexity of popping the stack to print the values is also O(n). Overall, the time complexity of this algorithm is O(n).
/// - Since you’re allocating a container (the stack) inside the function, you also incur a O(n) space complexity cost.
/// - Note: The way you should reverse an array in production code is to call the reversed() method that the standard library provides. For Array, this method is O(1) in time and space. This is because it is lazy and only creates a reversed view into the original collection. If you traverse the items and print out all of the elements, it predictably makes it O(n) in time while remaining O(1) in space.
public func printInReverse<T>(_ array: [T]) {
    var stack: Stack<T> = Stack()
    
    for value in array {
        stack.push(value)
    }
    
    while let value = stack.pop() {
        print(value)
    }
}


///Challenge2: Balance the parentheses
/// - MySolution
/// - Check for balanced parentheses. Given a string, check if there are "(" and ")" characters, and return true if the parentheses in the string are balanced.
///  - The time complexity of this algorithm is O(n), where n is the number of characters in the string. This algorithm also incurs an O(n) space complexity cost due to the usage of the Stack data structure.
public func checkBalancedParentheses(_ string: String) -> Bool {
    // stack을 두개 만들어서??
    var stack: Stack<String> = Stack()
    
    for value in string {
        if value == "(" {
            stack.push("+")
        } else if value == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }

    return stack.isEmpty
}

checkBalancedParentheses("h((e))llo(world)() ")
checkBalancedParentheses("(hello world ")
printInReverse([1,2,3,4,5,5,6,7,8,8])
var stack = Stack<Int>()
stack.push(1)
stack.push(2)
stack.push(3)
stack.push(4)

print(stack)
stack.pop()
print(stack)
stack.peek()
stack
stack.isEmpty


let array = ["a","b","c","d"]
var stack2 = Stack(array)
print(stack2)

var stack3: Stack = [1,2,3,4,5]
var stack4: Stack = ["A","B"]
var stack5: Stack = ["s",1,nil] as Stack<Any?>
stack3
stack3.reversdOrder()
