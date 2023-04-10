import Foundation

let n = 5
var nArray = [8, 3, 7, 9, 2]
nArray = nArray.sorted()

let m = 3
let mArray = [5,7,9]

var checkArray: [String] = []

// 이진탐색
func binary_search(_ array:[Int], _ target:Int, _ start:Int, _ end:Int) -> Int? {
    if start > end {
        return nil
    }
    
    let mid = (start + end) / 2
    
    if array[mid] == target {
        return mid
    } else if array[mid] > target {
        return binary_search(array, target, start, mid - 1)
    } else {
        return binary_search(array, target, mid + 1, end)
    }
}

binary_search([1,5,15,17,19,22,24,31,105,150], 31, 0, 9)

for mElement in mArray {
    let result = binary_search(nArray, mElement, 0, nArray.count-1) ?? -1
    if result == -1 {
        checkArray.append("no")
    } else {
        checkArray.append("yes")
    }
}

print(checkArray)


func fibo(_ x:Int) -> Int {
    if x == 1 || x == 2 {
        return 1
    }
    return fibo(x-1) + fibo(x - 2)
}

// 반복문 활용
// bottom up 방식
func fiboMemoizationLoop(_ x:Int) -> Int {
    var cache: [Int] = [0,1]
    print("f(" ,1 ,")", terminator: " ")

    for num in 2...x {
        print("f(" ,num ,")", terminator: " ")
        cache.append(cache[num - 1] + cache[num - 2])
    }
    return cache[x]
}
var cache = [Int](repeating: 0, count: 100)


// 재귀함수 활용
// top down 방식
func fiboMemoizationRecursion(_ x:Int) -> Int {
    if x == 1 {
        print("f(" ,2 ,")", terminator: " ")
        print("f(" ,1 ,")", terminator: " ")
        return 1
    }
    
    if x == 2 {
        return 1
    }

    if cache[x] != 0 {
        return cache[x]
    }
    print("f(" ,x ,")", terminator: " ")


    cache[x] = fiboMemoizationRecursion(x-1) + fiboMemoizationRecursion(x-2)
    return cache[x]
}
fiboMemoizationLoop(10)
print()
fiboMemoizationRecursion(10)
print()


//func makeOne(_ x:Int) -> Int {
//    var x = x
//    
//    while x != 1 {
//        if x % 5 == 0 {
//            x /= 5
//            count += 1
//            continue
//        } else if x % 3 == 0 {
//            x /= 3
//            count += 1
//            continue
//        } else if x % 2 == 0 {
//            x /= 2
//            count += 1
//            continue
//        } else {
//            x -= 1
//            count += 1
//            continue
//        }
//    }
//    
//    return count
//}
//
//makeOne(26)

var ss = [[1,2],[2,3],[4,5]]
var s = [(1,2),(2,3),(1,2)]
s[0].1



//
//func solve(_ n: Int) -> Int {
//    if n < 0 {
//        return 0
//    }
//
//    if n == 0  {
//        return 1
//    }
//
//    return solve(n - 1) + solve(n - 3) + solve(n - 5)
//}

var dp = [Int](repeating: 0, count: 100)
func solve(_ n: Int) -> Int {
    if n < 0 {
        return 0
    }
    if n == 0 {
        return 1
    }
    if dp[n] != 0 {
        return dp[n]
    } else { dp[n] = solve(n - 1) + solve(n - 3) + solve(n - 5) }
    return dp[n]
}

//solve(40)
solve(40)


func fibo2(_ x: Int) -> Int {
    var dp = [Int](repeating: 0, count: x+1)
    if x == 0 {
        return 0
    } else if x == 1 {
        return 1
    }
    dp[1] = 1
    for i in 2...x {
        dp[i] = dp[i-1] + dp[i-2]
    }
    return dp[x]
}

fibo2(5)
fibo(5)
