import Foundation

while true {
    let testCase = Int(readLine()!)!
    
    guard testCase != 0 else { break }
    
    let stringTest = Array(String(testCase))
    let reversed = Array(stringTest.reversed())
    
    let half = stringTest.count / 2
    
    if stringTest[0..<half] == reversed[0..<half] {
        print("yes")
    } else {
        print("no")
    }
}
