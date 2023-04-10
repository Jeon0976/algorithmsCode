import Foundation
//
//// 3-1 거스름돈
//func money() {
//    var n = 1260
//    var count = 0
//    let coin_types = [500,100,50,10]
//
//    for coin_type in coin_types {
//        count += n / coin_type
//        n %= coin_type
//    }
//    print(count)
//}
//
//money()
//
//// 체육복 -> 배열로 나열한 다음에 찾기
//func solution(_ n:Int, _ lost:[Int], _ reserve:[Int]) -> Int {
//    var students = [Int](repeating: 1, count: n)
//    for lose in lost {
//        students[lose-1] = 0
//    }
//
//    for r in reserve {
//        students[r-1] += 1
//    }
//
//    var count = 0
//
//    for i in 0..<n {
//        if students[i] == 0 {
//            if i>0 && students[i-1] > 1 {
//                students[i] = 1
//                students[i-1] = 1
//            } else if i<n-1 && students[i+1] > 1 {
//                students[i] = 1
//                students[i+1] = 1
//            } else {
//                count += 1
//            }
//        }
//    }
//
//    return n - count
//}
//
//func solutionH(_ n: Int, _ lost: [Int], _ reserve: [Int]) -> Int {
//    let newReserve = reserve.filter { !lost.contains($0) }
//    print(newReserve)
//    let newLost = lost.filter { !reserve.contains($0) }
//
//    var lostPeople: Int = newLost.count
//
//    newReserve.forEach {
//        let isLend: Bool = newLost.contains($0 - 1) || newLost.contains($0 + 1)
//        if isLend && lostPeople > 0 {
//            lostPeople -= 1
//        }
//    }
//
//    return n - lostPeople
//}
//
//
//solutionH(5, [2,4], [3])

// 큰 수의 법칙
//
//9/9
//1/9
//9/1
//// / 나누기
//// % 나머지
//(8/4)*3
//
//let line1 = readLine()
//let line2 = readLine()
//
//var n: Int = 0
//var m: Int = 0
//var k: Int = 0
//var array:[Int] = []
//
//if let line1 = line1 {
//    let array = line1.components(separatedBy: " ")
//    n = Int(array[0])!
//    m = Int(array[1])!
//    k = Int(array[2])!
//}
//
//
//if let line2 = line2 {
//    array = line2.components(separatedBy: " ").map { Int($0)!}
//}
//func bigNumber() -> Int {
//    // 큰 수 더하기 위해 배열 큰 순서대로 정렬
//    array = array.sorted(by: >)
//
//    // k 차례 뽑기위해 k만큼 카운트
//    var count = 0
//
//    var result = 0
//
//    for _ in 1...m {
//        if count != k {
//           result += array[0]
//            count += 1
//        } else {
//            result += array[1]
//            count = 0
//        }
//    }
//
//    return result
//    
//}

//print(bigNumber())

// 책에서는 while을 사용하거나, 수열의 법칙을 찾아서 수학적으로 풀었음
//
//let line1 = readLine()
//let line2 = readLine()

var mapSize:[Int] = [4,4]
var map:[[Int]] = [[1,1,1,1],[1,0,0,1],[1,1,0,1],[1,1,1,1]]

var firstLocation:[Int] = [1,1]

// look -> 0북,1동,2남,3서
var firstLook: Int = 0


//if let line1 = line1 {
//    mapSize = line1.components(separatedBy: " ").map { Int($0)! }
//}
//
//if let line2 = line2 {
//    var array = line2.components(separatedBy: " ").map { Int($0)!}
//    firstLocation = Array(array.prefix(2))
//    firstLook = array.popLast()!
//}
//
//for _ in 1...mapSize[0] {
//    let line = readLine()?.components(separatedBy: " ").map { Int($0)!}
//    map.append(line!)
//}

var count = 1

// 0 북
// 1 동
// 2 남
// 3 서
let move = [[-1,0],
            [0,1],
            [1,0],
            [0,-1]]

var nowLocation = firstLocation

var isOcean: Bool = false

var fourDirection = 0


func direction(_ value: Int) -> Int {
    var value = value
    value -= 1
    if value == -1 {
        value = 3
    }
    
    return value
}

