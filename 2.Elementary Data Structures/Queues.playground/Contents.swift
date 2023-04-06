import Foundation

/// **Queues**
/// - Queue use FIFO(First-in-First-out) ordering, meaning the first element added will always be the first to be removed.
/// - Queue are handy when you need to maintain the order of your elements to process later.
/// 1. enqueue: Insert an element at the back of the queue. Returns 'true' if the operation was successful.
/// 2. dequeue: Remove the element at the front of the qeue and return it.
/// 3. isEmpty: Check if the queue is empty.
/// 4. peek: Return the element at the front of the queue without removing it.
/// - Note: Notice that the queue only cares about removal from the front and insertion at the back.
/// you don't need to know what the contents are in between. If you did, you would probably just use an array.
public protocol Queue {
    associatedtype Element
    
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

// queue in four different ways:
// 1. Using an array
// 2. Using a doubly Linked list
// 3. Using a ring buffer
// 4. Using two stacks

/// **Array-based implementation**
/// - Swift 표준 라이브러리에는 고도로 최적화된 기본 데이터 구조 집합이 포함되어 있으며, 이를 사용하여 더 높은 수준의 추상화를 구축할 수 있습니다. 그 중 하나는 Array입니다. 이는 연속적이며 순서대로 정렬된 요소 목록을 저장하는 데이터 구조입니다. 이번 섹션에서는 Array를 사용하여 큐를 생성합니다.
public struct QueueArray<T>: Queue {
    private var array: [T] = []
    
    public init() {}
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: T? {
        array.first
    }
    
    /// - Enqueueing an element is, on average, an O(1) operation. This is because the array has empty space at the back.
    /// - After adding multiple elements, the array will eventually be full. When you want to use more than the allocated space, the array must resize to make additional room.
    /// - sizing(사이즈 조정)이 O(n) 연산이지만 enqueueing(큐에 삽입)이 O(1) 연산인 것은 놀라울 수 있습니다. 크기를 조정하기 위해서는 배열이 새 메모리를 할당하고 모든 기존 데이터를 새 배열로 복사해야 하기 때문입니다.
    /// -  그러나 핵심은 이것이 매우 자주 발생하지 않는다는 것입니다.
    /// - 이는 용량(capacity)이 공간이 부족해질 때마다 2배씩 증가하기 때문입니다. 결과적으로, 연산의 분할 상환 비용(평균 비용)을 계산하면, enqueueing이 평균 O(1)임을 알 수 있습니다. 하지만 최악의 경우 성능은 복사가 수행될 때 O(n)이 됩니다.
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    /// - If the queue is empty, dequeue simply returns nil. If not, it removes the element from the front of the array and returns it.
    /// - Removing an element from the front of the queue is an O(n) operation. To dequeue, you remove the element from the beginning of the array.
    /// - This is always a linear-time operation because it requires all the remaining elements in the array to be shifted in memory. 
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

var queueArray = QueueArray<String>()

queueArray.enqueue("1")
queueArray.enqueue("2")
queueArray.enqueue("3")
queueArray.dequeue()
queueArray.peek
print(queueArray)


/// Queue DublyLinkedList
public class Node<T> {
    public var value:T
    public var next: Node<T>?
    public var prev: Node<T>?
    
    public init(value: T) {
        self.value = value
    }
}
/// Queue로 구현할거라서 push 함수를 구현할 필요가 없다.
extension Node: CustomStringConvertible {
    public var description: String {
        String(describing: value)
    }
}

public class DoublyLinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    public init() {  }
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: Node<T>? {
        head
    }
    
    public func node(at index: Int) -> Node<T>? {
        var currentIndex = 0
        var currentNode = head
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    public func push(_ value: T) {
        let newNode = Node(value: value)
        
        guard tail != nil else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.next = head
        head?.prev = newNode
        head = newNode
        
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value)
        
        guard let tailNode = tail else {
            push(value)
            return
        }
        
        newNode.prev = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    public func removeFirst() -> T? {
        if isEmpty {
            return nil
        }
        let nextNode = head?.next
        
        defer {
            nextNode?.prev = nil
            head?.next = nil
            head = nextNode
        }
        
        return head!.value
    }
    
    public func remove(_ node: Node<T>) -> T {
        let prev = node.prev
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.prev = prev
        
        if next == nil {
            tail = prev
        }
        
        node.prev = nil
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + "end!"
    }
}


extension DoublyLinkedList: Collection {
    public struct Index: Comparable {
        public var node: Node<T>?
        
        public static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?) :
                return left.next === right.next
            case (nil,nil):
                return true
            default:
                return false
            }
        }
        
