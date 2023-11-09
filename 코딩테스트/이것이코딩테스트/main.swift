import Foundation

let n = Int(readLine()!)!

var array = Array(repeating: [Int](repeating: 0, count: n), count: n)

for i in 0..<n {
    let tempArray = readLine()!.split(separator: " ").map { Int($0)! }
    
    array[i] = tempArray
}

var result = Int.max

var start = Int.max
var link = Int.max


for i in 0..<n {
    for j in 0..<n {
        for k in 0..<n {
            for h in 0..<n {
                if i == j || k == h { continue }
                
                if i == k || j == h || i == h || j == k { continue }
                
                if i >= j || k >= h { continue }
                
                start = array[i][j] + array[j][i]
                
                link = array[k][h] + array[h][k]
                
                print(i, j, k, h, start, link)
            }
        }
    }
    
    result = min(result, abs(start - link))
}

print(result)
