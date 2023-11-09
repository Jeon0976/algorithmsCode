import Foundation

func combination<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    
    guard array.count >= n else { return result }
    
    var stack = array.enumerated().map { ([$0.element], $0.offset)}
    
    while !stack.isEmpty {
        let now = stack.removeLast()
        
        let elements = now.0
        let index = now.1
        
        if elements.count == n {
            result.append(elements.sorted())
            continue
        }
        
        guard index+1 <= array.count - 1 else { continue }
        
        for i in index+1...array.count - 1 {
            stack.append((elements + [array[i]], i))
        }
    }
    
    return result
}


combination([1,2,3], 2)

func combinationRecursive<T: Comparable>(_ array: [T], _ n: Int) -> [[T]] {
    var result = [[T]]()
    
    guard array.count >= n else { return result}
    
    func cycle(_ index: Int, _ now: [T]) {
        print(index, now)

        if now.count == n {
            result.append(now.sorted())
            return
        }
        
        for i in index..<array.count {
            cycle(i + 1, now + [array[i]])
        }

        
    }
    
    cycle(0, [])
    
    return result
}

combinationRecursive([1,2,3], 2)
