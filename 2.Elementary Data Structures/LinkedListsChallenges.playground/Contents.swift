import Foundation

public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value) 끝!"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}


public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        
        if isEmpty {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        
        tail = tail!.next
    }
    
    public mutating func insert(_ value: Value,
                                after node: Node<Value> )
    -> Node<Value> {
        guard let node = copyNodes(returningCopyOf: node) else {
            guard tail !== node else {
                append(value)
                return tail!
            }
            
            node.next = Node(value: value,next: node.next)
            
            return node.next!
        }
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value,next: node.next)
        
        return node.next!
    }
    
    public mutating func pop() -> Value? {
        copyNodes()
    
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    public mutating func removeLast() -> Value? {
        copyNodes()
        
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    public mutating func remove(after node: Node<Value>) -> Value? {
        guard let node = copyNodes(returningCopyOf: node) else {
            defer {
                if node.next == nil {
                    tail = node
                }
                node.next = node.next?.next
            }
            return node.next?.value
        }
        defer {
            if node.next == nil {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        
        guard var oldNode = head else {
            return
        }
        
        head = Node(value: oldNode.value)
        
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        
        guard var oldNode = head else {
            return nil
        }
        
        head = Node(value: oldNode.value)
        
        var newNode = head
        var nodeCopy: Node<Value>?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        
        return nodeCopy
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?

        public static func < (lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains{ $0 === rhs.node }
        }
        
        public static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
    }
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        position.node!.value
    }
}

var list = LinkedList<Int>()
list.push(1)
list.append(2)
list.append(3)
list.append(4)

/// Challenge 1: Print in reverse
/// - Create a function that prints the nodes of a linked list in revers order.
func printReversedNode<T>(_ node: Node<T>?)  {
    guard let node = node else { return }
    
    printReversedNode(node.next)
    print(node.value)
}

func printReversedLinkedList<T>(_ list: LinkedList<T>) {
    printReversedNode(list.head)
}
printReversedNode(list.head)
printReversedLinkedList(list)
5/2
/// Challenge 2: Find the middle node
/// - Create a function that finds the middle node of a linked list.
func whatIsMiddleValue<T>(_ list: LinkedList<T>) -> Node<T>? {
    var middleCount = Int(ceil(Double(list.count + 1) / Double(2)))
    var count = 1
    var currentNode = list.head
    
    while (currentNode?.next) != nil {
        count += 1
        currentNode = currentNode?.next
        if count == middleCount {
            return currentNode
        }
    }
    return currentNode
}

// 한칸 이동할때 두칸 이동하면 collection protocol 구현 안해도 해결
// nil도 포함
// runner's technique
// In the while declaration, you bind the next node to nextFast. If there is a next node, you update fast to the next node of nextFast, effectively traversing the list twice. The slow pointer is updated only once. This is known as the runner’s technique.
func getMidde<T>(_ list: LinkedList<T>) -> Node<T>? {
    var slow = list.head
    var fast = list.head
    
    while let nextFast = fast?.next {
        fast = nextFast.next
        slow = slow?.next
    }
    return slow
}

var list2 = LinkedList<Int>()
list2.append(1)
getMidde(list)
getMidde(list2)

whatIsMiddleValue(list)
// Collection Protocol를 사용하지 않고 구현하는 방법
func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
    var slow = list.head
    var fast = list.head
    
    while let nextFast = fast?.next {
        fast = nextFast.next
        slow = slow?.next
    }
    
    return slow
}
getMiddle(list)
print(list)
/// Challenge 3: Reverse a linked list
/// - Create a function that reverses a linked list. you do this by manipulating the nodes so that they're linked in the other direction.
func reverseLinkedList<T>(_ list: LinkedList<T>) -> LinkedList<T> {
    // head 와 tail 바꾸고
    // head.next 와 tail 직전의 node 바꾸고
    // if head.next 와 tail부터 거꾸로 간것이 같으면 return
    // if 둘 위치 역전되면 return
    // 중간값 까지 가는걸로 구현
    var list = list
    var prev = list.head
    var current = list.head?.next
    prev?.next = nil
    
    while current != nil {
        let next = current?.next
        current?.next = prev
        prev = current
        current = next
    }
    
    list.head = prev
    return list
}
list = reverseLinkedList(list)

extension LinkedList {
    mutating func reverse() {
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        head = prev
    }
}
list.reverse()


print(list)
list.append(2)
/// Challenge 4: Merge two lists
/// - Create a function that takes two sorted linked lists and merges them into a single sorted linked list. your goal is to return a new linked list that contains the nodes from two lists in sorted order. you may assume the sort order is ascending.
func mergeSorted<T: Comparable>(_ left:LinkedList<T>, _ right:LinkedList<T>) -> LinkedList<T> {
//    guard !left.isEmpty else {
//        return right
//    }
//
//    guard !right.isEmpty else {
//        return left
//    }
    
    var newHead: Node<T>?
    var tail: Node<T>?
    
    var currentLeft = left.head
    var currentRight = right.head
    
    // 이건 왜 함?
    // 시작 값을 새롭게 빼주기 위해?
    if let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            newHead = leftNode
            currentLeft = leftNode.next
        } else {
            newHead = rightNode
            currentRight = rightNode.next
        }
        tail = newHead
    }
    
    while let leftNode = currentLeft, let rightNode = currentRight {
        if leftNode.value < rightNode.value {
            tail?.next = leftNode
            currentLeft = leftNode.next
        } else {
            tail?.next = rightNode
            currentRight = rightNode.next
        }
        tail = tail?.next
    }
    
    if let leftNodes = currentLeft {
        tail?.next = leftNodes
    }
    
    if let rightNodes = currentRight {
        tail?.next = rightNodes
    }
    
    var list = LinkedList<T>()
    list.head = newHead
    list.tail = {
        while let next = tail?.next {
            tail = next
        }
        return tail
    }()
    
    return list
}

var list3 = LinkedList<Int>()
var list4 = LinkedList<Int>()
var list22 = LinkedList<Int>()
list3.push(3)
list3.push(2)
list3.push(1)

list4.push(5)
list4.push(-2)
list4.push(-3)

print(mergeSorted(list3, list4))

/// Challenge 5: Remove all occurrences
/// - Create a function that removes all occurrences of a specific element from a linked list. The implementation is simiar to the remove(at: ) method you implemented for the linked list.

extension LinkedList where Value: Equatable{
    mutating func removeAll(_ value: Value) {
        while let head = self.head, head.value == value {
            self.head = head.next
        }
        
        var prev = head
        var current = head?.next
        while let currentNode = current {
            guard currentNode.value != value else {
                prev?.next = currentNode.next
                current = prev?.next
                continue
            }
            prev = current
            current = current?.next
        }
        tail = prev
    }
}

var list5 = LinkedList<Int>()
list5.push(3)
list5.push(2)
list5.push(2)
list5.push(1)
list5.push(1)
list5.removeAll(1)
print(list5)


