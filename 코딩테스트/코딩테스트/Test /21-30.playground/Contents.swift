import Foundation

func whatIs(_ num: Int) -> Bool {
    return num % 2 == 0 ? true : false
}



func solution(_ num_list:[Int]) -> [Int] {
    var even = 0
    var odd = 0
    
    num_list.forEach { value in
        if whatIs(value) {
            even += 1
        } else {
            odd += 1
        }
    }
    
    return [even,odd]
}

func solution2(_ num_list:[Int]) -> [Int] {
    [num_list.filter { $0 % 2 == 0 }.count, num_list.filter { $0 % 2 != 0}.count]
}

solution([1,2,3,4,5])
solution2([1,2,3,4,5])


func solution3(_ my_string:String, _ n:Int) -> String{
    
    return my_string.map { String(repeating: $0, count: n)}.joined()
}


solution3("asdasd", 2)


func solution4(_ my_string:String, _ letter:String) -> String {
    return my_string.filter { String($0) != letter }
}

solution4("abde", "d")


func evenAdd(_ n:Int) -> Int {
    var evenSum = 0
    
    for i in 1...n {
        if i % 2 == 0 {
            evenSum += i
        }
    }
    
    return evenSum
}

func solution22(_ dot:[Int]) -> Int {
    
    if  dot[0] > 0 && dot[1] > 0
    {return 1}
    if dot[0] > 0 && dot[1] < 0
    { return 4 }
    if  dot[0] < 0 && dot[1] > 0
    {return 2 }
    if dot[0] < 0 && dot[1] < 0
    { return 3 }
    return 0
}

func solutionSwitch(_ dot:[Int]) -> Int {
    switch (dot[0], dot[1]) {
    case (0..., 0...): return 1
    case (...0, 0...): return 2
    case (...0, ...0): return 3
    case (0..., ...0): return 4
    default: return 0
    }
}

func solution31(_ numbers:[Int]) -> Int {
    if numbers.filter ({ $0 == numbers.max() }).count > 1 {
        let max = numbers.max()!
        return max * max
    } else {
        let max1 = numbers.max()!
        let numbers2 = numbers.filter { $0 != max1 }
        let max2 = numbers2.max()!
        
        return max1 * max2
    }
}

func solution66(_ numbers:[Int]) -> Int {
    let n = numbers.sorted()
    return (n[n.count-1] * n[n.count-2])
}
//solution31([5,5,5,5,5,5])

let ef = [5,5,5,5,5]
ef.max()
