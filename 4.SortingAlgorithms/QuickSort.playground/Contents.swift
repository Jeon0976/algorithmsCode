import Foundation


/// **QuickSort**
/// - Quicksort is another comparison-based sorting algorithm. Much like merge sort, it uses the same strategy of divide and conquer.
/// -  One important feature of quicksort is choosing a pivot point. The pivot divides the array into three partitions.
/// - [elements < pivot | pivot | elements > pivot ]
public func quicksortNaive<T: Comparable>(_ a:[T]) -> [T] {
    guard a.count >= 2 else {
        return a
    }
    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
//    print(less, terminator: " ")
//    print(equal, terminator: " ")
//    print(greater, terminator: " ")
//    print()
    return quicksortNaive(less) + equal + quicksortNaive(greater)
}
var array = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1,8]


quicksortNaive(array)

/// Partitioning strategies

/// **Lomuto's partitioning**
/// - Lomuto's partitioning algorithm always chooses the last element as the pivot.
/// - The function returns the index of the pivot.
private func partitionLomuto<T: Comparable>(_ a: inout[T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            a.swapAt(i, j)
            i += 1
        }
    }
    
    a.swapAt(i, high)
    return i
}


public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivot = partitionLomuto(&a, low: low, high: high)
        quicksortLomuto(&a, low: low, high: pivot - 1)
        quicksortLomuto(&a, low: pivot + 1, high: high)
    }
}

var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1,8]
quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)


/// **Hoare's partitioning**
/// - Hoare's partitioning algorithm always chooses the first element as the pivot.
public func partitionHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) -> Int {
  let pivot = a[low] // 1
  var i = low - 1 // 2
  var j = high + 1

  while true {
    repeat { j -= 1 } while a[j] > pivot // 3
    repeat { i += 1 } while a[i] < pivot // 4

    if i < j { // 5
      a.swapAt(i, j)
    } else {
      return j // 6
    }
  }
}

public func quicksortHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) {
  if low < high {
    let p = partitionHoare(&a, low: low, high: high)
    quicksortHoare(&a, low: low, high: p)
    quicksortHoare(&a, low: p + 1, high: high)
  }
}

var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortHoare(&list2, low: 0, high: list.count - 1)
print(list2)

/// Effects of a had pivot choice
///
var p = list2.partition(by: { $0 > 5})

var test = list2[...p]
print(test)
