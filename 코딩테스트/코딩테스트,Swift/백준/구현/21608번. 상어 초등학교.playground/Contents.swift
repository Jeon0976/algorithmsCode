import Foundation

// 조건
// 1. 비어있는 칸 중에서 좋아하는 학생이 인접한 칸에 가장 많은 칸으로 자리를 정한다.
// 2. 1을 만족하는 칸이 여러 개이면, 인접한 칸 중에서 비어있는 칸이 가장 많은 칸으로 자리를 정한다.
// 3. 2를 만족하는 칸도 여러 개인 경우에는 행의 번호가 가장 작은 칸으로, 그러한 칸도 여러 개이면 열의 번호가 가장 작은 칸으로 자리를 정한다.

let n = Int(readLine()!)!

var loveArray = Array(repeating: [Int](), count: n*n)
var order: [Int] = []

var answer = Array(repeating: [Int](repeating: -1, count: n), count: n)

let dx = [-1,1,0,0]
let dy = [0,0,-1,1]

let score = [0,1,10,100,1000]

var resultCount = 0

for _ in 0..<n*n {
    let tempArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
    order.append(tempArray[0]-1)

    for i in 1...4 {
        loveArray[tempArray[0]-1].append(tempArray[i]-1)
    }
}

func checkPosition(x: Int, y: Int, love: [Int]) -> (Int, Int) {
    var loveCount = 0
    var empty = 0
    
    for i in 0..<4 {
        let nx = x + dx[i]
        let ny = y + dy[i]
        
        if nx < 0 || nx >= n  || ny < 0 || ny >= n { continue }
        
        if love.contains(answer[nx][ny]) { loveCount += 1 }
        
        if answer[nx][ny] == -1 { empty += 1 }
    }
    
    return (loveCount, empty)
}

for value in order {
    var maxLove = -1
    var maxEmpty = -1
    var x = 0
    var y = 0
    
    for i in 0..<n {
        for j in 0..<n {
            if answer[i][j] == -1 {
                let result = checkPosition(x: i, y: j, love: loveArray[value])
                
                if maxLove < result.0 {
                    maxLove = result.0
                    maxEmpty = result.1
                    x = i
                    y = j
                } else if maxLove == result.0 && maxEmpty < result.1 {
                    maxLove = result.0
                    maxEmpty = result.1
                    x = i
                    y = j
                }
            }
        }
    }
    
    answer[x][y] = value
}


for i in 0..<n {
    for j in 0..<n {
        let result = checkPosition(x: i, y: j, love: loveArray[answer[i][j]])
        resultCount += score[result.0]
    }
}

print(resultCount)
