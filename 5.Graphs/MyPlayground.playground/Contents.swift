import UIKit
func solution(_ height: [Int], _ width: [Int]) -> Int {
    var maxArea = 0
    
    for i in 0..<height.count {
        var minHeight = height[i]
        var maxWidth = 0
        
        for j in i..<height.count {
            minHeight = min(minHeight, height[j])
            maxWidth += width[j]
            maxArea = max(maxArea, minHeight * maxWidth)
        }
    }
    
    return maxArea
}


func solution3(_ rectangles: [[Int]]) -> [String] {
    var result = [String]()

    for rectangle in rectangles {
        var x1 = rectangle[0]
        var y1 = rectangle[1]
        var x2 = rectangle[2]
        var y2 = rectangle[3]

        // 직사각형을 아래로 이동
        while y1 > 0 {
            var canMoveDown = true
            for other in rectangles {
                if rectangle == other { continue }
                if other[2] > x1 && other[0] < x2 && other[3] <= y1 && other[1] >= y1 - 1 {
                    canMoveDown = false
                    break
                }
            }
            if canMoveDown {
                y1 -= 1
                y2 -= 1
            } else {
                break
            }
        }

        // 직사각형을 왼쪽으로 이동
        while x1 > 0 {
            var canMoveLeft = true
            for other in rectangles {
                if rectangle == other { continue }
                if other[3] > y1 && other[1] < y2 && other[2] <= x1 && other[0] >= x1 - 1 {
                    canMoveLeft = false
                    break
                }
            }
            if canMoveLeft {
                x1 -= 1
                x2 -= 1
            } else {
                break
            }
        }

        result.append("\(x1) \(y1) \(x2) \(y2)")
    }

    return result
}
func solution4(_ rectangles: [[Int]]) -> [String] {
    var result = [String]()
    var closeToX = rectangles.sorted { $0[1] < $1[1] }
    
    for i in 0..<closeToX.count {
        var newY = 0
        for compareRec in rectangles {
            if closeToX[i] == compareRec { continue }
            // 다른 직사각형과 겹치는 경우 확인
            if closeToX[i][0] < compareRec[2] && closeToX[i][2] > compareRec[0] && closeToX[i][1] > compareRec[1] {
                newY = max(newY, compareRec[3])
            }
        }
        closeToX[i][1] = newY
        closeToX[i][3] = newY + (closeToX[i][3] - closeToX[i][1])
        result.append("\(closeToX[i][0]) \(closeToX[i][1]) \(closeToX[i][2]) \(closeToX[i][3])")
    }
    
    return result
}

func soultion5(_ rectangles: [[Int]]) {
    var updatedRectangles = [[Int]]()

    for rectangle in rectangles {
        var updatedRectangle = rectangle
        while true {
            let (x1, y1, x2, y2) = (updatedRectangle[0], updatedRectangle[1], updatedRectangle[2], updatedRectangle[3])
            var canMoveDown = true
            for otherRectangle in rectangles {
                if otherRectangle != updatedRectangle && otherRectangle[0] <= x2 && otherRectangle[2] >= x1 && otherRectangle[1] < y2 && otherRectangle[1] >= y1 {
                    canMoveDown = false
                    break
                }
            }
            if canMoveDown {
                updatedRectangle[1] -= 1
                updatedRectangle[3] -= 1
            } else {
                break
            }
        }
        updatedRectangles.append(updatedRectangle)
    }

    print(updatedRectangles)


}


