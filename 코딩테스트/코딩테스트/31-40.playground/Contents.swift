import Foundation

func solution1(_ numbers:[Int], _ num1:Int, _ num2:Int) -> [Int] {
    return Array(numbers[num1...num2])
}

func solution2(_ age:Int) -> String {
    let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]
    return String(age).map{alphabet[Int(String($0))!]}.joined()
}

// 고차함수 활용하기
func solution3(_ emergency:[Int]) -> [Int] {
    var dictionary = [Int:Int]()

    var count = 1
    var result = [Int]()
    
    for i in emergency.sorted(by: >) {
        dictionary[i] = count
        count += 1
    }
        
    for i in emergency {
        result.append(dictionary[i]!)
    }

    return result
}

func solution3_high(_ emergency:[Int]) -> [Int] {
    emergency.map { emergency.sorted(by: > ).firstIndex(of: $0)! + 1}
}

solution3([3,76,24])
solution3([3,76,24])

let em = [1,4,63,25]
em.sorted(by: >)
em.firstIndex(of: 1)


// 고차함수 활용하기
// 약수 구하기 알고리즘 
func solution4(_ n:Int) -> Int {
    guard n != 1 else { return 1}
    var count = 0
    for value in 1...n/2 {
        if n % value == 0 {
            count += 1
        }
    }
        
    return count + 1
}

func solution4_high(_ n:Int) -> Int {
    (1...n).filter { n % $0 == 0 }.count
}

solution4(1)

// 장군 5
// 병정 3
// 일 1

((29 % 5) % 3 ) / 1

func solution5(_ letter:String) -> String {
    let morse:[String: String] = [
        ".-":"a","-...":"b","-.-.":"c","-..":"d",".":"e","..-.":"f",
        "--.":"g","....":"h","..":"i",".---":"j","-.-":"k",".-..":"l",
        "--":"m","-.":"n","---":"o",".--.":"p","--.-":"q",".-.":"r",
        "...":"s","-":"t","..-":"u","...-":"v",".--":"w","-..-":"x",
        "-.--":"y","--..":"z"
    ]

    var result = ""
    
    letter.split(separator: " ").forEach {
        if let value = morse[String($0)] {
            result += value
        }
    }
    
    return result
}

solution5(".... . .-.. .-.. ---")

let rsp = "205"

let wdwd = rsp.map{ $0 == "2" ? "0" : $0 == "0" ? "5" : "2"}.joined()

print(wdwd)
