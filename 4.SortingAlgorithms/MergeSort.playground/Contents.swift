import Foundation

/// **Merge Sort**
/// - Merge sort is one of the most efficient sorting algorithms.
/// - With a time complexity of O(n log n), it's one of the fastest of all general-purpose sorting algorithms.
/// - The idea behind merge sort is divide and conquer - to break up a big problem into several smaller, easier-to-solve problems and then combine those solutions into a final results.
/// - The merge sort mantra is to split first and merge after.
/// 1. First, split the pile in half. You now have two unsorted piles
/// 2. Now, keep splitting the resulting piles until you can’t split anymore. In the end, you will have one (sorted!) card in each pile.
/// 3. Finally, merge the piles in the reverse order in which you split them. During each merge, you put the contents in sorted order. This process is easy because each pile is already sorted.
/// - The best, worst and average time complexity of merge sort is O(n log n), which isn't too bad.
/// - In general, if you have an array of size n, the number of levels is log2(n). As you recurse, you split a single array into two smaller arrays. This means an array of size two will need one recursion level, an array of size four will need two levels, an array of size eight will need three levels, and so on. If you had an array of 1,024 elements, it would take ten levels of recursively splitting in two to get down to 1024 single element arrays.
/// - The cost of a single recursion is O(n). A single recursion level will merge n elements. It doesn’t matter if there are many small merges or one large one; the number of elements merged will still be n at each level.
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
    // - Recursion needs a base case, which you can also think of as an “exit condition.” In this case, the base case is when the array only has one element.
    guard array.count > 1 else {
        return array
    }

    let middle = array.count / 2
    let left = mergeSort(Array(array[..<middle]))
    let right = mergeSort(Array(array[middle...]))

    return merge(left, right)
}


private func merge<Element>(_ left1:[Element], _ right1:[Element]) -> [Element] where Element: Comparable {
    var leftIndex = 0
    var rightIndex = 0
    
    var result: [Element] = []
    
    while leftIndex < left1.count && rightIndex < right1.count {
        let leftElement = left1[leftIndex]
        let rightElement = right1[rightIndex]
        
        if leftElement < rightElement {
            result.append(leftElement)
            leftIndex += 1
        } else if leftElement > rightElement {
            result.append(rightElement)
            rightIndex += 1
        } else {
            result.append(leftElement)
            leftIndex += 1
            result.append(rightElement)
            rightIndex += 1
        }
    }
    
    if leftIndex < left1.count {
        result.append(contentsOf: left1[leftIndex...])
    }
    
    if rightIndex < right1.count {
        result.append(contentsOf: right1[rightIndex...])
    }
    
    return result
}


let array = [7,2,6,3,9]

mergeSort(array)
