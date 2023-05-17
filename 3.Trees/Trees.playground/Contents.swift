import Foundation


public struct Queue<T> {
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    
    public init() { }
    
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    // 'count' 변수의 값을 외부에서는 읽을 수 있지만, 변경은 클래스나 구조체 내부에서만 가능합니다. 이것은 보통 내부적으로 사용되는 변수의 값이 외부에서 변경되지 않도록 제한하고자 할 때 유용하게 사용됩니다. 이런 방법으로 변수를 선언하면 외부에서 의도하지 않은 변경을 방지할 수 있으며, 코드의 안정성을 높일 수 있습니다.
    public private(set) var count = 0
    
    @discardableResult public mutating func enqueue(_ element: T) -> Bool {
        count += 1
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        let value = leftStack.popLast()
        
        if value != nil {
            count -= 1
        }
        return value
    }
}

/// Tree is a data structure of profound importance. It is used in numerous facets of software development, such as
/// 1. Representing hierarchical relationships.
/// 2. Managing sorted data.
/// 3. Facilitating fast lookup operations.
/// There are many types of trees, and they come in various shapes and sizes.

/// Terminology
/// - **Node**
/// - Like the linked list, trees are made up of nodes.
/// - Each node can carry some data and keeps track of its children.
/// - **Parent and child**
/// - Trees are viewed starting from the top and branching towards the bottom, just like a real tree, only upside-down.
/// - Every node (except for the topmost one) connects to exactly one node above it.
/// - That node is called a parent node. The nodes direclty below and connected to it are called its child nodes.
/// - In a tree, every child has exactly one parent.
/// - **Root**
/// - The topmost node in the tree is called the root of the tree.
/// - It is the only node that has no parent
/// - **Leaf**
/// - A node is a leaf it it has no children
/// - NOTE: TreeNode을 나타내는 데 클래스 타입을 사용하면 값 타입 의미를 잃게 됩니다. 반면에, 노드에 대한 참조를 만드는 것은 매우 간단합니다.
public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []
    
    /// Challenge 2: Parents and ownership
    /// - 여기서 parent 속성에 optional 타입을 사용하고, weak 참조를 적용했습니다. 이는 노드가 부모 노드를 가지지 않을 경우 nil 값으로 초기화되어야 하기 때문입니다. 또한, weak 참조를 사용하면 노드 간에 발생할 수 있는 순환 참조(reference cycle)를 방지할 수 있습니다.
    /// - 코드에서 언급된 바와 같이, 트리의 노드들은 자식 노드들과 강한 참조 관계를 가지고 있지만, 부모 노드와는 약한(non-ownership) 참조 관계를 가지고 있다는 것을 권장하고 있습니다. 이것은, 양방향 연결 리스트와 유사한 구조이며, 노드 간의 상하 관계를 빠르게 이동할 수 있도록 해줍니다.
    public weak var parent: TreeNode?
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}


let beverages = TreeNode("Beverages")

let hot = TreeNode("Hot")
let cold = TreeNode("Cold")

beverages.add(hot)
beverages.add(cold)


/// **Depth-first traversal (DFT)**
/// - A technique that starts at the root and visits nodes as deep as it can before backtracking.
extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
        
    }
}

/// **Level-order traversal (LOT)**
/// - forEachLevelOrder visits each of the nodes in level-order
/// - Note how you used a queue (not a stack) to ensure you visit nodes in the right level order.
/// - A simple recursion (which implicitly uses a stack) would not have worked.
/// 즉, 이 코드에서는 재귀 호출 대신 큐를 사용하여 레벨 순서대로 노드를 방문하도록 구현했다는 것을 나타냅니다. 일반적으로 재귀 호출을 사용하여 깊이 우선 탐색을 수행할 때는, 스택을 사용하여 방문한 노드를 기록하고 백트래킹(backtracking)을 수행하는데 반해, 이 코드에서는 큐를 사용하여 레벨 단위로 방문한 노드를 기록하고 순차적으로 처리합니다.
/// 따라서, 이 코드에서는 규를 사용하여 레벨 순서대로 노드를 처리하는 너비 우선 탐색(breadth-frist traversal) 알고리즘을 사용하였고, 스택을 사용하는 깊이 우선 탐색과는 구현 방식이 다르다는 것이 중요한 포인트입니다.
extension TreeNode {
    public func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
    
    // Challenge 1
    public func forEachLevelOrderPrint() {
        var queue = Queue<TreeNode>()
        var nodeLeftInCurrentLevel = 0
        queue.enqueue(self)
        
        while !queue.isEmpty {
            
            nodeLeftInCurrentLevel = queue.count
            
            while nodeLeftInCurrentLevel > 0 {
                guard let node = queue.dequeue() else { break }
                print("\(node.value) ", terminator: "")
                node.children.forEach { queue.enqueue($0) }
                nodeLeftInCurrentLevel -= 1
            }
            print()
        }
    }
}

extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        return result
    }
}


func makeBeverageTree() -> TreeNode<String> {
  let tree = TreeNode("Beverages")

  let hot = TreeNode("hot")
  let cold = TreeNode("cold")

  let tea = TreeNode("tea")
  let coffee = TreeNode("coffee")
  let chocolate = TreeNode("cocoa")

  let blackTea = TreeNode("black")
  let greenTea = TreeNode("green")
  let chaiTea = TreeNode("chai")

  let soda = TreeNode("soda")
  let milk = TreeNode("milk")

  let gingerAle = TreeNode("ginger ale")
  let bitterLemon = TreeNode("bitter lemon")

  tree.add(hot)
  tree.add(cold)

  hot.add(tea)
  hot.add(coffee)
  hot.add(chocolate)

  cold.add(soda)
  cold.add(milk)

  tea.add(blackTea)
  tea.add(greenTea)
  tea.add(chaiTea)

  soda.add(gingerAle)
  soda.add(bitterLemon)

  return tree
}

let tree = makeBeverageTree()
//tree.forEachDepthFirst { tree in
//    print(tree.value)
//}


//tree.forEachLevelOrder { tree in
//    print(tree.value)
//}

tree.forEachLevelOrderPrint()
//tree.forEachDepthFirst { print($0.value)}
tree.forEachLevelOrder { print($0.value)}
//if let searchResult1 = tree.search("ginger ale") {
//  print("Found node: \(searchResult1.value)")
//}
//
//if let searchResult2 = tree.search("WKD Blue") {
//   print(searchResult2.value)
// } else {
//   print("Couldn't find WKD Blue")
// }


