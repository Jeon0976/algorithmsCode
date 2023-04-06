import Foundation


/// **Binary Tree**
/// - A binary tree is a tree where each node has at most two children, often referred to as the left and right children.
/// - Binary trees serve as the basis for many tree structures and algorithms.
/// - The binary tree is the foundation of some of the most important tree structres. The binary search tree and AVL tree are binary trees that impose restrictions on the insertion/deletion behaviors.
/// - In-order, Pre-order and Post-order traversals aren't just important only for the binary tree.
/// - If you'r processing data in any tree, you'll use these traversals regularly.
public class BinaryNode<Element> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
    
}

var tree: BinaryNode<Int> = {
  let zero = BinaryNode(value: 0)
  let one = BinaryNode(value: 1)
  let five = BinaryNode(value: 5)
  let seven = BinaryNode(value: 7)
  let eight = BinaryNode(value: 8)
  let nine = BinaryNode(value: 9)

  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight

  return seven
}()


extension BinaryNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = ""
    ) -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,top + " ", top + "┌──", top + "| " ) + root + "\(node.value)\n" + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

print(tree)


/// Traversal Algorithms

/// **In-order traversal**
/// - In-order traversal visits the nodes of a binary tree in the following order, starting from the root node:
/// - 1. If the current node has a left child, recursively visit this child first.
/// - 2. Then, visit the node itself.
/// - 3. If the current node has a right child, recursively visit this child.
/// - NOTE: You may have noticed that this prints the example tree in ascending order. If the tree nodes are structured in a certain way, in-order traversal visits them in ascending order.
extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

tree.traverseInOrder{ print($0, terminator: " ") }
print()

/// **Pre-order traversal**
/// - Pre-order traversal always visits the current node first, then recursively visits the left and right child
extension BinaryNode {
    public func traversePreOrder(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
        if let rightChild = rightChild {
            rightChild.traversePreOrder(visit: visit)
        } else {
            visit(nil)
        }
    }
    
}

tree.traversePreOrder { print($0, terminator: " ") }
print()

/// **Post-order traversal**
/// - Post-order traversal only visits the current node after the left and right child have been visited recursively.
extension BinaryNode {
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

tree.traversePostOrder { print($0, terminator: " ")}
print()


///  Binary trees are a surprisingly popular topic in algorithm interviews. Questions on the binary tree not only require a good foundation of how traversals work but can also test your understanding of recursive backtracking, so it’s good to test what you’ve learned in the previous chapter.

/// Challenge 1: Height of a Tree
/// My Solution
extension BinaryNode {
    public func nodeHight() -> Int {
        var node: BinaryNode? = self
        var count = 0
        if node == nil {
            return 0
        }
        
        while node != nil {
            count += 1
            node = node!.leftChild
        }
        
        return count
    }
}
/// Book
func height<T>(of node: BinaryNode<T>?) -> Int {
    guard let node = node else {
        return 0
    }
    
    return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
}

tree.nodeHight()
height(of: tree)

/// Challenge 2: Serialization

func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
  var array: [T?] = []
  node.traversePreOrder { array.append($0) }
  return array
}

//func deserialize<T>(_ array: [T?]) -> BinaryNode<T>? {
//  var reversed = Array(array.reversed())
//  return deserialize(&reversed)
//}

func deserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? {
  guard !array.isEmpty, let value = array.removeFirst() else { return nil }
  let node = BinaryNode(value: value)
  node.leftChild = deserialize(&array)
  node.rightChild = deserialize(&array)
  return node
}



var array = serialize(tree)

for num in array {
//    if num == nil {
//        print(num, terminator: " ")
//    } else {
//        print(num!,terminator: " ")
//    }
    
    guard let num = num else {
        print("nil", terminator: " ")
        continue
    }
    print(num, terminator: " ")
}
print()
var ee = deserialize(&array)
print(ee!)
