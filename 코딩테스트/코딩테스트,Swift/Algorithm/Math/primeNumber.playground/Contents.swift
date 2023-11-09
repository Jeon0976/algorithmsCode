import Foundation

// find primeNumber

// 1. simple solution
func findPrimeNumber1(_ num: Int) -> Bool {
    guard num > 1 else { return false }
    guard num != 2 else { return true }
    
    for i in 2..<num {
        if num % i == 0 {
            return false
        }
        
    }
    return true
}

func findPrimeNumber2(_ num: Int) -> Bool {
    guard num > 2 else { return false }
    guard num != 2 else { return true }
    
    for i in 2...num/2 {
        if num % i == 0 {
            return false
        }
    }
    return true
}

func findPrimeNumber3(_ num: Int) -> Bool {
    guard num > 2 else { return false }
    guard num != 2 else { return true }
    
    for i in 2..<Int((sqrt(Double(num)))) + 1 {
        if num % i == 0 {
            return false
        }
    }
    return true
}


let n = 1000
// 처음에는 모든 수가 소수(true)인 것으로 초기화 (0과 1은 제외)
var array = [Bool](repeating: true, count: n + 1)

// 에라토스테네스의 체 알고리즘
for i in 2..<Int(sqrt(Double(n))) + 1 {  // 2부터 n의 제곱근까지의 모든 수를 확인하며
    if array[i] == true {  // i가 소수인 경우
        // i를 제외한 i의 모든 배수 지우기
        var j = 2
        while i * j <= n {
            array[i * j] = false
            j += 1
        }
    }
}

// 모든 요소 출력
for i in 2...n {
    if array[i] == true {
        print(i, terminator: " ")
    }
}
findPrimeNumber1(1232573)
findPrimeNumber2(1232573)
findPrimeNumber3(1232573)

