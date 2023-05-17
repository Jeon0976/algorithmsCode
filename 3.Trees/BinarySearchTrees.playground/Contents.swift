import Foundation

public class BinaryNode<Element> {
    
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
    
}


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

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

/// **Binary Search Tree(BST)**
/// - A binary search tree, or BST,  is a data structure that facilitates fast lookup, insert and removal operations. Consider the following decision tree where picking a side forfeits all the possibilities of the other side, cutting the problem in half.
/// - Once you make a decision and choose a branch, there is no looking back.
/// - You keep going until you make a final decision at a leaf node.
/// - Binary search trees use this property to save you from performin unnecessary checking.
/// - As a result, lookup, insert and removal have an average time complexity of O(log n), which is considerably faster than linear data structures such as arrays and linked lists.
/// ----
/// **Lookup**
/// - Every time the search algorithm visits a node in the BST, it can safely make these two assumptions
/// - 1. If the search value is less than the current value, it must be in the left subtree.
/// - 2. If the serach value is greater than the current value, it must be in the right subtree.
/// - By leveraging the rules of the BST, you can avoid unnecessary checks and cut the search space in half every time you make a decision. That’s why element lookup in a BST is an O(log n) operation.
/// ----
/// **Insertion**
/// - Inserting values into an array is like butting into an existing line
/// - Everyone in the line behind your chosen spots needs to make space
/// - By leveraging the rules for the BST,  you didn't have to shuffle all the elements around.
/// - Inserting elements in a BST is again an O(log n) operation.
/// ----
/// **Removal**
/// - removing an element from a BST is still an O(log n) operation.
/// ------
/// - By definition, binary search trees can only hold values that are Comparable.
public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    
    public init() { }
}

extension BinarySearchTree: CustomStringConvertible {
    
    public var description: String {
      guard let root = root else { return "empty tree" }
      return String(describing: root)
    }
}

