/// 공부 완료 후 '프로그래밍 면접 이렇게 준비한다.' 문제 풀어보기
///
///

import Foundation

/// **Node** LinkedLists
/// - A linked list is a collection of values arranged in a linear, unidirectional sequence.
/// - Constant time insertion and removal from the front of the list.
/// - Reliable performance characteristics.
/// - Note: Nodes have two responsibilites.
/// 1. Hold a value.
/// 2. Hold a reference to the next node. A nil value represents the end of the list.
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

let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

node2.next = nil


/// **LinkedList**
/// - A linked list has the concept of a head and tail, which refers to the first and last nodes of the list
/// - Note: **Adding values to the list**
///  1. **push**: Adds a value at the front of the ilst.
///  2. **append**: Adds a value at the end of the list.
///  3. **insert(after: )**: Adds a value after a particular list node.
/// - Note: **Removing values from the list**
/// 1. **pop**: Removes the value at the front of the list.
/// 2. **removeLast**: Removes the value at the end of the list.
/// 3. **remove(at:)**: Removes a value anywhere in the list.
public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    
    /// - This is also known as head-first insertion.
    /// - If you're pushing into an empty list, the new node is both the head and tail of the list.
    /// - Time complexity : O(1)
    public mutating func push(_ value: Value) {
        copyNodes()

        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /// - This adds a value at the end of the list, known as tail-end insertion.
    /// - Time complexity: O(1)
    public mutating func append(_ value: Value) {
        copyNodes()
        /// Like before, if the list is empty, you’ll need to update both head and tail to the new node. Since append on an empty list is functionally identical to push, you invoke push to do the work for you.
        guard !isEmpty else {
            push(value)
            return
        }
        /// You create a new node after the tail node in all other cases. Force unwrapping is guaranteed to succeed since you push in the isEmpty case with the above guard statement.
        tail!.next = Node(value: value)
        
        /// Since this is tail-end insertion, your new node is also the tail of the list.
        tail = tail!.next
    }
    
    
    /// - Before using insert(after:), you'll implement the code to find the node where you want to insert your value.
    /// - Time complexity: O(n), where n is the given index
    public func node(at index: Int) -> Node<Value>? {
        
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    /// - Time complexity: O(1)
    @discardableResult
    public mutating func insert(_ value: Value,
                                after node: Node<Value>
    ) -> Node<Value> {
//        if node === head {
//            let node = copyNodes(returningCopyOf: node)!
//
//            guard tail !== node else {
//                append(value)
//                return tail!
//            }
//
//            node.next = Node(value: value, next: node.next)
//            return node.next!
//
//        } else {
//            copyNodes()
//        }
        
        guard let node = copyNodes(returningCopyOf: node) else {
            guard tail !== node else {
                append(value)
                return tail!
            }
            
            node.next = Node(value: value, next: node.next)
            return node.next!
        }
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    /// pop returns the value that was removed from the list. This value is optional since the list may be empty.
    /// - By moving the head down a node, you've effetively removed the first node of the list. ARC will remove the old node from memory once the method finishes since no more references will be attached to it. the list becomes empty, you set tail to nil.
    /// - Time complexity: O(1)
    @discardableResult
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
    
    /// Removing the last node of the list is somewhat inconvenient.
    /// - Although you have a reference to the tail node, you can't chop it off without having a reference to the node before it.
    /// - Thus, you'll have to do an arduous traversal.
    /// - Time complexity: O(n)
    @discardableResult
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
    
    /// You'll first find the node immediately before the node you wish to remove and then unlink it.
    /// - Time complexity: O(1)
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
//        if node === head {
//            let node = copyNodes(returningCopyOf: node)!
//
//            defer {
//                if node.next === tail {
//                    tail = node
//                }
//                node.next = node.next?.next
//            }
//            return node.next?.value
//        } else {
//            copyNodes()
//        }
        
        guard let node = copyNodes(returningCopyOf: node) else {
            defer {
                if node.next === tail {
                    tail = node
                }
                node.next = node.next?.next
            }
            return node.next?.value
        }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    

    private mutating func copyNodes() {
        // 유니크할때 그냥 패스
        // 의미없는 복사행동 안함
        guard !isKnownUniquelyReferenced(&head) else {
            print("Test")
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

/// The startIndex and endIndex properties
/// A subscript that provides at least read-only access to your type’s elements
/// The index(after:) method for advancing an index into your collection
extension LinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        // 1번 노드가 < 3번 노드 이면 true를 나타내는 함수식
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else { return false }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
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
func print(address o: UnsafeRawPointer) {
    print(String(format: "%p", Int(bitPattern: o)))
}
var list = LinkedList<Int>()
list.push(1)
list.push(2)
list.push(3)
list.push(4)
print(address: &list.head)
var list55 = list
print(address: &list55.head)
print(address: &list.head)
isKnownUniquelyReferenced(&list.head)

list.insert(44, after: list.node(at: 2)!)
//list.remove(after: list.node(at: 2)!)

print(list55)
print(list)

list.push(2)


print(list55)
print(list)

//list.pop()

//print(list)
//print(list.tail!)

//list.removeLast()

//print(list)
isKnownUniquelyReferenced(&list.head)

list.remove(after: list.node(at: 0)!)
isKnownUniquelyReferenced(&list.head)

print(list)

for i in 0...9 {
    list.append(i)
}

//print(list)
list[list.startIndex]
Array(list.prefix(5))
Array(list.suffix(5))

list.reduce(0, +)
isKnownUniquelyReferenced(&list.head)

var list2 = list

isKnownUniquelyReferenced(&list2.head)

isKnownUniquelyReferenced(&list.head)

print(list)
print(list2)

list2.append(5)
isKnownUniquelyReferenced(&list2.head)
isKnownUniquelyReferenced(&list.head)

print("1 test\(list2)")
if let node = list2.node(at: 1) {
    list2.remove(after: node)
}
isKnownUniquelyReferenced(&list2.head)
print("2 test\(list2)")

list2.remove(after: list.node(at: 1)!)

print("3 test\(list2)")
list2.remove(after: list2.node(at: 1)!)

print("4 test\(list2)")
list2.remove(after: list2.node(at: 2)!)

isKnownUniquelyReferenced(&list2.head)

print("5 test\(list2)")

if let node = list.node(at: 0) {
    list2.remove(after: node)
}
isKnownUniquelyReferenced(&list2.head)

list2.removeLast()
print(list2)
list2.insert(5, after: list2.node(at: 0)!)
list2.insert(5, after: list2.node(at: 0)!)

print(list2)
isKnownUniquelyReferenced(&list2.head)
print(list)
var list3 = LinkedList<Int>()
isKnownUniquelyReferenced(&list3.head)

(1...3).forEach { list3.append($0)}
isKnownUniquelyReferenced(&list3.head)

var list4 = list3
isKnownUniquelyReferenced(&list3.head)
list4.push(5)
print(list3)
isKnownUniquelyReferenced(&list3.head)
list3.push(100)
list3.pop()
list4.pop()
isKnownUniquelyReferenced(&list3.head)
list3
list4
list3.pop()
list3
list4
if let node = list4.node(at: 1) {
    list4.remove(after: node)
}
//list4.remove(after: list4.node(at: 1)!)
print(list4)
list3.reversed()


var list5 = LinkedList<Int>()
(1...3).forEach { list5.append($0)}
var list6 = list5

isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
list6.push(5)
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
print(list5)
print(list6)
list5.push(100)
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
print(list5)
print(list6)
list6.removeLast()
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
print(list5.tail!)
// 해드 값만 유니크 됨
// 하지만 기존 내가 만든 함수를 적용하면??
isKnownUniquelyReferenced(&list5.head!.next!.next)
//list5.head?.next?.next?.next = list5.tail
print("last:\(list5)")
print("last:\(list6)")
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
list5.removeLast()
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
print(list5.tail!)
print(list5)
print(list6)
list6.pop()
isKnownUniquelyReferenced(&list5.tail)
isKnownUniquelyReferenced(&list5.head)
isKnownUniquelyReferenced(&list6.tail)
isKnownUniquelyReferenced(&list6.head)
print(list5)
print(list6)

list5.endIndex.node
