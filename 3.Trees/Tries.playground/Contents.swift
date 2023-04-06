import Foundation

/// Trie 그림으로 도식화 해보기


/// - Try(Trie) 트라이는 영어 단어와 같이 컬렉션 형태로 표현 가능한 데이터를 저장하는 데 특화된 트리 구조입니다.
/// - Trie의 장점은 접두사 매칭(perfix matching)을 다룰 때 이점이 가장 두드러집니다.

/// - words(matching:) will go through the collection of strings and return the strings that match the prefix.
/// - This algorithm is reasonable if the number of elements in the words array is small.
/// - But if you’re dealing with more than a few thousand words, the time it takes to go through the words array will be unacceptable.
/// - The time complexity of words(matching:) is O(k*n), where k is the longest string in the collection, and n is the number of words you need to check.
class EnglishDictionary {
    private var words: [String] = []
    
    func words(matcing perfix: String) -> [String] {
        words.filter { $0.hasPrefix(perfix)}
    }
}


let dictionary = EnglishDictionary()
let words = dictionary.words(matcing: "A")
print(words)

/// **Trie Data Structure**
/// - The trie data structure has excellent performance characteristics for this probelm.
/// - As a tree with nodes that support multiple children, each node can represent a single character.
public class TrieNode<Key: Hashable> {
    
    // key holds the data for the node.
    // trie의 root node는 key가 없기 때문에 optional 값임
    public var key: Key?
    
    // A TrieNode holds a weak reference to its parent.
    // This reference simplifies the remove method later on.
    public weak var parent: TrieNode?
    
    // In binary search trees, nodes have a left and right child. In a trie, a node needs to hold multiple different elements.
    // You’ve declared a children dictionary to help with that.
    public var children: [Key: TrieNode] = [:]
    
    // As discussed earlier, isTerminating acts as an indicator for the end of a collection.
    public var isTerminating = false
    
    public init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}

/// **Trie**
/// - Trie 클래스는 String을 비롯한 Collection 프로토콜을 채택하는 모든 타입에서 사용할 수 있습니다.
/// - 그러나 컬렉션 내의 각 요소는 Hashable이어야 합니다.
/// - 이 추가적인 제한 사항은 TrieNode 내에서 자식 dictionary 키로 컬렉션의 요소를 사용할 것이기 때문에 필요합니다.
/// - 반복문 활용을 위한 Collection 프로토콜 채택
public class Trie<CollectionType: Collection>
    where CollectionType.Element: Hashable {
    public typealias Node = TrieNode<CollectionType.Element>
    
    private let root = Node(key: nil, parent: nil)
    
    public init() { }
}

extension Trie {
    /// **Insert**
    /// - Tries work with any type that conforms to Collection.
    /// - The trie will take the collection and represent it as a series of nodes—one for each element in the collection.
    public func insert(_ collection: CollectionType) {
        var current = root
        
        // current.children[element] -> children의 dictionary 구조에서 element가 키 값을 의미함
        // 즉, String.element의 해당하는 key값이 없으면 해당 key값을 갖고있는 Node Value를 만듬
        // 그리고 해당 Key값의 Value인 Node를 current로 대입
        for element in collection {
            if current.children[element] == nil {
                current.children.updateValue(Node(key: element, parent: current), forKey: element)
                //                current.children[element] = Node(key: element, parent: current)
                print(current.children.keys)
            }
            current = current.children[element]!
        }
        
        if current.isTerminating {
          return
        } else {
          current.isTerminating = true
          collections.insert(collection)
        }

    }
    /// **Contains**
    /// - contains is very similar to insert.
    /// - You check every element of the collection to see if it’s in the tree.
    /// - When you reach the last element of the collection, it must be a terminating element. If not, the collection wasn’t added, and what you’ve found is a subset of a larger collection.
    /// - The time complexity of contains is O(k), where k is the number of elements in the collection that you’re using for the search. This time complexity comes from traversing through k nodes to determine whether the collection is in the trie.
    public func contains(_ collection: CollectionType) -> Bool {
        var current = root
        for element in collection {
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        return current.isTerminating
    }
    /// **Remove**
    /// - Removing a node in the trie is a bit more tricky.
    /// - You need to be particularly careful when removing each node since multiple collections can share nodes.
    public func remove(_ collection: CollectionType) {
        var current = root
        
        for element in collection {
            guard let child = current.children[element] else {
                return
            }
            current = child
        }
        guard current.isTerminating else {
            return
        }
        
        current.isTerminating = false
        
        /// This is the tricky part. Since nodes can be shared, you don’t want to remove elements that belong to another collection. If there are no other children in the current node, it means that other collections do not depend on the current node.
        /// You also check to see if the current node is terminating. If it is, then it belongs to another collection. As long as current satisfies these conditions, you continually backtrack through the parent property and remove the nodes.
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}
    
/// **Prefix matching**
/// - The most iconic algorithm for the trie is the prefix-matching algorhtihm.
/// - Your prefix-matching algorithm will sit inside this extension, where CollectionType is constrained to RangeReplaceableCollection.
/// - This conformance is required because the algorithm will need access to the append method of RangeReplaceableCollection types.
public extension Trie where CollectionType: RangeReplaceableCollection {
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        /// 처음 접두사가 존재하는지 확인 하고 없으면 return
        var current = root
        for element in prefix {
            guard let child = current.children[element] else {
                return []
            }
            current = child
        }
        
        /// - After you’ve found the node that marks the end of the prefix,
        /// - you call a recursive helper method collections(startingWith:after:) to find all the sequences after the current node.
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
        var results: [CollectionType] = []
        
        if node.isTerminating {
            results.append(prefix)
        }
        
        for child in node.children.values {
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        
        return results
    }
}



var trie = Trie<String>()
trie.insert("Hi")

trie.insert("The")
//trie.insert("My")
//trie.insert("Is")
trie.insert("This")

trie.contains("The")

trie.remove("The")

trie.insert("Hz")
trie.insert("Hdwd")
trie.contains("This")
trie.insert("Tzzz")
trie.insert("Hiii")

trie.collections(startingWith: "Hi")


/// Challenge 1. How much faster?
/// - Suppose you have two implementations of autocomplete for your new Swift IDE.
/// - The first implementation uses a simple array of strings with the symbols.
/// - The second implemenatation uses a trie of strings.
/// - If the symbol database contains a total of 1,000,000 entries, and four entries contain symbols with prefix "pri" consisting of "prior","print","priority","prious", how much faster will the trie run?
/// - 1,000,000 * 3 * O(1) / 4 * 8 * O(1) = 93,750 times faster
/// - 1,000,000 is the database size; 3 is the prefix length; 4 is the number of matches; 8 is the length of the entry “priority”.



/// Challenge 2. Additional properties
