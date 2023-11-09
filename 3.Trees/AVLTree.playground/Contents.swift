import Foundation

public final class AVLNode<Element> {
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    public var height = 0
    
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

public struct AVLTree<Element: Comparable> {
    public private(set) var root: AVLNode<Element>?
    
    public init() { }
    
    // RR Problem
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
        
        node.rightChild = pivot.leftChild
        
        pivot.leftChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // LL Problem
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        
        node.leftChild = pivot.rightChild
        
        pivot.rightChild = node
        
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        
        return pivot
    }
    
    // RL Problem
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node
        }
        
        node.rightChild = rightRotate(rightChild)
        
        return leftRotate(node)
    }
    
    // LR Problem
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else {
            return node
        }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    
    // Balance
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
    
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(
        from node: AVLNode<Element>?,
        value: Element
    ) -> AVLNode<Element> {
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
}

extension AVLTree {
    public func inOrderTraversal(_ node: AVLNode<Element>?) {
        guard let node = node else { return }
        inOrderTraversal(node.leftChild)
        print(node.value)
        inOrderTraversal(node.rightChild)
    }
    
    public func printInOrder() {
        inOrderTraversal(root)
    }
}


var tree = AVLTree<String>()

for i in 0..<10 {
    tree.insert("\(i)자")
}

tree.printInOrder()

print("1" < "2자어")
