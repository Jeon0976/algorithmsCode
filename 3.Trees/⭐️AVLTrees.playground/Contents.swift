import Foundation

/// **Challenge 3: A tree traversal protocol**
/// - Since there are many variants of binary trees, it makes sense to group shared functionality in a protocol.
/// - The traversal methods are a good candidate for this.
/// - Create a TraversableBinaryNode protocol that provides a default implementation of the traversal methods so that conforming types get these methods for free.
/// - Have AVLNode conform to this.
/// - 클래스에 final 키워드를 붙이면 해당 클래스가 상속될 수 없도록 하여 클래스 계층 구조를 더욱 명확하게 만듭니다. TraversableBinaryNode 프로토콜에서 Self 요구사항이 있기 때문에, AVLNode 클래스가 상속될 경우 프로토콜 요구사항을 만족시키지 못할 수 있습니다. 그러므로 AVLNode 클래스에 final 키워드를 추가하여 상속이 불가능하도록 만든 것입니다.
protocol TraversableBinaryNode {
    associatedtype Element
    
    var value: Element { get }
    var leftChild: Self? { get }
    var rightChild: Self? { get }
    func traverseInOrder(visit: (Element) -> Void)
    func traversePreOrder(visit: (Element) -> Void)
    func traversePostOrder(visit: (Element) -> Void)
  }

extension TraversableBinaryNode {

  func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)
    visit(value)
    rightChild?.traverseInOrder(visit: visit)
  }

  func traversePreOrder(visit: (Element) -> Void) {
    visit(value)
    leftChild?.traversePreOrder(visit: visit)
    rightChild?.traversePreOrder(visit: visit)
  }

  func traversePostOrder(visit: (Element) -> Void) {
    leftChild?.traversePostOrder(visit: visit)
    rightChild?.traversePostOrder(visit: visit)
    visit(value)
  }
}




/// **AVL Trees**
/// - In 1962, Georgy Adelson-Velsky and Evgenii Landis came up with the first self-balancing binary search tree - The AVL Tree.
///
/// **Understanding balance**
/// - A balanced tree is the key to optimizing the performance of the binary search tree.
/// **Perfect balance**
/// - The ideal form of a binary search tree is the perfectly balanced state. In technical terms, this means every level of the tree is filled with nodes, from top to bottom.
/// - Not only is the tree perfectly symmetrical, the nodes at the bottom level are completely filled.
/// - This is the requirement for being perfectly balanced.
/// **"Good-enough" balance**
/// - Although achieving perfect balance is ideal, it is rarely possible.
/// - A perfectly balanced tree must contain the exact number of nodes to fill every level to the bottom, so it can only be perfect with a particular number of elements.
/// - For example, a tree with 1, 3 or 7 nodes can be perfectly balanced, but a tree with 2, 4, 5 or 6 can not be perfectly balanced since the last level of the tree will not be filled.
/// - The definition of a balanced tree is that every level of the tree must be filled, except for the bottom level.
/// - In most cases of binary trees,this is the best you can do.
/// **Unbalanced**
/// - Binary search trees in this state suffer from various levels of performance loss, depending on the degree of imbalance.
///
/// **Measuring balance**
/// - To keep a binary tree balanced, you'll need a way to measure the balance of the tree. The AVL tree achieves this with a **height** property in each node. In tree-speak, the height of a node is the longest distance from the current node to a leaf node
public class AVLNode<Element> {
    
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    public var height = 0
    
    /// You’ll use the relative heights of a node’s children to determine whether a particular node is balanced. The height of the left and right children of each node must differ at most by 1.
    /// This number is known as the balance factor.
    
    public var balanceFactor: Int {
        return leftHeight - rightHeight
    }
    
    public var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    
    public var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    
    public init(value: Element) {
        self.value = value
    }
}


extension AVLNode: CustomStringConvertible {
  
  public var description: String {
    diagram(for: self)
  }
  
  private func diagram(for node: AVLNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    guard let node = node else {
      return root + "nil\n"
    }
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ")
      + root + "\(node.value)\n"
      + diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
  }
}