while isOcean == false {
    firstLook = direction(firstLook)
    nowLocation =  [move[firstLook][0] + firstLocation[0], move[firstLook][1] + firstLocation[1]]
    
    if map[nowLocation[0]][nowLocation[1]] == 0 {
        map[firstLocation[0]][firstLocation[1]] = 2
        firstLocation = nowLocation
        count += 1
        fourDirection = 0
    } else {
        fourDirection += 1
    }
    
    if fourDirection == 4 {
        if firstLook - 2 < 0 {
            nowLocation = [move[firstLook+2][0] + firstLocation[0], move[firstLook+2][1] + firstLocation[1]]
        } else {
            nowLocation = [move[firstLook-2][0] + firstLocation[0], move[firstLook-2][1] + firstLocation[1]]
        }
        
        map[firstLocation[0]][firstLocation[1]] = 2
        firstLocation = nowLocation
        
        if map[firstLocation[0]][firstLocation[1]] == 1 {
            isOcean = true
        }
        fourDirection = 0
    }
}

print(count)
print(map)
print(map[0][2])


var stack: [Int] = []

stack.append(3)
stack.append(2)
stack.append(1)
stack.popLast()
stack


var queue: [Int] = []

queue.append(3)
queue.append(2)
queue.append(1)
queue.removeFirst()

queue

let int = 1
func recursive(_ int: Int) {
    if int == 100 {
        return
    }
    print(int,"번째 재귀 함수에서",int+1,"번째 재귀 함수를 호출")
    recursive(int+1)
    print(int,"번째 재귀 함수 종료")
}

recursive(int)


func factorial(_ int: Int) -> Int {
    if int <= 1 {
        return 1
    }
    return int * factorial(int-1)
}

func solution(_ numbers:[Int], _ target:Int) -> Int {
    var count = 0
    
    func dfs(index: Int, sum: Int) {
        if index == (numbers.count - 1) && sum == target {
            count += 1
            return

        }

        guard index + 1 < numbers.count else { return }
        
        dfs(index: index + 1, sum: sum + numbers[index + 1])
        dfs(index: index + 1, sum: sum - numbers[index + 1])
    }
    
    dfs(index: -1, sum: 0)
    
    
    return count
}

//solution([1,1,1,1,1], 3)

solution([4,1,2,1], 4)


public func selectionSort<Element>(_ array: inout [Element]) where Element: Comparable {
    guard array.count >= 2 else {
        return
    }
    
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1 )..<array.count {
            if array[lowest] > array[other] {
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(lowest, current)
        }
    }
}

public func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
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

public func quickSort(_ array:inout [Int],_ start: Int, _ end: Int)  {
    if start >= end {
        return
    }
    
    var pivot = start
    var left = start + 1
    var right = end
    
    while left <= right {
        while left <= end && array[left] <= array[pivot] {
            left += 1
        }
        while right > start && array[right] >= array[pivot] {
            right -= 1
        }
        
        if left > right {
            array.swapAt(pivot, right)
        } else {
            array.swapAt(right, left)
        }
    }
    
    quickSort(&array, start, right - 1)
    quickSort(&array, right + 1, end)
}

public func quickSortH(_ array: [Int]) -> [Int] {
    guard array.count > 1 else {
        return array
    }
    
    let pivot = array[array.count / 2]
    let less = array.filter { $0 < pivot }
    let equal = array.filter { $0 == pivot }
    let greater = array.filter { $0 > pivot }
    
    return quickSortH(less) + equal + quickSortH(greater)
}


// 계수 정렬
// https://joycestudios.tistory.com/62
public func countSort(_ array: [Int]) -> [Int]{
    guard array.count > 1 else {
        return []
    }
    
    let maxElement = array.max()!
    
    var count = [Int](repeating: 0, count: (maxElement + 1))
    
    var sortedArray = [Int]()
    
    for element in array {
        count[element] += 1
    }
    
    for index in 0..<count.count{
        for _ in 1...count[index] {
            sortedArray.append(index)
        }
    }
    return sortedArray
}

var array2 = [7,5,9,0,3,1,6,2,9,1,4,8,0,5,2]

countSort(array2)


var array = [7,5,9,0,3,1,6,2,4,8]

quickSortH(array)

print(array)
quickSort(&array, 0, array.count-1)

print(array)

insertionSort(&array)
print(array)

selectionSort(&array)

print(array)

array.sort()



4/3
4/2
6%3
6/3
