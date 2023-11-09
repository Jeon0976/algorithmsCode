import Foundation

// Stack
func permutationStack<T: Comparable>(_ array:[T],_ n: Int) -> [[T]] {
    var result = [[T]]()
    guard array.count >= n else { return result }
    
    var stack: [([T], [Bool])] = array.enumerated().map {
        var visited = Array(repeating: false, count: array.count)
        visited[$0.offset] = true
        
        return ([$0.element], visited)
    }
    
    while !stack.isEmpty {
        let now = stack.removeLast()
        
        let elements = now.0
        var visited = now.1
        
        // depth가 elements.count
        if elements.count == n {
            result.append(elements)
            continue
        }
        
        for i in 0...array.count - 1 {
            if !visited[i] {
                visited[i] = true
                stack.append((elements + [array[i]], visited))
                visited[i] = false
            }
        }
    }
        
//    let sortedResult = result.sorted { $0.lexicographicallyPrecedes($1) }
    
    return result
}


func permutationStack2(_ nums: [Int], _ k: Int) -> [[Int]] {
    var result = [[Int]]()
    
    guard nums.count >= k else { return result }
    
    var stack: [(Int, [Int], [Bool])] = [(0, [], Array(repeating: false, count: nums.count))]
    
    while !stack.isEmpty {
        let (depth, current, used) = stack.removeLast()
        
        if depth == k {
            result.append(current)
        } else {
            for i in 0..<nums.count {
                if !used[i] {
                    var newUsed = used
                    newUsed[i] = true
                    stack.append((depth + 1, current + [nums[i]], newUsed))
                }
            }
        }
    }
        
    return result
}


func permutationRecursive<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()

    guard array.count >= n else { return result }
    
    var visited = Array(repeating: false, count: array.count)
    
    func cycle(_ now: [T]) {
        if now.count == n {
            result.append(now)
            return
        }
        
        for i in 0..<array.count {
            if visited[i] {
                continue
            } else {
                visited[i] = true
                cycle(now + [array[i]])
                visited[i] = false
            }
        }
    }
    
    cycle([])
    
    return result
}

permutationRecursive([1,2,3], 3)
permutationStack([1,2,3], 3)
//permutationStack([1,2,3], 3).forEach { result in
//    result.forEach {
//        print($0, terminator: " ")
//    }
//    print()
//}
//permutationStack2([1,2,3], 3)


func productPermutations<T>(_ array: [T], _ n: Int) -> [[T]] {
    if n == 0 { return [[]] }

    var result = [[T]]()
    for value in array {
        for perm in productPermutations(array, n - 1) {
            result.append([value] + perm)
        }
    }
    return result
}

productPermutations([1,2,3], 3)
