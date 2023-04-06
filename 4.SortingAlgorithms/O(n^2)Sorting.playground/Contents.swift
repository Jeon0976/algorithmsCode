import Foundation

/// - O(n²) time complexity is not great performance, but the sorting algorithms in this category are easy to understand and useful in some scenarios.
/// - These algorithms are space-efficient; they only require constant O(1) additional memory space.
/// - For small data sets, these sorts compare very favorably against more complex sorts.
/// 1. Bubble sort
/// 2. Selection sort
/// 3. Insertion sort
/// - All of these are comparison-based sorting methods.
/// - They rely on a comparison method, such as the less-than opeartor, to order the elements.
/// - The number of times this comparison gets called is how you can measure a sorting technique's general performance.

/// **Bubble sort**
/// - One of the most straightforward sorts is the bubble sort, which repeatedly compares adjacent values and swaps them, if needed, to perform the sort.
/// - Therefore, the larger values in the set will “bubble up” to the end of the collection.
/// - The sort is only complete when you can perform a full pass over the collection without swapping any values.
/// - At worst, this will require n-1 passes, where n is the count of members in the collection.
/// - Bubble sort has a best time complexity of O(n) if it’s already sorted, and a worst and average time complexity of O(n²), making it one of the least appealing sorts in the known universe.
public func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for end in (1..<array.count).reversed() {
        var swapped = false
//        print(end)
        for current in 0..<end {
//            print("\(current): ",array)

            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        
        if !swapped {
            return
        }
    }
}

var array1 = [9,4,10,3]
bubbleSort(&array1)


/// **Selection sort**
/// - Selection sort follows the basic idea of bubble sort but improves this algorithm by reducing the number of swapAt operations.
/// - Selection sort will only swap at the end of each pass.
/// - Just like bubble sort, selection sort has a best, worst and average time complexity of O(n²), which is fairly dismal.
/// - It’s a simple one to understand, though, and it does perform better than bubble sort!
public func selectionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1)..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(lowest, current)
        }
        print("\(current): ",array)
    }
}

var array2 = [9,4,10,3]
selectionSort(&array2)


/// **Insertion sort**
/// - Insertion sort is a more useful algorithm.
/// - Like bubble sort and selection sort, insertion sort has an average time complexity of O(n²), but the performance of insertion sort can vary.
/// - The more the data is already sorted, the less work it needs to do.
/// -  Insertion sort has a best time complexity of O(n) if the data is already sorted.
/// - The Swift standard library sort algorithm uses a hybrid of sorting approaches, with insertion sort being used for small (<20 element) unsorted partitions.
/// - Insertion sort will iterate once through the cards, from left to right. Each card is shifted to the left until it reaches its correct position.
public func insertionSort<Element>(_ array: inout[Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 1..<array.count {
        for shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting - 1)
            } else {
                break
            }
        }
    }
}

var array3 = [9,4,10,3]
insertionSort(&array3)
