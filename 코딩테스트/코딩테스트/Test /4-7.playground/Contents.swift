import Foundation

// 가장 큰수 Lv2
// 정수를 이어 붙여 만들 수 있는 가장 큰 수를 알아내라.
func solution1(_ numbers:[Int]) -> String {

    let sorted: [Int] = numbers.sorted { Int("\($0)\($1)")! > Int("\($1)\($0)")!}

    if sorted[0] == 0 {
        return "0"
    }
    return sorted.reduce("") { $0 + "\($1)"}
}
solution1([3, 30, 34, 5, 9]    )
3/10
10/10
3/1
4412/100
4431/100
3/1000
3244/1000
3970/10
3244/100

var number = 1424
if number >= 1000 {
    print("HI")
} else if number >= 100 {
    print("dw")
} else {
    print("dwd")
}

var wd = String(3810/10)
let index = wd.index(wd.startIndex, offsetBy: 1)
let dd = wd.index(after: wd.startIndex)
let result = Int(String(wd[dd]))!
