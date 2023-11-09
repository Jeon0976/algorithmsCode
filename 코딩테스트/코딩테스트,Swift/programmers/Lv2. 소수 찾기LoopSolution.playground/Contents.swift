import Foundation

func solution(_ numbers: String) -> Int {
    let arr = numbers.map { String($0) }
    var prime_set = Set<Int>()
    var result = [[String]]()
    var resultValue = [String]()
    
    // 1. 모든 숫자 조합을 만든다.
    for i in 1...arr.count {
        result += permutation(arr, i)
    }

    for resultArray in result {
        var value = String()
        for number in resultArray {
            value += number
        }
        resultValue.append(value)
    }
    
    // 2. 소수가 아닌 수를 제외한다.
    for number in resultValue {
        if isPrime(Int(number)!) {
            prime_set.insert(Int(number)!)
        }
    }
    
    return prime_set.count
}


func isPrime(_ num: Int) -> Bool {
    guard num > 1 else { return false }
    guard num != 2 else { return true }
    
    for i in 2..<Int(sqrt(Double(num))) + 1 {
        if num % i == 0 {
            return false
        }
    }
    return true
}


// 서로 다른 n개 중에 r개를 선택하는 경우의 수
func permutation(_ array: [String], _ n: Int) -> [[String]] {
    var result = [[String]]()
    
    guard array.count >= n else { return result }
    
    var visited = Array(repeating: false, count: array.count)
    
    func cycle(_ now: [String]) {
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


