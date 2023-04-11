import Foundation

func solution1(_ name: String) -> Int {
    let name = name.map { String($0) }
    let dic = [
        "A":0,"B":1,"C":2,"D":3,"E":4,"F":5,"G":6,"H":7,
        "I":8,"J":9,"LK":10,"L":11,"M":12,"N":13,"O":12,
        "P":11,"Q":10,"R":9,"S":8,"T":7,"U":6,"V":5,"W":4,
        "X":3,"Y":2,"Z":1
    ]
    
    let nameCount = name.count
    var result = 0
    var count = nameCount - 1
    
    for (index,element) in name.enumerated() {
        if element != "A" {
            var nextIndex = index + 1
            // 연속된 A가 많으면 되돌아 가는 경우
            while nextIndex < nameCount && name[nextIndex] == "A" {
                nextIndex += 1
            }
            let move = (index * 2) + nameCount - nextIndex
            print(move)
            print(count)
            count = min(move,count)
        }
        
        for (key, value) in dic {
            if element == key {
                result += value
            }
        }
    }
    return result + count
}

solution1("BAAAAIAAAAAA")

// 큰 수 만들기
// 스텍으로 풀어여함
func solution2(_ number: String, _ k:Int) -> String {
    
    var _k:Int = k
    
    let numbers:[Character] = Array(number)
    let n:Int = numbers.count
    
    var stack:[Character] = []
    
    for num in numbers {
        while !stack.isEmpty && _k > 0 && stack.last!.wholeNumberValue! < num.wholeNumberValue! {
            stack.removeLast()
            _k -= 1
        }
        
        if stack.count < n-k {
            stack.append(num)
            print(stack)
        }
    }
    
    
    return String(stack)
}

solution2("1231234", 3)


// 소수 찾기
// depth: 지금까지 만들어진 숫자의 자리 수(0부터 시작해서 1씩 더해가다 count가 되면 숫자 완성)
// string: 선택된 숫자
// count: 만들 숫자의 자리 수
func solution3(_ numbers: String) -> Int {
    let arr = numbers.map { String($0) }
    
    var result: [Int] = []
    var checkList: [Int] = Array(repeating: 0, count: arr.count)
    var number = ""
    
    // 소수 찾기
    func isPrime(_ n:Int) -> Bool {
        guard n > 1 else { return false }
        guard n != 2 else { return true }
        
        var isprime = true
        
        for i in 2...Int((sqrt(Double(n)))) + 1 {
            if n % i == 0 {
                isprime = false
                break
            }
        }
        
        return isprime
    }
    
    func DFS(_ depth: Int, _ string: String, _ count: Int) {
        // depth 와 count 같다면 숫자 완성
        if depth == count {
            print(string)
            if let number = Int(string) {
                if isPrime(number) && !result.contains(number) {
                    result.append(number)
                }
            }
        } else {
            for i in 0..<arr.count {
                // 해당 숫자가 체크되어 있지 않은 경우
                if checkList[i] == 0 {
                    // 숫자를 추가로 선택
                    number += arr[i]
                    // 선택된 숫자는 체크
                    checkList[i] = 1
                    DFS(depth + 1, number, count)
                    checkList[i] = 0
                    number = string
                }
            }
        }
        print("result: ",result)
    }
    
    for i in 1...arr.count {
        DFS(0, "", i)
    }
    
    return result.count
}

solution3("011")
