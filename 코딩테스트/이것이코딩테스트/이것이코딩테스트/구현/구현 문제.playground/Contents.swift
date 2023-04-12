import Foundation

// 7. 럭키 스트라이크
let line = "123402"
let array = line.map { Int(String($0))!}

func luckyStraight(_ array: [Int]) -> String {
    if array.count % 2 != 0 {
        return "READY"
    }
    
    let halfArray = array.count / 2
    var leftNum = 0
    var rightNum = 0
    
    
    for i in 0..<array.count {
        if i < halfArray {
            leftNum += array[i]
        } else {
            rightNum += array[i]
        }
    }
    
    if leftNum != rightNum {
        return "READY"
    }
    
    return "LUCKY"
}

luckyStraight(array)

// 8. 문자열 재정렬
func reSort(_ array: String) -> String {
    var numSum = array.filter { $0.isNumber }.map{ Int(String($0))! }.reduce(0, +)
    var stringArray = array.filter { !$0.isNumber }.sorted()
    
    return stringArray + String(numSum)
}

reSort("K1KA5CB7")

// 9. 문자열 압축
func solution9(_ s:String) -> Int {
    if s.count < 3 {
        return s.count
    }
    
    var answder = s.count

    for step in stride(from: 1, to: s.count / 2 + 1, by: 1) {
        var compressed = ""

        var stepIndex = s.index(s.startIndex, offsetBy: step)
        // 그냥 step으로 하면 에러남
        var prev = s[..<stepIndex]
        var count = 1

        for j in stride(from: step, to: s.count, by: step) {
            
            // 인덱스 초과 방지
            var vstep = step
            
            if (j + step) > s.count {
                vstep = s.count - j
            }
            
            var first = s.index(s.startIndex, offsetBy: j)
            var last = s.index(s.startIndex, offsetBy: j+vstep)
            
            if prev == s[first..<last] {
                count += 1
            } else {
                if count >= 2 {
                    compressed = "\(compressed)\(count)\(prev)"
                } else {
                    compressed = "\(compressed)\(prev)"
                }
                
                prev = s[first..<last]
                count = 1
            }
        }
        
        if count >= 2 {
            compressed = "\(compressed)\(count)\(prev)"
        } else {
            compressed = "\(compressed)\(prev)"
        }
        
        answder = min(answder,compressed.count)
//        print(compressed)
    }
    
    return answder
}

solution9("aabbcbbc")
// 10. 자물쇠와 열쇠
// 자물쇠 크기 조정 -> 최대 크기 20 x 20
// 3배로 늘림
func check(_ arr:[[Int]], _ N: Int) -> Bool {
    for x in 0..<N {
        for y in 0..<N {
            if arr[x + N][y + N] != 1 {
                return false
            }
        }
    }
    return true
}

func solution(_ key:[[Int]], _ lock:[[Int]]) -> Bool {
    let M = key.count
    let N = lock.count
    
    var key = key
    var new_lock = Array(repeating:[Int](repeating: 1, count: 3 * N),count: 3 * N)
    
    func spin_left(_ arr:[[Int]]) -> [[Int]] {
        var rotatedKey = [[Int]](repeating: [Int](repeating: 0, count: M), count: M)
        for col in 0..<M {
            for row in (0..<M).reversed() {
                rotatedKey[col][M - 1 - row] = key[row][col]
            }
        }
        
        return rotatedKey
    }
    
    // 기존 자물쇠를 새로운 자물쇠 가운데 위치
    for x in 0..<N {
        for y in 0..<N {
            new_lock[x+N][y+N] = lock[x][y]
        }
    }

    // 4가지 방향 확인
    for _ in 0..<4 {
        key = spin_left(key)
        // 3배 늘렸으니 깐
        for lock_x in 0..<N * 2 {
            for lock_y in 0..<N * 2 {
                for key_x in 0..<M {
                    for key_y in 0..<M {
                        new_lock[lock_x + key_x][lock_y + key_y] += key[key_x][key_y]
                    }
                }
                if check(new_lock, N) {
                    return true
                }
                
                // key를 new_lock에서 뺌
                for key_x in 0..<M {
                    for key_y in 0..<M {
                        new_lock[lock_x + key_x][lock_y + key_y] -= key[key_x][key_y]
                    }
                }
            }
        }
    }
    
    return false
}

solution([[0,0,0],[1,0,0],[0,1,1]], [[1, 1, 1], [1, 1, 0], [1, 0, 1]]    )
// 11. 뱀
// 12. 기둥과 보 설치
// 13. 치킨 배달
// 14. 외벽 점검
