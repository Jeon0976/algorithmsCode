import Foundation

struct Queue {
    var leftArray = [(Int, Int)]()
    var rightArray = [(Int, Int)]()

    var peek: (Int,Int) {
        return leftArray.isEmpty ? rightArray.first! : leftArray.last!
    }

    var isEmpty: Bool {
        return leftArray.isEmpty && rightArray.isEmpty
    }

    mutating func push(_ value: (Int,Int)) {
        rightArray.append(value)
    }

    mutating func pop() -> (Int,Int){
        if leftArray.isEmpty {
            leftArray = rightArray.reversed()
            rightArray.removeAll()
        }

        return leftArray.removeLast()
    }
}

let testCase = readLine()!.components(separatedBy:" ").map { Int($0)! }

let N = testCase[0]
let L = testCase[1]
let R = testCase[2]

var graph = [[Int]]()
var isOpenPossible = true
var result = 0

var visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)

let dx = [0,0,-1,1]
let dy = [1,-1,0,0]

for _ in 0..<N {
    let testArray = readLine()!.components(separatedBy: " ").map { Int($0)! }

    graph.append(testArray)
}

while isOpenPossible {
    isOpenPossible = false
    visited = [[Bool]](repeating: [Bool](repeating: false, count: N), count: N)
    
    for i in 0..<N {
        for j in 0..<N {
            if !visited[i][j] {
                if bfs(j,i) {
                    isOpenPossible = true
                }
            }
        }
    }
    
    if !isOpenPossible {
        break
    }

    result += 1
}

func bfs(_ x: Int, _ y: Int) -> Bool {
    visited[y][x] = true

    var queue = Queue()
    queue.push((x,y))

    var unionPossible = false
    
    var unionArray = [(x,y)]
    var sumPopulation = graph[y][x]
    
    while !queue.isEmpty {
        let value = queue.pop()
        let x = value.0
        let y = value.1
        
        for i in 0..<4 {
            let nx = x + dx[i]
            let ny = y + dy[i]
            
            if isOverGraph(nx, ny) {
               continue
            }
            
            if visited[ny][nx] {
                continue
            }
            
            if checkUnion(x, y, nx, ny) {
                unionArray.append((nx,ny))
                visited[ny][nx] = true
                sumPopulation += graph[ny][nx]
                queue.push((nx,ny))
                unionPossible = true
            }
        }
    }
    
    let resultPopulaiton = sumPopulation / unionArray.count
    
    for array in unionArray {
        graph[array.1][array.0] = resultPopulaiton
    }
    print(graph)
    return unionPossible
}

func isOverGraph(_ x: Int, _ y: Int) -> Bool {
    if x < 0 || x >= N || y < 0 || y >= N {
        return true
    } else { return false}
}

func checkUnion(_ x: Int, _ y: Int, _ nx: Int, _ ny: Int) -> Bool {
    if L <= abs(graph[ny][nx] - graph[y][x]) && abs(graph[ny][nx] - graph[y][x]) <= R {
        return true
    } else { return false }
}

print(result)
// 최초 연합국가가 칸을 나눠서 생길 수 있다는 것을 확인못함
////var isOpenPassble = true
////var isCal = [[Int]]()
////var isCheck = [Bool](repeating: false, count: N*N)
////var result = 0
////var temparyNum = 0
////var temparyArray = [Int](repeating: 0, count: N*N)
////var nextTemp = false
////
////while isOpenPassble {
////    // 초기화 작업
////    isOpenPassble = false
////    isCheck = [Bool](repeating: false, count: N*N)
////    isCal = [[Int]]()
////    result += 1
////
////    for i in 0..<N {
////        for j in 0..<N {
////            let index = i * N + j
////            temparyNum = graph[i][j]
////            isCheck[index] = true
////            bfs(i,j)
////            isCheck[index] = false
////            if !nextTemp {
////                isCal.append(temparyArray)
////                temparyArray = [Int](repeating: 0, count: N*N)
////            }
////        }
////    }
////    isCal.append(temparyArray)
////
////    if isCal.count == 1 {
////        break
////    }
////    print(isCal)
////    var firstArray = isCal.first!
////    var filterFirstArray = isCal[0].filter { $0 != 0 }
////
////    for i in 0..<N {
////
////        let filiterArray = isCal[i].filter { $0 != 0 }
////
////        for j in 0..<N {
////            if isCal[i][j] == firstArray[j] && filiterArray.count > filterFirstArray.count {
////                if !filiterArray.isEmpty {
////                    firstArray = isCal[i]
////                    filterFirstArray = filiterArray
////                    let totalNum = filiterArray.reduce(0, +) / filiterArray.count
////                    for j in 0..<N * N {
////                        if isCal[i][j] != 0 {
////                            let row = i / N
////                            let col = i % N
////                            graph[row][col] = totalNum
////                            print("Test",graph)
////                        }
////                    }
////                } else {
////                    continue
////                }
////            }
////        }
////    }
////
////}
////
////func bfs (_ y: Int, _ x: Int) {
////    if x <= -1 || x >= N || y <= -1 || y >= N {
////        return
////    }
////
////    let index = y * N + x
////
////    if isCheck[index] {
////        bfs(y-1, x)
////        bfs(y, x-1)
////        bfs(y+1, x)
////        bfs(y, x+1)
////    }
////
////    if temparyNum != graph[y][x] {
////        let diff = abs(temparyNum - graph[y][x])
////        if L <= diff && R >= diff {
////            temparyArray[index] = graph[y][x]
//////            isCal[count][index] = graph[y][x]
////            isOpenPassble = true
////            nextTemp = true
////        } else {
////            nextTemp = false
////        }
////    }
////}
////
////
////print(result)
