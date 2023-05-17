import Foundation

/// **Heaps**
/// - Heaps are another classical tree-based data structure with special properties for making it great for quickly fetching the largest or smallest element.
/// - A heap is a complete binary tree, also known as a binary heap, that can be constructed using an array.
/// - Heaps come in two flavors
/// - 1. Max heap, in which elements with a higher value have a higher priority.
/// - 2. Min heap, in which elements with a lower value have a higher priority.
///
/// **The heap property(힙 특성)**
/// - A heap has an essential characteristic that must always be satisfied.
/// - This characteristic is known as the heap invariant(힙 불변성) or heap property(힙 특성).
/// - In a max heap, parent nodes must always contain a value that is greater than or equal to the value in its childre.
///     - The root node will always contain the highest value.
/// - In a min heap, parent nodes must always contain a value that is less than or equal to the value in its children.
///     - The root node will always contain the lowest value.
/// - Another essential property of a heap is that it is a nearly complete binary tree.
/// - This means that every level must be filled, except for the last level. It's like a video game wherein you can't go to the next level until you have completed the current one.
///
/// **Heap applications**
/// 1. Calculating the minimum or maximum element of a collection.
/// 2. Heapsort.
/// 3. Constructing a priorty queue.
/// 4. Constructing graph algorithms, like Prim's or Dijkstra's, with a priority queue.
/// - NOTE:  This type contains an array to hold the elements in a heap and a sort function that defines how the heap should be ordered. By passing an appropriate function in the initializer, this type can create both min and max heaps.
struct Heap<Element: Equatable> {
    var elements: [Element] = []
    
    let sort: (Element,Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool,elements: [Element] = []
    ) {
        self.sort = sort
        self.elements = elements
        
        /// - The initializer now takes an additional parameter. If a non-empty array is provided, you use this as the element for the heap. To satisfy the heap’s property, you loop through the array backward, starting from the first non-leaf node, and sift down all parent nodes.
        /// - You loop through only half of the elements because there is no point in sifting down leaf nodes, only parent nodes.
        /// 사실 elements.count 그대로 해도 문제없지만, 계산을 줄이기 위해서는 자식 노드만 있는 것부터 계산 하면 되니깐, elements.count / 2 -1
        if !elements.isEmpty {
            for i in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    /// **How do you represent a heap?**
    /// - Trees hold nodes that store references to their children. In the case of a binary tree, these are references to a left and right child.
    /// - Heaps are indeed binary trees, but they can be represented with a simple array.
    /// - This representation might seem like an unusual way to build a tree. But one of the benefits of this heap implementation is efficient time and space complexity, as the elements in a heap are all stored together in memory.
    /// - Swapping elements is easier to do with an array than with a binary tree data structure.
    /// - To represent the heap above as an array, you iterate through each element level-by-level from left to right.
    /// - As you go up a level, you’ll have twice as many nodes than in the level before.
    /// - It's now easy to access any node in the heap.
    /// - You can compare this to how you'd access elements in an array, Instead of travering down the left or right branch, you can access the node in your array using simple formulas.
    /// - Given a node at a zero-based index : i
    ///     - The left child of this node is at index 2i + 1
    ///     - The right child of this node is at index 2i + 2
    /// - You might want to obtain the parent of a node. You can solve for i in this case.
    ///     - Given a child node at index i, this child's parent node can be found at index floor( (i-1) / 2).
    /// - Travering down an actual binary tree to get the left and right child of a node is a O(logn) operation. That same operatoin is just O(1) in a random-access data structure, such as an array.
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
    
    /// **Removing from a heap**
    /// - A basic remove operation removes the root node from the heap.
    ///     1. A remove opeartion will remove the maximum value at the root node. To do so, you must first swap the root node with the last element in the heap.
    ///     2. Once you've swapped the two elements, you can remove the last element and store its value so you can later return it.
    ///     3. Since the heap no longer follows max heap rules, you must perfom a sift down.
    /// - Complexity: The overall complexity of remove() is O(log n). Swapping elements in an array takes only O(1) while sifting down elements in a heap takes O(log n) time.
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
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        
        // Continue sifting until you return.
        // 배열의 count가 선행 조건에 없으면 에러
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
    
    /// **Inserting into a heap**
    /// - First, you add the value to the end of the heap
    /// - And, you must check the max heap's property. Instead of sifting down, you must now sift up since the node that you just inserted might have a higher priority than its parents.
    /// - This sifting up works much like sifting down by comparing the current node with its parent and swapping them if needed.
    /// - Complexity: The overall complexity of insert(_:) is O(log n). Appending an element in an array takes only O(1) while sifting up elements in a heap takes O(log n).
    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    
    // 복습 필요 (Insert 할 때만 추가)
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
    
    /// **Removing from an arbitrary index**
    /// - To remove any element from the heap, you need an index.
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else {
            return nil
        }
        
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
        }
        
        return elements.removeLast()
    }
    