        public static func < (lhs: Index, rhs: Index) -> Bool {
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
    
    public subscript(position: Index) -> T {
        position.node!.value
    }
}

var doubly = DoublyLinkedList<Int>()
doubly.removeFirst()
doubly.append(5)
doubly.append(3)
doubly.append(2)
doubly.removeFirst()
doubly
doubly.append(2)
doubly.remove(doubly.node(at: 2)!)
doubly


public class QueueLinkedList<T>: Queue {
    
    private var list = DoublyLinkedList<T>()
    
    public var values: DoublyLinkedList<T> {
        list
    }
    
    public init() { }
    
    public var isEmpty: Bool {
        list.isEmpty
    }
    
    public var peek: T? {
        list.first?.value
    }
    
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    public func dequeue() -> T? {
        list.removeFirst()
    }
}

var queueLinkedList = QueueLinkedList<String>()

queueLinkedList.enqueue("전")
queueLinkedList.enqueue("성")
queueLinkedList.enqueue("훈")
print(queueLinkedList.values)
queueLinkedList.peek
queueLinkedList.dequeue()
print(queueLinkedList.values)
queueLinkedList.enqueue("짱")
print(queueLinkedList.values)

/// QueueArray의 주요 문제 중 하나는 항목을 dequeue하는 데 선형 시간이 소요된다는 것입니다. 연결 리스트 구현을 통해 상수 시간인 O(1)으로 줄일 수 있습니다. 노드의 이전 및 다음 포인터를 업데이트하기만 하면 됩니다.
/// QueueLinkedList의 주요 약점은 표에서는 분명하지 않습니다. O(1) 성능에도 불구하고 높은 오버헤드를 가지고 있습니다. 각 요소는 전방 및 후방 참조를 위한 추가 저장소가 있어야 합니다. 또한, 각 요소를 만들 때마다 비교적 비싼 동적 할당이 필요합니다. 반면, QueueArray는 더 빠른 대량 할당을 수행합니다.
/// 할당 오버헤드를 제거하고 O(1) 디큐를 유지할 수 있는 방법이 있을까요? 큐가 고정된 크기를 초과하지 않는다는 것을 고려하지 않으면, 링 버퍼를 기반으로 한 다른 방법을 사용할 수 있습니다. 예를 들어, 다섯 명의 플레이어가 참여하는 모노폴리 게임이 있다고 가정해봅시다. 링 버퍼를 기반으로 한 큐를 사용하여 다음 차례를 기록할 수 있습니다. 링 버퍼 구현에 대해 알아보겠습니다.

/// **Ring buffer**
/// - A ring buffer 또는 Circular buffer는 고정 크기의 배열로, 더 이상 삭제할 아이템이 없을 때 배열이 시작 지점으로 되돌아가는 데이터 구조입니다.
/// 1. Create a ring buffer that has a fixed size of 4. The ring buffer has two pointers that keep track of two things:
///     1. The *read* pointer keeps track of the front of the queue.
///     2. The *write* pointer keeps track of the next available slot so that you can override existing elements that have already been read.
/// 2. Each time you add an item to the queue, the write pointer increments by one.
///     - **Notice** that the write pointer moved two more spots and is ahead of the read pointer. This means that the queue is not empty.
/// 3. Dequeuing is the equivalent of reading a ring buffer.
/// 4. Enqueueing one more item to fill up the queue
/// 5. Since the write pointer reached the end, it simply wraps around to the starting index again. **This is why the data structre is known as a circular buffer.**
/// 6. Finally, dequeue the two remaining items, The read pointer wraps to the beginning, as well.
/// 7. **As a final observation, notice that whenever the read and write pointers are at the same index, the queue is empty.**
public struct RingBuffer<T> {
    
    // 빈 공간의 배열을 만들기 위해서 ?처리
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    public var first: T? {
        array[readIndex]
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    private var availableSpaceForReading: Int {
        writeIndex - readIndex
    }
    
    public var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    private var availableSpaceForWriting: Int {
        array.count - availableSpaceForReading
    }
    
    public var isFull: Bool {
        availableSpaceForWriting == 0
    }
}

extension RingBuffer: CustomStringConvertible {
  public var description: String {
    let values = (0..<availableSpaceForReading).map {
      String(describing: array[($0 + readIndex) % array.count]!)
    }
    return "[" + values.joined(separator: ", ") + "]"
  }
}

/// - The ring buffer-based queue has the same time complexity for enqueue and dequeue as the linked list implementation. The only difference is the space complexity. The ring buffer has a fixed size, which means that enqueue can fail.
/// - So far, you have seen three implementations: a simple array, a doubly linked list and a ring buffer.
/// - Although they appear to be eminently useful, you’ll next look at a queue implemented using two stacks. You will see how its spatial locality is far superior to the linked list. It also doesn’t need a fixed size like a ring buffer.
public struct QueueRingBuffer<T>: Queue {
    private var ringBuffer: RingBuffer<T>
    