func solution2(_ rectangles: [[Int]]) {
    var result = [String]()
    var rectangles = rectangles
    
    var dicRectangles: [Int:[Int]] = [:]
    
    for i in 0..<rectangles.count {
        dicRectangles[i] = rectangles[i]
    }
    
    var xSorted = dicRectangles.sorted { $0.value[1] < $1.value[1]}
    
    var checkX = [[Int]]()
    for i in 0..<xSorted.count {
        xSorted[i].value[3] -= xSorted[i].value[1]
        xSorted[i].value[1] = 0
        
        checkX.append(xSorted[i].value)

        for checkValue in checkX {
            if xSorted[i].value[0] >= checkValue[0] && xSorted[i].value[0] <= checkValue[3] && checkValue != xSorted[i].value {
                xSorted[i].value[3] = xSorted[i].value[3] - xSorted[i].value[1] + checkValue[3]
                xSorted[i].value[1] = checkValue[3]
                }
            }

        }
        
    print(xSorted)
    
//    var closeToX = rectangles.sorted { $0[1] < $1[1] }
//
//    for i in 0..<rectangles.count {
//        closeToX[i][3] -= closeToX[i][1]
//        closeToX[i][1] = 0
//    }
//
//    for i in 0..<rectangles.count {
//        for rec in closeToX {
//            if rectangles[i][0] > rec[0] && rectangles[i][0] < rec[2] && rec != rectangles[i]  {
//                rectangles[i][3] = rectangles[i][3] - rectangles[i][1] + rec[3]
//                rectangles[i][1] = rec[3]
//                break
//            } else {
//                rectangles[i][3] -= rectangles[i][1]
//                rectangles[i][1] = 0
//                break
//            }
//        }
//    }

    
//    for i in 0..<rectangles.count {
//        for rec in comapreRecs {
//            if rectangles[i][0] > rec[0] && rectangles[i][0] < rec[2]  {
//                rectangles[i][1] = rec[3]
//                rectangles[i][3] += rectangles[i][1]
//            }
//        }
//    }
//
//    print(comapreRecs)
}


func solution44(_ rectangles: [[Int]]) -> [String] {
    var result = [String]()
    var rectangles = rectangles
    
    // rectangles를 dicRectangles로 변경
    var dicRectangles: [Int:[Int]] = [:]
    for i in 0..<rectangles.count {
        dicRectangles[i] = rectangles[i]
    }
    
    // y좌표를 기준으로 정렬
    var ySorted = dicRectangles.sorted { $0.value[1] < $1.value[1] }
    
    for i in 0..<ySorted.count {
        let current = ySorted[i].value
        var xStart = current[0]
        var yStart = current[1]
        var xEnd = current[2]
        var yEnd = current[3]
        
        // y 방향으로 이동
        while true {
            var isMoved = false
            for j in 0..<ySorted.count {
                if i == j { continue }
                let other = ySorted[j].value
                if other[2] <= xStart || other[0] >= xEnd { continue }
                if other[1] > yEnd { continue }
                isMoved = true
                yEnd = max(yEnd, other[3])
            }
            if !isMoved { break }
        }
        
        // x 방향으로 이동
        while true {
            var isMoved = false
            for j in 0..<ySorted.count {
                if i == j { continue }
                let other = ySorted[j].value
                if other[3] <= yStart || other[1] >= yEnd { continue }
                if other[0] > xEnd { continue }
                isMoved = true
                xEnd = max(xEnd, other[2])
            }
            if !isMoved { break }
        }
        
        // 결과 배열에 추가
        result.append("\(xStart) \(yStart) \(xEnd) \(yEnd)")
        
        // 이동한 직사각형 정보를 rectangles와 dicRectangles에서 삭제
        rectangles.remove(at: ySorted[i].key)
        dicRectangles.removeValue(forKey: ySorted[i].key)
        ySorted = dicRectangles.sorted { $0.value[1] < $1.value[1] }
    }
    
    return result
}

let rectangles = [[0, 2, 1, 3], [1, 2, 2, 5], [3, 3, 4, 4], [4, 1, 6, 3],[1, 6, 5, 7], [5, 5, 7, 6], [5, 8, 6, 10]]

solution2(rectangles)




let result3 = solution44(rectangles)
print(result3) // 출력: ["0 0 1 1", "1 0 2 3", "2 0 3 1", "3 0 5 2", "0 3 4 4", "2 2 4 3", "4 3 5 5"]
