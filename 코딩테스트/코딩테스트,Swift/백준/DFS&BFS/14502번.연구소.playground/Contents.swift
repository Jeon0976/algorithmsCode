import Foundation

struct Queue {
    private var leftArray = [[Int]]()
    private var rightArray = [[Int]]()
    
    var isEmpty: Bool {
        leftArray.isEmpty && rightArray.isEmpty
    }
    
    mutating func push(_ value: [Int]) {
        rightArray.append(value)
    }
    
    mutating func pop() -> [Int] {
        if leftArray.isEmpty {
            leftArray = rightArray.reversed()
            rightArray.removeAll()
        }
        
        return leftArray.popLast()!
    }
}


let testNM = readLine()!.components(separatedBy:" ").map { Int($0)! }

let N = testNM[0]
let M = testNM[1]

var map = [[Int]]()

var safeArea = [[Int]]()
var virusArea = [[Int]]()

for _ in 0..<N {
    let array = readLine()!.components(separatedBy: " ").map { Int($0)! }
    
    map.append(array)
}

for i in 0..<N {
    for j in 0..<M {
        if map[i][j] == 0 {
            safeArea.append([i,j])
        } else if map[i][j] == 2 {
            virusArea.append([i,j])
        }
    }
}

var result = 0

var dx: [Int] = [0,0,-1,1]
var dy: [Int] = [1,-1,0,0]

func makeWall() {
    for i in 0..<safeArea.count {
        for j in i+1..<safeArea.count {
            for k in j+1..<safeArea.count {
                var map = map
                
                let coordi1 = safeArea[i]
                let coordi2 = safeArea[j]
                let coordi3 = safeArea[k]
                map[coordi1[0]][coordi1[1]] = 1
                map[coordi2[0]][coordi2[1]] = 1
                map[coordi3[0]][coordi3[1]] = 1
                
                bfs(map)
            }
        }
    }
}

func bfs(_ map: [[Int]]) {
    var map = map
    
    var queue = Queue()
    
    for area in virusArea {
        queue.push(area)
    }
    
    while !queue.isEmpty {
        let now = queue.pop()
        
        for i in 0..<dx.count {
            let nextX = now[1] + dx[i]
            let nextY = now[0] + dy[i]
            
            if nextX < 0 || nextX > M-1 || nextY < 0 || nextY > N-1 {
                continue
            } else {
                if map[nextY][nextX] == 0 {
                    map[nextY][nextX] = 2
                    queue.push([nextY,nextX])
                }
            }
        }
    }
    
    var temp = 0
    
    for i in 0..<N {
        for j in 0..<M {
            if map[i][j] == 0 {
                temp += 1
            }
        }
    }
    
    if result < temp {
        result = temp
    }
    
}

makeWall()
print(result)