    public init(count: Int) {
        ringBuffer = RingBuffer(count: count)
    }
    
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    
    public var peek: T? {
        ringBuffer.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
}


extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: ringBuffer)
    }
}

var ringBufferQueue =  QueueRingBuffer<String>(count: 3)


ringBufferQueue.enqueue("T")
ringBufferQueue.enqueue("D")
ringBufferQueue.enqueue("D")

print(ringBufferQueue)
ringBufferQueue.enqueue("W")
print(ringBufferQueue)
ringBufferQueue.dequeue()
print(ringBufferQueue)


/// **Double-Stack**
/// - When you need to dequeue an element, you reverse the right stack and place it in the left stack so that you can
public struct QueueStack<T>: Queue {
    private var leftStack:[T] = []
    private var rightStack:[T] = []
    public init() { }
    
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}
// Compared to the array-based implementation, by leveraging two stacks, you were able to transform dequeue(_:) into an amortized O(1) operation.
// Moreover, your two-stack implementation is fully dynamic and doesn’t have the fixed size restriction that your ring-buffer-based queue implementation has. Worst-case performance is O(n) when the right queue needs to be reversed or runs out of capacity. Running out of capacity doesn’t happen very often thanks to doubling it every time it happens.
// Finally, it beats the linked list in terms of spatial locality. This is because array elements are next to each other in memory blocks. So a large number of elements will be loaded in a cache on first access. Even though arrays require O(n), for simple copy operations, it is a very fast O(n) happening close to memory bandwidth.
// A linked list wherein the elements aren’t in contiguous blocks of memory. This non-locality could lead to more cache misses, which will increase access time.
// Queue takes a FIFO strategy; an element added first must also be removed first.
// Enqueue inserts an element to the back of the queue.
// Dequeue removes the element at the front of the queue.
// Elements in an array are laid out in contiguous memory block, whereas elements in a linked list are more scattered with the potential for cache misses.
// Ring-buffer-queue-based implementation is  suitable for queues with a fixed size.
// Compared to other data structres, leveraging two stacks improves the dequeue(_:) time complexity to amortized O(1) operation.
// Double-stack implementation beats out linked list in terms of storage locality.


/// Challenge 1. Stack vs Queue
/// - Stack은   FILO 이며, UINaviagation 창 구현을 Stack으로 되어있다.
/// - Queue는 FIFO 이며, BFS 탐색을 할때 활용한다.

/// Challenge 2. Step-by-Step Diagrams
/// Challenge 3. Whose turn is it?
/// Challenge 4. Reverse Queue



/// Challenge 5. Double-ended Queue
/// - Deque is made up of common operations from the Queue and Stack data structures.
enum Direction {
    case front
    case back
}

protocol Deque {
    associatedtype Element
    var isEmpty: Bool { get }
    func peek(from direction: Direction) -> Element?
    mutating func enqueue(_ element: Element, to direction: Direction) -> Bool
    mutating func dequeue(from direction: Direction) -> Element?
}

class DequeDoubleLinkedList<Element> : Deque{
    public var list = Array<Element>()
    
    public init() { }
    
    var isEmpty: Bool {
        list.isEmpty
    }
    
    func peek(from direction: Direction) -> Element? {
        switch direction {
        case .front:
            return list.first
        case .back:
            return list.last
        }
    }
    
    func enqueue(_ element: Element, to direction: Direction) -> Bool {
        switch direction {
        case .front:
            list.insert(element, at: 0)
        case .back:
            list.append(element)
        }
        
        return true
    }
    
    func dequeue(from direction: Direction) -> Element? {
        let element: Element?
        
        switch direction {
        case .front:
            guard list.first != nil else { return nil }
            element = list.removeFirst()
        case .back:
            guard list.last != nil else { return nil }
            element = list.removeLast()
        }
        return element
    }
}

extension DequeDoubleLinkedList: CustomStringConvertible {

  public var description: String {
    String(describing: list)
  }
}

let deque = DequeDoubleLinkedList<Int>()

deque.enqueue(1, to: .back)
deque.enqueue(2, to: .back)
deque.enqueue(3, to: .back)
deque.enqueue(4, to: .back)

print(deque)

deque.enqueue(5, to: .front)
print(deque)

deque.dequeue(from: .back)
deque.dequeue(from: .back)
deque.dequeue(from: .front)
deque.dequeue(from: .front)
deque