    /// **Searching for an element in a heap**
    /// - To find the index of the element you wish to delete, you must perform a search on the heap.
    /// - Unfortunately, heaps are not designed for fast searches. With a binary search tree, you can perform a search in O(log n) time, but since heaps are built using an array, and the node ordering in an array is different, you can’t even perform a binary search.
    /// - Complexity: To search for an element in a heap is, in the worst-case, an O(n) operation, since you may have to check every element in the array
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        
        // 인덱스 i에 현재 요소보다 우선순위가 높은 값을 찾는지 확인.
        // 만약 더 높은 값이 있다면. return nil
        // 예) elements[0] = 15
        // 16 > 15
        if sort(element, elements[i]) {
            return nil
        }
        
        if element == elements[i] {
            return i
        }
        
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        
        return nil
    }
}
// count를 활용해서 index overflow 읽는거 방지 가능
var arrw = [1,2,3,4]
if 6 < arrw.count, arrw[6] < arrw[1] {
    print(true)
} else {
    print(false)
}

var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])
var heap2 = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])

print(heap)
print(heap2)

heap.index(of: 7, startingAt: 0)
//heap.remove(at: 7)
heap.count


/// Challenge 1. Find the nth smallest integer
func findSmallest(_ n:Int, _ array:[Int]) -> Int? {
    if n > array.count {
        return nil
    }
    
    var heap = Heap(sort: <, elements: array)
    var current = 1
    
    while !heap.isEmpty {
        let element = heap.remove()
        if current == n {
            return element
        }
        current += 1
    }
    
    return nil
}
heap.elements

findSmallest(5, heap.elements)
 


/// Challenge 2. Step-by-Step diagram

/// Challenge 3. Combinig two heaps
extension Heap {
    mutating func buildHeap1() {
        if !elements.isEmpty {
            for i in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    mutating func buildHeap2() {
        if !elements.isEmpty {
            for i in stride(from: count - 1, through: count / 2 - 1, by: -1) {
                siftUp(from: i)
            }
        }
    }
    
    mutating public func merge(_ heap: Heap) {
        elements = elements + heap.elements
        
        buildHeap1()
    }
    
    
}
var heapTest = Heap(sort: <, elements: [1,2,3,4,3,1,32,45,32])

print(heapTest)
heapTest.buildHeap1()
print(heapTest)
heapTest.buildHeap2()
print(heapTest)

print(heap)
heap.merge(heap2)
print(heap)

/// Challenge 4. A Min Heap?
/// - Write a function to check if a given array is a min-heap.
/// - To check if the given array is a min-heap, you only need to go through all the parent nodes of the binary heap.
/// - To satisfy the min-heap requirement, every parent node must be less than or equal to its left and right child node.
func leftChildIndex(ofParentAt index: Int) -> Int {
    (2 * index) + 1
}

func rightChildIndex(ofParentAt index: Int) -> Int {
    (2 * index) + 2
}

func isMinHeap<Element: Comparable>(elements: [Element]) -> Bool {
    guard !elements.isEmpty else {
        return true
    }

    for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
        let left = leftChildIndex(ofParentAt: i)
        let right = rightChildIndex(ofParentAt: i)
        if elements[left] < elements[i] {
            return false
        }
        if right < elements.count && elements[right] < elements[i] {
            return false
        }
    }

    return true
}



7/2-1
1/2
2/2
3/2

