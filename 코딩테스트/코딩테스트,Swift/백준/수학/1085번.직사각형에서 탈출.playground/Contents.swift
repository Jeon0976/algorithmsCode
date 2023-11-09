import Foundation


// 왼쪽 오른쪽 위 아래로 가서 작은 숫자
// x는 w를 넘을 수 없고, y는 h를 넘을 수 없다.

let testCase = readLine()!.components(separatedBy: " ").map { Int($0)! }

let x = testCase[0]
let y = testCase[1]
let w = testCase[2]
let h = testCase[3]

let coor = (x,y)

let xMax = w - x
let xMin = x - 0
let yMax = h - y
let yMin = y - 0


print(min(xMax, xMin, yMax, yMin))
