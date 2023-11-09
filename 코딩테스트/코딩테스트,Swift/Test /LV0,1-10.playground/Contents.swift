import Foundation

func solution1(_ array:[Int], _ n:Int) -> Int {
    var count = 0


    for i in array {
        if i == n {
            count += 1
        }
    }
    return count
}

solution1([2,4,4,6], 4)

func imSolution1(_ array:[Int], _ n:Int) -> Int {
    array.filter { $0 == n}.count
}

func gcd(_ a:Int, _ b:Int) -> Int {
    if a % b == 0 {
        return b
    }
    return gcd(b, a % b)
}

func solution(_ numer1:Int, _ denom1:Int, _ numer2:Int, _ denom2:Int) -> [Int] {
    var mother: Int = denom1 * denom2
    var son: Int = (numer1 * denom2) + (numer2 * denom1)

    var gcd = gcd(son, mother)

    var result = [son/gcd, mother/gcd]


    return result
}

func vv(_ numbers:[Int]) -> [Int] {
    var cNumbers: [Int] = []
    for number in numbers {
        print(number)
        cNumbers.append(number * 2)
    }
    return cNumbers
}

vv([2,3,4,5,6])
func imVv(_ number: [Int]) -> [Int] { number.map { $0 * 2 }}
imVv([1,2,3,4,5])



var numbers: [Int] = [1,2,3,4,5,6]
print(numbers)


var doubleNumbers: [Int] = []
var strings: [String] = []

// for문 사용
for number in numbers {
    doubleNumbers.append(number * 2)
    strings.append("\(number)")
}

// map 사용
doubleNumbers = numbers.map { $0 * 2}
print(doubleNumbers)
doubleNumbers = numbers.map ({(number: Int) -> Int in
    number * 2
})
print(doubleNumbers)
print(numbers)

let dic: [String:Int] = ["a":1,"b":2]

let key: [String] = dic.map { $0.0 }
print(key)


let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter ({ (name: String) -> Bool in
    return name.count < 5
})
print(shortNames)// Prints "["Kim", "Karl"]"

let letters = "abracadabra"

let lettersCount = letters.reduce(into: 0) { count, value in
    if value == "a" {count += 1}
}

let lettersFullCount = letters.reduce(into: [:]) { count, value in
    count[value, default: 0] += 1
}

let vve = letters.reduce(0) { (result, next: String.Element) -> Int in
    var count = 0
    if next == "a" { count += 1 }
    return result + count
}

let ve: Int = letters.filter { $0 == "b" }.count
vve
ve
let numberss = [2,5,6]
numberss.reduce(0, +)
numberss.reduce(0) { partialResult, next in
    print("\(partialResult) + \(next)")
    return partialResult + next
}

numberss.reduce(into: 0) {result, next in
    return result += next
}
numberss.reduce(0, +)

