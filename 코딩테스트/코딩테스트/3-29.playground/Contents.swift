import Foundation
// 1. 평균 구하기 -
// 2. 자릿수 더하기 -
// 3. 짝수와 홀수 -
// 4. 약수의 합 -
// 5. x만큼 간격이 있는 n개의 숫자 -
// 6. 정수 제곱근 판별 - 13:36
// 7. 나머지가 1이 되는 수 찾기 - 13:45
// 8. 문자열 내 p와 y의 개수 - 14:06
// 9. 자연수 뒤집어 배열로 만들기 - 14:17
// 10. 정수 내림차순으로 배치하기 - 14:36
// 11. 문자열을 정수로 바꾸기 - 14:39
// 12. 하샤드 수 - 14:50
// 13. 두 정수 사이의 합 - 14:56
// 14. 서울에서 김서방 찾기 - 15:00
// 15. 나누어 떨어지는 숫자 배열 - 15:12
// 16. 핸드폰 번호 가리기 - 15:25
// 17. 음양 더하기 - 15:53
// 18. 제일 작은 수 제거하기 - 15:58
// 19. 없는 숫자 더하기 - 16:09

// 2
func solution2(_ n:Int) -> Int
{
    var answer:Int = 0
    let stringN: [Character] = String(n).map { $0 }
    stringN.forEach { answer += Int(String($0))! }
    
    print(answer)
    
    return answer
}

func solution2L(_ n:Int) -> Int {
    var answer:Int = 0
    
    for i in String(n) {
        answer += Int(String(i))!
    }
    
    return answer
}

func solution2H(_ n:Int) -> Int {
    return String(n).reduce(0, {$0+Int(String($1))!})
}
     
solution2H(534)

// 4
func solution4(_ n:Int) -> Int {
    guard n != 0 else {
        return 0
    }
    
    guard n != 1 else {
        return 1
    }
    
    var sum = 0
    
    for i in 1...n/2 {
        if n % i == 0 {
            sum += i
        }
    }
    sum += n
    return sum
}

solution4(12)

// 5
func solution5(_ x:Int, _ n:Int) -> [Int64] {
    var xArray: [Int64] = []

    for i in 1...n {
        xArray.append(Int64(i)*Int64(x))
    }

    return xArray
}

func solution5H(_ x:Int, _ n:Int) -> [Int64] {
    return Array(1...n).map { Int64($0 * x) }
}


// 7
func solution7(_ n:Int) -> [Int] {
    
    return (1...n).filter { n % $0 == 1 }
}

solution7(10)

// 8!!!!
func solution8(_ s:String) -> Bool
{
    let  sLower = s.lowercased()
        
    let pString = sLower.filter { $0 == "p" }
    let yString = sLower.filter { $0 == "y" }
    
    let pStringCount = pString.count
    let yStringCount = yString.count
    
    guard pStringCount != 0 || yStringCount != 0 else {
        return true
    }
    
    guard pStringCount != 0 else {
        return false
    }
    guard yStringCount != 0 else {
        return false
    }
    
    guard pStringCount == yStringCount else {
        return false
    }
    
    return true
    
}

func solution8H(_ s:String) -> Bool  {
    let string = s.lowercased()
    
    return string.components(separatedBy: "p").count == string.components(separatedBy: "y").count
}

solution8H("pwdpawdpadpadwp")


// 9
func solution9(_ n:Int64) -> [Int] {
    
    return String(n).map { Int(String($0))!}.reversed()
}

solution9(1234)

// 10
func solution10(_ n:Int64) -> Int64 {
    Int64(String(String(n).sorted(by: >)))!
}

solution10(118372)

// 11
// 숫자 자리수 다 더하기 reduce 함수 활용방법
func solution11(_ x:Int) -> Bool  {
   let xSum = String(x).reduce(0,{$0 + Int(String($1))!})

    return x % xSum == 0 ? true : false
}
solution11(11)

// 12
func solution12(_ a:Int, _ b:Int) -> Int64 {
    guard a < b else {
        return Int64((b...a).reduce(0,+))
    }
    return Int64((a...b).reduce(0,+))
}

// 수열로 풀기
func solution12H(_ a:Int, _ b:Int) -> Int64 {
    return Int64(a + b) * Int64(max(a, b) - min(a, b) + 1) / Int64(2)
}


func solution14(_ seoul:[String]) -> String {
    return "김서방은 \(seoul.firstIndex(of: "Kim")!)에 있다"
}

solution14(["Jane", "Kim"]    )

func solution15(_ arr:[Int], _ divisor:Int) -> [Int] {
    let arr = arr.filter { $0 % divisor == 0 }
    
    
    return arr.count > 0 ? arr.sorted() : [-1]
}

// repeating, suffix & preffix 외우기
func solution16(_ phone_number:String) -> String {
    return String(repeating: "*", count: phone_number.count - 4) + phone_number.suffix(4)
}

solution16("01033334444"  )



// 17 Dic?
func solution17(_ absolutes:[Int], _ signs:[Bool]) -> Int  {
    var count = 0
    var mappingInt = 0
    
    for absolute in absolutes {
        if signs[count] == false {
            mappingInt += -absolute
        } else {
            mappingInt += absolute
        }
        count += 1
    }
    
    return mappingInt
    
}

func solution17H(_ absolutes:[Int], _ signs:[Bool]) -> Int {
    return (0..<absolutes.count).map { signs[$0] ? absolutes[$0] : -absolutes[$0] }.reduce(0, +)
}


solution17([4, 7, 12]   , [true,false,true]    )

// 18
func solution18(_ arr:[Int]) -> [Int] {
    let min = arr.min()!
    
    let reduceArr = arr.filter { $0 != min }
    
    return reduceArr.count != 0 ? reduceArr : [-1]
}

solution18([4]    )


// 19 contains 까먹지말자!!
func solution19(_ numbers:[Int]) -> Int {
    return (0...9).filter { !numbers.contains($0) }.reduce(0,+)
}

solution19([1,2,3,4,6,7,8,0])


