import Foundation

func solution(_ N: Int, _ number: Int) -> Int {
    guard N != number else {
        return 1
    }
    
    // Set 형태로 초기화
    var dp = Array(repeating: Set<Int>(), count: 8)
    
    var answer = 0
    
    // 각 Set 마다 N * i 초기화
    for i in 0...7 {
        dp[i].insert(Int(String(repeating: "\(N)", count: i+1))!)
    }
    
    // dp 점화식 돌리기
    // 계산은 최소 숫자 2개 이상이여야 하니깐 1번째 배열부터 조건 할 수 있도록 for문 조정
    for i in 0...7 {
        for j in 0..<i {
            for op1 in dp[j] {
                for op2 in dp[i-j-1] {
                    dp[i].insert(op1 + op2)
                    dp[i].insert(op1 - op2)
                    dp[i].insert(op1 * op2)
                    if op2 != 0 {
                        dp[i].insert(op1/op2)
                    }
                }
            }
        }
        if dp[i].contains(number) {
            answer = i + 1
            break
        } else {
            answer = -1
        }
    }
    
    return answer
}

solution(5, 12)

var ded = [1,2,3,4,5,6]

ded.removeAll()
