import Foundation

// N으로 표현
func solution(_ N: Int, _ number: Int) -> Int{
    if N == number {
        return 1
    }
    
    // Set x 8 초기화
    // 값 추가할 때 중복값을 제외하기 위해 Set으로 설정
    var dp = Array(repeating: Set<Int>(), count: 8)
    
    var answer = 0
    // 각 Set마다 기본 수 'N' * i 수 초기화
    for i in 1...8 {
        dp[i-1].insert(Int(String(repeating: "\(N)", count: i))!)
    }
    
//    print(dp)
    
    // n 일반화
    // n 첫번째는 이미 위에서 만들어짐 두번째부터 만들기
    for i in 1...7 {
        for j in 0..<i {
            // 3번째 넣을 때
            // 1.dp[j] = 0 (1번 Set)
            // 2.dp[j] = 1 (2번 Set)
            // 4 -> 1.0 2.1 3.2 4.3
            for op1 in dp[j] {
                // 1.dp[i-j-1] = 1 (2번 Set)
                // 2.dp[i-j-1] = 0 (2번 Set)
                // 4 -> 1.3 2.2 3.1 4.0
                for op2 in dp[i-j-1] {
                    dp[i].insert(op1 + op2)
                    dp[i].insert(op1 - op2)
                    dp[i].insert(op1 * op2)
                    if op2 != 0 {
                        dp[i].insert(op1 / op2)
                    }

                }
            }
        }
        print(dp)
        if dp[i].contains(number) {
            answer = i + 1
            break
        } else {
            answer = -1
        }
    }
    return answer
}

func solution2(_ N:Int, _ number:Int) -> Int {
    var dp = Array(repeating: Set<Int>(), count: 9)
    var result = Int.max
    for i in 1..<9{
        for j in 1..<i{
            for k in dp[i - j]{
                for l in dp[j]{
                    
                    if k - l > 0{
                        dp[i].insert(k - l)
                        if k - l == number{result = min(result, i)}
                    }
                    if l != 0 && k != 0{ //Division by zero 처리
                        dp[i].insert(k / l)
                        if k / l == number{result = min(result, i)}
                    }
                    dp[i].insert(k + l)
                    dp[i].insert(k * l)
                    if k + l == number{result = min(result, i)}
                    if k * l == number{result = min(result, i)}
                }
            }
        }
        var str = ""
        for _ in 1...i{
            str += "\(N)"
        }
        dp[i].insert(Int(str)!)
        if Int(str)! == number{result = min(result, i)}
    }
    if result == Int.max{
        result = -1
    }
    
    print(dp)
    return result
}

//solution2(9, 32000)
print()
solution(9, 32000)
