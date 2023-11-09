import Foundation

let n = Int(readLine()!)!

var nArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

let m = Int(readLine()!)!

var mArray = readLine()!.components(separatedBy: " ").map { Int($0)! }


nArray.sort()

var checkNum = [Int](repeating: 0, count: mArray.count)

extension RandomAccessCollection where Element: Comparable {
    func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
        let range = range ?? startIndex..<endIndex
        
        guard range.lowerBound < range.upperBound else { return nil }
        
        let size = distance(from: range.lowerBound, to: range.upperBound)
        let middle = index(range.lowerBound, offsetBy: size / 2)
        
        if self[middle] == value {
            return middle
        } else if self[middle] > value {
            return binarySearch(for: value, in: range.lowerBound..<middle)
        } else {
            return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
        }
    }
}

for (index, value) in mArray.enumerated() {
    if (nArray.binarySearch(for: value) != nil) {
        checkNum[index] = 1
    }
}

for num in checkNum {
    print(num)
}
