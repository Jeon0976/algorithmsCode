import Foundation

func solution(_ numbers:[Int]) -> String {
    var sortedNumbers = numbers.sorted {
        Int("\($0)\($1)")! > Int ("\($1)\($0)")!
    }
    
    if sortedNumbers[0] == 0 {
        return "0"
    }
    
    return sortedNumbers.reduce("") { $0 + "\($1)"}
}

solution([0,0,0,0,0])
