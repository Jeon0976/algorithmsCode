import Foundation

func solution(_ number: String, _ k: Int) -> String {
    //
    var _k = k
    
    var numberArray = number.map { String($0) }
    
    var stack = [String]()
    
    for i in 0...numberArray.count - 1 {
        while i < numberArray.count, !stack.isEmpty, _k > 0 {
            if stack.last! < numberArray[i] {
                stack.removeLast()
                _k -= 1
            } else {
                break
            }
        }
        
        if stack.count < numberArray.count - k {
            stack.append(numberArray[i])
        }
    }
    
    return stack.reduce("", +)
}

solution("221", 2)
