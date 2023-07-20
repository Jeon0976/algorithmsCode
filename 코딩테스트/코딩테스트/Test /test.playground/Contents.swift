import Foundation

(((((1/2)*3)-4)+5)+6)

(((((1+2)/3)*4)-5)+6)


var value = 1
for _ in 0..<1-1 {
    value *= 10
}


var value2 = 1
for _ in 0..<3-1 {
    value2 *= 10
}
func findDigit(_ num: Int) -> Int {
    var digitCount = 1
    
    if num > 0 {
        digitCount = Int(log10(Double(num))) + 1
    }
    return digitCount
}

print(findDigit(100))
