import Foundation

func solution(_ num_list:[Int], _ n:Int) -> [[Int]] {
    var array:[Int] = []
    var array2:[[Int]] = []
    
    for i in num_list.indices {
        array.append(num_list[i])
        print(num_list[i])
        if (i + 1) % n == 0 {
            array2.append(array)
            array = []
        }
    }
    
    return array2
}

solution([100, 95, 2, 4, 5, 6, 18, 33, 948], 3)

1 % 3
3 % 3

// n! / (n-m)! * m!


func pactorial(_ number:Double) -> Double {
    var pac:Double = 1
    for i in stride(from: number, to: 0, by: -1){
        pac *= Double(i)
    }
    
    return pac
}

func pacReduce(_ number:Int) -> Int {
    (1...number).reduce(1, *)
}

pactorial(5)

func solution2(_ balls:Int, _ share:Int) -> Int {
    if share > balls { return -1 }
    let n = pactorial(Double(balls))
    let m = pactorial(Double(share))
    let nNiM = pactorial(Double(balls-share))
    
    return Int(round(n / ( nNiM * m )))
}

solution2(3, 2)


func solution3(_ numbers:[Int], _ k:Int) -> Int {
    var result = 1
    guard k != 1 else { return 1 }
    
    for _ in 0..<k-1 {
        print(k)
        result += 2
        if result > numbers.last! {
            result = result - numbers.last!
        }
    }
    
    return result
}

func solution3H(_ numbers:[Int], _ k:Int) -> Int {
    return numbers[((k-1)*2) % numbers.count]
}

func solution3High(_ numbers:[Int] , _ k:Int) -> Int {
    return (1...k).map { _ in numbers }.flatMap { $0 }[2 * (k-1)]
}

solution3H([1,2,3,4], 5)


func right(_ numbers:[Int]) -> [Int] {
    let numbersLast = numbers.last!
    var rightNumbers: [Int] = []
    
    rightNumbers.append(numbersLast)
    
    for i in 0...numbers.count - 2 {
        let temp  = numbers[i]
        rightNumbers.append(temp)
    }
    
    return rightNumbers
}

func left(_ numbers:[Int]) -> [Int] {
    let numbersFirst = numbers.first!
    var leftNumbers: [Int] = []

    for i in 1...numbers.count - 1 {
        let temp = numbers[i]
        leftNumbers.append(temp)
    }
    leftNumbers.append(numbersFirst)
    
    return leftNumbers
}

func solution4(_ numbers:[Int], _ direction:String) -> [Int] {
    return direction == "right" ? right(numbers) : left(numbers)
}


func solution4H(_ numbers:[Int], _ direction:String) -> [Int] {
    var nums = numbers
    direction == "right" ? nums.insert(nums.removeLast(), at: 0) : nums.append(nums.removeFirst())
    
    return nums
}


func solution5(_ strlist:[String]) -> [Int] {
    strlist.map { $0.count }
}

solution5(["I", "Love", "Programmers."]    )


func solution6(_ sides:[Int]) -> Int {
    let max = sides.max()!
    let min = sides.min()!
    var middle = 0
    
    var maxCount = 0
    var minCount = 0
    
    for side in sides {
        if side == max {
            maxCount += 1
        }
        
        if side == min {
            minCount += 1
        }
        
        if side != max && side != min {
            middle = side
        }
    }
    
    if middle == 0 {
        if maxCount > minCount {
            middle = max
        } else {
            middle = min
        }
    }
    
    return max >= (middle + min) ? 2 : 1
}

solution6([4,4,3])


func solution6H(_ sides:[Int]) -> Int {
    var sortedSides = sides.sorted()
    
    return sortedSides[0] + sortedSides[1] > sortedSides[2] ? 1 : 2
}


func solution7(_ s1:[String], _ s2:[String]) -> Int {
    s1.map { s1String in
        s2.filter { s2String in
            s2String == s1String
        }.count
    }.reduce(0, +)
}

func solution7H(_ s1:[String], _ s2:[String]) {
    // contaions 활용하여 [false, true, true]
    // filter 활용하여 true만 건짐
    // count 활용
//    s1.map(s2.contains(_:)).filter{ $0 }.count
}

solution7H(["a", "b", "c"] , ["com", "b", "d", "p", "c"]    )


"happy birthday!".count
"I love you~".count


func solution9(_ my_string:String) -> String {
    my_string.filter { $0 != "a" && $0 != "e" && $0 != "i" && $0 != "o" && $0 != "u"   }
}

func solution9F(_ my_string:String) -> String {
    var deletedVowel = my_string
    
   deletedVowel = my_string.filter { $0 != "a" && $0 != "e"}
   deletedVowel = deletedVowel.filter {$0 != "i" && $0 != "o" && $0 != "u" }
    return deletedVowel
}

func solution9H(_ my_string:String) -> String {
    return my_string.filter { !["a", "e", "i", "o", "u"].contains($0)}
}

solution9F("nice to meet you")

func solution10(_ my_string:String) -> Int  { my_string.filter{["1","2","3","4","5","6","7","8","9","0"].contains($0)}.map{Int(String($0)) ?? 0}.reduce(0, +)
}

func solution10H(_ my_string:String) -> Int {
     return my_string.compactMap{Int(String($0))}.reduce(0,+)
}

func solution10HH(_ my_string:String) -> Int {
    return my_string.filter{$0.isNumber}.map{Int(String($0))!}.reduce(0, +)
}

solution10HH("1a2b3c4d123")

func solution11(_ n:Int) -> Int{
    let d = String(n)
    return d.map { Int(String($0))!}.reduce(0, +)
}

func solution11NonHigh(_ n: Int) -> Int {
    var mutableN = n
    var answer = 0
    
    while mutableN > 0 {
        answer += mutableN % 10
        mutableN /= 10
    }
    return answer
}

solution11NonHigh(23213)
