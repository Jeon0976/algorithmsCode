import Foundation

/// **Binary Search**
/// - Binary Search is one of the most efficient searching algorithms with time complexity of O(logn).
/// - This is comparable with searching for an element inside a balanced binary search tree.
/// - Two conditions that need to be met before binary search may be used
/// - 1. The colleciton must be able to perfom index manipulation in const#fileLiteral(resourceName: "dd.playground")ant time. This means that the collection must be a RandomAccessCollection.
/// - 2. The collection must be sorted.

/// Swift's Array type uses linear search to implement its firstIndex(of:) method.
/// It traverses through the whole collection or until it finds the first element
let ded  = [1,2,3,45,2,3]

ded.firstIndex(of: 4)

/// Binary search handles things differently by taking advantage of the fact that the collection is already sorted.
/// Step 1: Find middle index
/// - The first step is to find the middle index of the collection. Finding it is fairly straightforward
/// Step 2: Check the element at the middle index
/// - The next step is to check the element stored at the middle index.
/// - If it matches the value you’re looking for, return the index. Otherwise, continue to Step 3.
/// Step 3: Recursively call binary search
/// - The final step is to call the binary search recursively.
/// - However, this time, You'll only consider the elements exclusively to the left or to the right of the middle index, depending on the value you're searching for.
/// - If the value you’re searching for is less than the middle value, you search the left subsequence.
/// -  If it is greater than the middle value, you search the right subsequence.
/// - Each step effectively removes half of the comparisons you would otherwise need to perform.

/// - Since binary search only works for types that conform to RandomAccessCollection, you add the method in an extension on RandomAccessCollection. This extension is constrained as you need to be able to compare elements.
public extension RandomAccessCollection where Element: Comparable {
    /// - Binary search is recursive, so you need to pass in a range to search.
    /// - The parameter range is optional, so you can start the search without specifying a range. In this case, where range is nil, the entire collection will be searched.
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex
        
        guard range.lowerBound < range.upperBound else {
            return nil
        }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size/2)
        
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
    }
}


let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)

print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")

/// Binary search is a powerful algorithm to learn and comes up often in programming interviews. Whenever you read something along the lines of “Given a sorted array…”, consider using the binary search algorithm. Also, if you are given a problem that looks like it is going to be O(n²) to search, consider doing some up-front sorting so you can use binary searching to reduce it down to the cost of the sort at O(n log n).
///
/// Challenge 1, 2 확인