extension AVLNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}


public struct AVLTree<Element: Comparable> {
    
    public private(set) var root: AVLNode<Element>?
    
    public init() { }
    
}

extension AVLTree: CustomStringConvertible {
  
  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}

extension AVLTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        let balanceNode = balanced(node)
        balanceNode.height = max(balanceNode.leftHeight, balanceNode.rightHeight) + 1
        return balanceNode
    }
    
    /// **Rotations**
    /// - The procedures used to balance a binary search three are known as rotations.
    /// - There are four rotations in total for the four different ways that a tree can become unbalanced.
    /// - These are known as left rotation, left-right rotation, right rotation and right-left rotation.
    
    /// **Left rotation**
    /// - Before going into specifics, there are two takeaways from this before-and-after comparison
    /// - 1. In-order traversal for these nodes remains the same.
    /// - 2. The depth of the tree is reduced by one level after the rotation.
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        
        let pivot = node.rightChild!
        
        node.rightChild = pivot.leftChild
        
        pivot.leftChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight,pivot.rightHeight) + 1
        
        return pivot
    }
    
    /// **Right rotation**
    /// - Right rotation is the symmetrical opposite of left rotation.
    /// - When a series of left children is causing an imbalance, it's time for a right rotation.
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight,pivot.rightHeight) + 1
        
        return pivot
    }
    
    /// **Left-Right rotation**
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else {
            return node
        }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }

    /// **Right-Left rotation**
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else {
            return node
        }
        node.rightChild = rightRotate(rightChild)
        
        return leftRotate(node)
    }
    
    
    
    
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        print(node.value)
        print(node.balanceFactor)
        switch node.balanceFactor {
        /// A balanceFactor of 2 suggests that the left child is "heavier" (contains more nodes) than the right child.
            /// This means that you want to use either right or left-right rotations.
            case 2:
                if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        /// A balanceFactor of -2 suggests that the right child is heavier than the left child.
        /// This means that you want to use either left or right-left rotation.
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor ==  1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}


extension AVLTree {
  
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

private extension AVLNode {
  
  var min: AVLNode {
    leftChild?.min ?? self
  }
}

extension AVLTree {
  
  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }
  
  private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
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
    let balancedNode = balanced(node)
    balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
    return balancedNode
  }
}

    

var tree = AVLTree<Int>()

for i in 0..<15 {
    tree.insert(i)
}
print(tree)
//print(tree)
//tree.remove(14)
print(tree)
/// **Challenge 1: Number of leaves**
/// - How many leaf nodes are there in a perfectly balanced tree of height 3?
/// - What about a perfectly balanced tree of height h?
/// - A self-balancing tree avoids performance degradation by performing a balancing procedure whenever you add or remove elements in the tree.
/// - AVL trees preserve balance by readjusting parts of the tree when the tree is no longer balanced.
/// - Balance is achieved by four types of tree rotations on node insertion and removal.
/// - A perfectly balanced tree is a tree where all the leaves are in the same level, and that level is completely filled
/// - Recall that a tree with just a root node has a height of zero. Thus, the tree in the example above has a height of two. You can extrapolate that a tree with a height of three would have eight leaf nodes.
/// - Since each node has two children, the number of leaf nodes doubles as the height increases. You can calculate the number of leaf nodes with a simple equation.
func leafNodes(inTreeOfHeight height: Int) -> Int {
  Int(pow(2.0, Double(height)))
}

leafNodes(inTreeOfHeight: 3)

/// **Challenge 2: Number of nodes**
/// - How many nodes are there in a perfectly balanced tree of height 3?
/// - What about a perfectly balanced three of height h?
func nodes(inTreeOfHeight height: Int) -> Int {
    Int(pow(2.0, Double(height + 1))) - 1
}

nodes(inTreeOfHeight: 2)



class MyClass {
    func myMethod() -> Self {
        return self
    }
}

class MySubclass: MyClass {
    override func myMethod() -> Self {
        return self
    }
}

var ss = MyClass()
var sss = MySubclass()

ss.myMethod()
sss.myMethod()
