import Foundation

/// **Radix Sort**
/// - Radix Sort is a completely different model of sorting.
/// - So far, you've been relying on comparisons to determine the sorting order.
/// - Radix sort is a non-comparative algorithm for sorting integers in linear time.
/// - There are multiple implementations of radix sort that focus on different problems.
/// - Radix sort relies on the positional notation of integers.
/// - First, the array is divided into buckets based on the value of the least significant digit: the ones digit.
/// - Next, repeat this procedure for the tens digit.
/// - The next digit to consider is the hundreds digit.
/// - For values with no hundreds position (or any other position without a value), the digit will be assumed to be zero.
/// - When multiple numbers end up in the same bucket, their relative ordering doesn’t change.
extension Array where Element == Int {
    public mutating func radixSort() {
        let base = 10
        var done = false
        var digits = 1
        
        while !done {
            done = true
            var buckets: [[Int]] = .init(repeating: [], count: base)
            
            forEach { number in
                let remainingpart = number / digits
                let digit = remainingpart % base
                buckets[digit].append(number)
                if remainingpart > 0 {
                    done = false
                }
            }
            print(buckets)
            digits *= base
            self = buckets.flatMap { $0 }
        }
    }
}


var array = [88,410,1772,20]
array.radixSort()

var array2 = [4,3,2,1]
array2.radixSort()
223424 / 1
4 % 10
10 * 10
433 / 10
43 % 10
//433 % 10
