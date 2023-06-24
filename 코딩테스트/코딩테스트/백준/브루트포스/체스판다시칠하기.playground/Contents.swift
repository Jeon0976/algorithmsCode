import Foundation

let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }
let row = testArray[0]
let col = testArray[1]

var chessBoard = [[String]]()

var answer = 64

for _ in 0..<testArray[0] {
    chessBoard.append(readLine()!.map { String($0)})
}

for i in 0...row-8 {
    for j in 0...col-8  {
        var cnt = 0

        for x in i..<i+8 {
            for y in j..<j+8 {
                print("X: ",x)
                if (x + y) % 2 == 0 {
                    if chessBoard[x][y] == "W" {
                        cnt += 1
                    }
                } else {
                    if chessBoard[x][y] == "B" {
                        cnt += 1
                    }
                }
            }
        }

        answer = min(answer, 64-cnt)
        answer = min(answer, cnt)
    }
}

print(answer)
