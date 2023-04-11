import Foundation

/// **Prioirty Queues**
/// - Queues are simply lists that maintain the order of elements using first-in-first-out (FIFO) ordering. A priority queue is another version of a queue in which elements are dequeued in priority order instead of using FIFO ordering. For example, a priority queue can either be:
///     1. Max-priority, in which the element at the front is always the largest.
///     2. Min-priority, in which the element at the front is always the smallest.
/// - A priority queue is especially useful when identifying the maximum or minimum value given a list of elements.
///
/// **Applications**
/// - Dijkstra's algorithm
///     - which uses a priority queue to calculate the minimum cost.
/// - A * pathfinding algorithm
///     - which uses a priority queue to track the unexplored routes that will produce the path with the shortest length.
/// - Heap sort
///     - which can be implemented using a priority queue.
/// - Huffman coding
///     - that builds a compression tree. A min-priority queue is used to repeatedly find two nodes with the smallest frequencey that do not yet have a parent node.
///
/// - The priority queue will conform to the Queue protocol and implement the common operations:
/// - enqueue: Inserts an element into the queue. Returns true if the operation was successful.
/// - dequeue: Removes the element with the highest priority and returns it. Returns nil if the queue was empty.
/// - isEmpty: Checks if the queue is empty.
/// - peek: Returns the element with the highest priority without removing it. Returns nil if the queue was empty.

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct Heap<Element: Equatable> {
    var elements: [Element] = []
    
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element,Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        
        if !elements.isEmpty {
            for i in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    func peek() -> Element? {
        elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            
            parent = candidate
        }
    }
    
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    

    mutating func remove() -> Element? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        
        return elements.removeLast()
    }
    
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
}


/// **Implementation**
/// - 1. Sorted array
///     - This is useful to obtain the maximum or minimum value of an element in O(1) time.
///     - However, insertion is slow and will require O(n) since you have to insert it in order.
/// - 2. Balanced binary search tree
///     - This is useful in creating a double-ended priority queue, which features getting both the minimum and maximum value in O(logn) time. Insertion is better than a sorted array, also in O(logn).
/// - 3. Heap
///     - This is a natural choice for a priority queue. A heap is more efficient than a sorted array because a heap only needs to be partially sorted.
///     - All heap operations are O(log n) except extracting the min value from a min priority heap is a lightning-fast O(1).
///     - Likewise, extracting the max value from a max priority heap is also O(1).
struct PriorityQueue<Element: Equatable>: Queue {
    private var heap: Heap<Element>
    
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
        heap = Heap(sort: sort, elements: elements)
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var peek: Element? {
        heap.peek()
    }
    
    @discardableResult mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    
    mutating func dequeue() -> Element? {
        heap.remove()
    }
}


var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7])

while !priorityQueue.isEmpty {
    print(priorityQueue.dequeue()!)
}


/// Challenge 1. Array-based priority queue
public struct PriorityQueueArray<T: Equatable>: Queue {
    private var elements:[T] = []
    
    let sort: (Element, Element) -> Bool
    
    public init(sort: @escaping (Element,Element) -> Bool, elements: [Element] = []) {
        self.sort = sort
        self.elements = elements
        self.elements.sort(by: sort)
    }
    
    public var isEmpty: Bool {
        elements.isEmpty
    }
    
    public var peek: T? {
        elements.first
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        for (index, otherElement) in elements.enumerated() {
            if sort(element, otherElement) {
                elements.insert(element, at: index)
                return true
            }
        }
        elements.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        isEmpty ? nil : elements.removeFirst()
    }
}

extension PriorityQueueArray: CustomStringConvertible {

  public var description: String {
    String(describing: elements)
  }
}

var priorityQueueArray = PriorityQueueArray(sort: >, elements: [1,12,3,4,1,6,8,7])
priorityQueueArray.enqueue(5)
priorityQueueArray.enqueue(0)
priorityQueueArray.enqueue(10)
while !priorityQueueArray.isEmpty {
  print(priorityQueueArray.dequeue()!)
}



/// Challenge 2. Prioritize a waitlist
/// - Your favorite T-Swift concert was sold out. Fortunately, there is a waitlist for people who still want to go! However, ticket sales will first prioritize someone with a military background, followed by seniority. Write a sort function that will return the list of people on the waitlist by the priority mentioned.
public struct Person: Equatable {
    let name: String
    let age: Int
    let isMilitary: Bool
}

func tswiftSort(person1: Person, person2: Person) -> Bool {
    if person1.isMilitary == person2.isMilitary {
        return person1.age > person2.age
    }
    
    return person1.isMilitary
}


let p1 = Person(name: "aosh", age: 21, isMilitary: true)
let p2 = Person(name: "bake", age: 22, isMilitary: true)
let p3 = Person(name: "clay", age: 58, isMilitary: false)
let p4 = Person(name: "dindy", age: 28, isMilitary: false)
let p5 = Person(name: "eabrina", age: 30, isMilitary: false)

var waitlist = [p1, p2, p3, p4, p5]
print(waitlist.map { $0.name })

waitlist.sort { tswiftSort(person1: $0, person2: $1)}

print(waitlist.map { $0.name })


var priorityQueue2 = PriorityQueue(sort: tswiftSort, elements: waitlist)
while !priorityQueue2.isEmpty {
  print(priorityQueue2.dequeue()!)
}



/// Challenge 3. Minimize recharge stops
