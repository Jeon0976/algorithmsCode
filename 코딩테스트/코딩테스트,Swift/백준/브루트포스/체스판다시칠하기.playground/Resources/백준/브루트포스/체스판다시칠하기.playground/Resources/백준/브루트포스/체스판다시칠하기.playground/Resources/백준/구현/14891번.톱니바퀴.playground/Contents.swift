import Foundation

var gears = [[Int]]()

// 12시부터 시계방향 순으로 생성
// 0:N 1:S
// index 6 왼쪽, index 2 오른쪽
// 1 시계 -1 반시계
for _ in 0...3 {
    let array = Array(readLine()!).map {Int(String($0))!}
    
    gears.append(array)
}

let rotatedCount = Int(readLine()!)!

var rotatedValue = [[Int]]()

for _ in 0..<rotatedCount {
    let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    rotatedValue.append(array)
}


func lotationGear (_ gear: Int, _ direction: Int) {
    var compareGears = gears
    
    var leftGear = gear
    var rightGear = gear
    var leftDirection = direction
    var rightDirection = direction
    var nextGear = false
    
    // 처음 gear 움직이기
    if direction == 1 {
        compareGears[gear-1].insert(compareGears[gear-1].last!, at: 0)
        compareGears[gear-1].removeLast()
        leftDirection = -1
        rightDirection = -1
    } else {
        compareGears[gear-1].append(compareGears[gear-1].first!)
        compareGears[gear-1].removeFirst()
        leftDirection = 1
        rightDirection = 1
    }
    
    if leftGear - 2 >= 0 {
        nextGear = isLotationLeftGear(gear-1, gear-2)
        
        leftGear -= 2
        
        for _ in 0...2 {

            if nextGear {
                if leftDirection == 1 {
                    compareGears[leftGear].insert(compareGears[leftGear].last!, at: 0)
                    compareGears[leftGear].removeLast()
                    leftDirection = -1
                } else if leftDirection == -1 {
                    compareGears[leftGear].append(compareGears[leftGear].first!)
                    compareGears[leftGear].removeFirst()
                    leftDirection = 1
                }
                nextGear = isLotationLeftGear(leftGear, leftGear-1)

                leftGear -= 1
            } else {
                break
            }
        }
    }
    
    if rightGear < 4 {
        nextGear = isLotationRightGear(rightGear-1, rightGear)
        
        for _ in 0...2 {
            if nextGear {
                if rightDirection == 1 {
                    compareGears[rightGear].insert(compareGears[rightGear].last!, at: 0)
                    compareGears[rightGear].removeLast()
                    rightDirection = -1
                    
                } else {
                    compareGears[rightGear].append(compareGears[rightGear].first!)
                    compareGears[rightGear].removeFirst()
                    rightDirection = 1
                }
                nextGear = isLotationRightGear(rightGear, rightGear + 1)
                rightGear += 1
            } else {
                break
            }

        }
    }
    gears = compareGears
}


func isLotationLeftGear(_ baseGear: Int, _ leftGear: Int) -> Bool {
    guard leftGear >= 0 else { return false }
    
    return gears[baseGear][6] != gears[leftGear][2] ? true : false
}

func isLotationRightGear(_ baseGear: Int, _ rightGear: Int) -> Bool {
    guard rightGear < 4 else { return false }
    
    return gears[baseGear][2] != gears[rightGear][6] ? true : false
}

rotatedValue.forEach {
    lotationGear($0[0], $0[1])
}

func scoureCal() -> Int {
    var result = 0
    for (index,gear) in gears.enumerated() {
        if gear[0] == 0 {
            result += 0
        } else if index == 0 {
            result += 1
        } else if index == 1 {
            result += 2
        } else if index == 2 {
            result += 4
        } else if index == 3 {
            result += 8
        }
    }
    return result
}

print(scoureCal())
