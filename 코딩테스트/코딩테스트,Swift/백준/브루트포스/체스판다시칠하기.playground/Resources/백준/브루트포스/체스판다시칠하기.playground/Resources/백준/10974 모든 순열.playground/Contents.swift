import Foundation

let line = Int(readLine()!)!

var array = [Int]()

for i in 1...line {
    array.append(i)
}

func permutation(_ array:[Int],_ n: Int) -> [[Int]] {
    var result = [[Int]]()
    
    guard array.count >= n else { return result }
    
    var stack: [([Int],[Bool])] = array.enumerated().map {
        var visited = Array(repeating: false, count: array.count)
        visited[$0.offset] = true
        
        return ([$0.element], visited)
    }
    
    while !stack.isEmpty {
        let now = stack.removeLast()
 
        let elements = now.0
        var visited = now.1
        
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
    
    let sortedResult = result.sorted { $0.lexicographicallyPrecedes($1) }
    
    return sortedResult
}

permutation(array, line).forEach { result in
    result.forEach {
        print($0, terminator: " ")
    }
    print()
}