/// **Inserting Elements**
/// - Per the rulues of the BST, nodes of the left child must contain values less then the current node.
/// - Nodes of the right child must contain values greater than or equal to the current node.
extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else {
            return BinaryNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

var bst = BinarySearchTree<Int>()

bst.insert(3)
bst.insert(0)
bst.insert(1)
bst.insert(4)
bst.insert(2)
bst.insert(-55)
bst.insert(8)
bst.insert(9)

bst.insert(10)

bst.insert(11)

print(bst)
print(bst.root)
/// Finding Elements
/// In-order traversal has a time complexity of O(n)
//extension BinarySearchTree {
//    public func contains(_ value: Element) -> Bool {
//        guard let root = root else {
//            return false
//        }
//
//        var found = false
//        root.traverseInOrder { if $0 == value {
//            found = true
//            }
//        }
//        return found
//    }
//}
/// optimizing contains
/// This implementation of contains is an O(logn) operation in a balanced binary search tree.
extension BinarySearchTree {
    public func contains(_ value: Element) -> Bool {
        var current = root
        
        while let node = current {
            if node.value == value {
                return true
            }
            
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

bst.contains(5)
bst.contains(0)

/// **Removing Elements**
/// - Removing elements is a little more tricky, as you need to handle a few different scenarios.
/// **1. Leaf node**
/// - Removing a leaf node is straighforward. simply detach the leaf node.
/// **2. Nodes with one child**
/// - When removing nodes with one child, you'll need to reconnect that one child with the rest of the tree.
/// **3. Nodes with two children**
/// - simply deleting the node presents a dilemma
/// - When removing a node with two children, replace the node you removed with the samllest node in its right subtree.
/// - It's important to note that this produces a vaild binary search tree.
/// - Because the new node was the smallest in the right subtree, all nodes in the right subtree will still be greater than or equal to the new node.
/// - And because the new node came from the right subtree, all nodes in the left subtree will be less than the new node.
/// - After performing the swap, you can simply remove the value you copied, just a leaf node.
///
/// You've added a recursive min property to BinaryNode to find the minimum node in a subtree.
private extension BinaryNode {
    var min: BinaryNode {
        leftChild?.min ?? self
    }
}

/// 이해하기 좀 빡세다
extension BinarySearchTree {
    
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else {
            return nil
        }
        
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            
            if node.leftChild == nil {
                return node.rightChild
            }
            
            if node.rightChild == nil {
                return node.leftChild
            }
            
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        return node
    }
}

/// Performance will degrade to O(n) as the tree becomes unbalanced.
/// This is undesirable, so you'll learn about a. self-balancing binary search tree called the AVL tree in Chapter 16.

print(bst)
bst.remove(9)
print(bst)
bst.remove(0)
print(bst)

/// Challenge 1. Binary tree or binary search tree?
/// - Create a function that check if a binary tree is a binary search tree.
/// isBinarySearchTree is the interface that will be exposed for external use. Meanwhile, the magic happens in the isBST function:
/// - isBST is responsible for recursively traversing through the tree and checking for the BST property. It needs to keep track of progress via a reference to a BinaryNode, and also keep track of the min and max values to verify the BST property.
/// - This is the base case. If tree is nil, then there are no nodes to inspect. A nil node is a binary search tree, so you’ll return true in that case.
/// - This is essentially a bounds check. If the current value exceeds the bounds of the min and max, the current node violates binary search tree rules.
/// - This line contains the recursive calls. When traversing through the left children, the current value is passed in as the max value. This is because any nodes on the left side cannot be greater than the parent. Vice versa, when traversing to the right, the min value is updated to the current value. Any nodes on the right side must be greater than the parent. If any of the recursive calls evaluate false, the false value will propagate back to the top.
/// - The time complexity of this solution is O(n) since you need to traverse through the entire tree once. There is also a O(n) space cost since you’re making n recursive calls.
extension BinaryNode where Element: Comparable {
    var isBinarySearchTree: Bool {
        isBST(self, min: nil, max: nil)
    }
    
    private func isBST(_ tree: BinaryNode<Element>?,
                       min: Element?,
                       max: Element?
    ) -> Bool {
        guard let tree = tree else {
            return true
        }
        
        if let min = min, tree.value <= min {
            return false
        } else if let max = max, tree.value > max {
            return false
        }
        
        return isBST(tree.leftChild, min: min, max: tree.value) && isBST(tree.rightChild, min: tree.value, max: max)
    }
}
//bst.root?.rightChild = BinaryNode(value: 2)
print(bst)
bst.root?.isBinarySearchTree

/// Challenge 2. Equatable
extension BinarySearchTree :Equatable {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<Element: Equatable>(
        _ node1: BinaryNode<Element>?,
        _ node2: BinaryNode<Element>?
    ) -> Bool {
        guard let leftNode = node1, let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        
        return leftNode.value == rightNode.value && isEqual(leftNode.leftChild, rightNode.leftChild) && isEqual(leftNode.rightChild, rightNode.rightChild)
    }
}

bst != bst
/// Challenge 3. Is it a subtree?
extension BinarySearchTree where Element: Hashable {
    public func containsSub(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        
        root?.traverseInOrder {
            set.insert($0)
        }
        
        var isEqual = true
        
        subtree.root?.traverseInOrder {
            isEqual = set.contains($0)
        }
        
        return isEqual
    }
}
var bst2 = BinarySearchTree<Int>()
bst2.insert(2)
bst2.insert(5)
bst2.insert(3)
bst2.insert(1)
bst2.insert(0)

var bst3 = BinarySearchTree<Int>()
bst3.insert(2)
bst3.insert(5)
bst3.insert(3)
bst3.insert(1)
bst3.insert(0)

bst2 == bst3
bst2.containsSub(bst3)
bst == bst2
bst.contains(1)
bst.containsSub(bst2)
