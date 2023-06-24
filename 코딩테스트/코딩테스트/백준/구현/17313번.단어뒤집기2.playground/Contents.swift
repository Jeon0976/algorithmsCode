import Foundation

let testString = readLine()!

var forward = ""
var reverse = ""

var result = ""

for char in testString {
    if char == "<" {
        
        forward.append(char)
        
        if !reverse.isEmpty {
            result.append(contentsOf: reverse.reversed())
            reverse = ""
        }
    } else if char == ">" {
        forward.append(char)
        result.append(contentsOf: forward)
        forward = ""
    } else {
        if forward.first == "<" {
            forward.append(char)
        } else if char == " " {
            result.append(contentsOf: reverse.reversed())
            result.append(" ")
            
            reverse = ""
        } else {
            reverse.append(char)
        }
    }
}

if !reverse.isEmpty {
    result.append(contentsOf: reverse.reversed())
}

print(result)
