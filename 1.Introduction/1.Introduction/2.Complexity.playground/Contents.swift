import Foundation

let name: [String] = ["1","2","3","4","5"]

// Time Complexity

// Constant Time
func checkFirst(names: [String]) {
    if let first = names.first {
        print(first)
    } else {
        print("no names")
    }
}

// Linear time
func printName(names: [String]) {
    for name in names {
        print(name)
    }
}

// Quadratic time 2차식 복잡도
func printNames(names: [String]) {
    for i in names {
        print("\(i)번째")
        for name in names {
            print(name)
        }
    }
}

// Logarithmic time 로그 시간 복잡도
let numbers = [1,2,3,4,5,6,7,8,9]

func naiveContains(_ value: Int, in array: [Int]) -> Bool {
    guard !array.isEmpty else { return false }
    let middleIndex = array.count / 2
    
    if value <= middleIndex {
        for index in 0...middleIndex {
            if array[index] == value {
                return true
            }
        }
    } else {
        for index in middleIndex..<array.count {
            if array[index] == value {
                return true
            }
        }
    }
    
    return false
}

// Quasilinear time -> n log n


// 책에서 다루진 않지만 여러 가지의 복잡도
// polynomial time 다항식 복잡도
// exponential time 지수식 복잡도
// factorial time 팩토리얼 복잡도
// ...


//naiveContains(1, in: numbers)

//checkFirst(names: name)
//printName(names: name)
printNames(names: name)

// 수학계산에서의 시간복잡도
// Comparing time complexity
// O(n)
func sumFromOne(upto n: Int) -> Int {
    var result = 0
    for i in 1...n {
        result += i
    }
    return result
}

// O(n) / Compiled Code
func sumFromOneFasterVer(upto n: Int) -> Int {
    (1...n).reduce(0, +)
}

// O(1)
func sumFromOneFastestVer(upto n: Int) -> Int {
    (n + 1) * n / 2
}

//sumFromOne(upto: 10000000)
//sumFromOneFastestVer(upto: 10000000)
//sumFromOneFastestVer(upto: 10000000)

// Space Complexity

// time Complexity O(n)
// Space Complexity O(n)
func printSortedON(_ array: [Int]) {
    let sorted = array.sorted()
    for element in sorted {
        print(element)
    }
}

// time Complexity O(2or3n)???
// Space Complexity O(1)
func printSorted(_ array: [Int]) {
    guard !array.isEmpty else { return }
    
    var currentCount = 0
    // Int형의 최소 값
    var minValue = Int.min
    
    for value in array {
        if value == minValue {
            print(value)
            currentCount += 1
        }
    }
    
    while currentCount < array.count {
        var currentValue = array.max()!
        
        for value in array {
            if value < currentValue && value > minValue {
                currentValue = value
            }
        }
        
        for value in array {
            if value == currentValue {
                print(value)
                currentCount += 1
            }
        }
        
        minValue = currentValue
    }
}

let intTest: [Int] = [5,4,3,2,1]

printSorted(intTest)
