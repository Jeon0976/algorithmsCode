import Foundation

/// 중앙값 구하기
func solution(_ array: [Int]) -> Int {
    var sortedArray: [Int] = array.sorted()
    
    var middlePosition: Int = sortedArray.index(0, offsetBy: (sortedArray.count)/2)
    
    var middleInt: Int = sortedArray[middlePosition]
    
    return middleInt
}

// 개선 코드
func solution_re(_ array: [Int]) -> Int {
    array.sorted()[array.count / 2]
}

solution_re([1,2,7,10,11])


/// 최빈값 구하기
// 이 방법이 효과가 더 빠르다?
func manyTimeInt(_ array: [Int]) -> Int {
    var count = 0
    var maxValue = 0
    var manyTimeInt: [Int:Int] = array.reduce(into: [:]) { partialResult, value in
        return partialResult[value, default: 0] += 1
    }

    let ss = manyTimeInt.values.max()
    
    for dicValue in manyTimeInt {
        if dicValue.value == ss {
            count += 1
            maxValue = dicValue.key
        }
    }
    
    return count == 1 ? maxValue : -1
}
func manyTimeInts(_ array: [Int]) -> Int {
    var manyTimeInt: [Int:Int] = [:]
    var maxCount = 0
    var maxValue = 0
    
    for value in array {
        manyTimeInt[value, default: 0] += 1
        
        if let count = manyTimeInt[value], count > maxCount {
            maxCount = count
            maxValue = value
        }
    }
    print(manyTimeInt)
    print(maxValue)
    print(maxCount)
    return maxCount == 1 ? maxValue : -1
}


// 방법 1
func manyTimeInt2(_ array: [Int]) -> Int {
    let sorted = Dictionary(grouping: array) { $0 }.sorted { $0.value.count > $1.value.count }
    return sorted.count > 1 && sorted[0].value.count == sorted[1].value.count ? -1 : sorted[0].key
}


manyTimeInts([1,2,3,3,3,3,4,4,4,5,1,1,12,3,3,33,3,3,2,44,5,12,5,166,6,6,2,13,2,4,5,2,3,1,45,5,6,4])
manyTimeInt2([1,2,3,3,3,3,4,4,4,5,1,1,12,3,3,33,3,3,2,44,5,12,5,166,6,6,2])


// 짝수는 싫어요
func hateEven(_ n:Int) -> [Int] {
    var onlyOdd: [Int] = []
    for i in 1...n {
        if i % 2 != 0 {
            onlyOdd.append(i)
        }
    }
    
    return onlyOdd
}

// 정규식 filter 활용
func hateEvenFilter(_ n: Int) -> [Int] {
    (0...n).filter { $0 % 2 == 1}
}

hateEven(15)
hateEvenFilter(15)


// 나의 해결법
func solution(_ n:Int) -> Int {
    var pizza = 6
    
    while pizza % n != 0 {
        pizza += 6
    }
    return pizza / 6
}

// 최대공약수를 활용한 해결 방법
func solution1(_ n:Int) -> Int {
    let div: [Int] = [6,3,2,1].filter { n % $0 == 0}
    return (n / div[0])
}

func sol(_ numbers:[Int]) -> Double {
    var sum: Int = 0
    
    sum = numbers.reduce(0) { partialResult, value in
         partialResult + value
    }
    
    var avg: Double = Double(sum) / Double(numbers.count)
    return avg
}

sol([1, 2, 3, 4, 5, 6, 7, 8, 9, 10] )
 
150000 - (150000 * 5/100)

15000/5500

2022 - 40
2022 - 23


func solution(_ hp:Int) -> Int {
    return 0
}
