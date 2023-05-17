import Foundation

var count = 0

//let numCount = Int(readLine()!)!
//let numArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

let numCount = 4
let numArray = [1,3,5,7]

let numArrayMaxValue = numArray.max()!

var checkCount = [Bool](repeating: true, count: numArrayMaxValue + 1)

for i in 2..<Int(sqrt(Double(numArrayMaxValue))) + 1 {
   if checkCount[i] == true {
       var j = 2
       while(i * j) <= numArrayMaxValue {
           checkCount[i * j] = false
           j += 1
       }
   }
}

checkCount[0] = false
checkCount[1] = false

for num in numArray {
    if checkCount[num] == true {
        count += 1
    }
}

print(count)

