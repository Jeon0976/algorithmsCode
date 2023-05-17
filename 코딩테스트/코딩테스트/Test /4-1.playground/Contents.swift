import Foundation

func solution(_ sizes:[[Int]]) -> Int {
    var maxNum = 0
    var minNum = 0

    for size in sizes {
        print(size)
        maxNum = max(maxNum, size.max()!)
        minNum = max(minNum, size.min()!)
    }
    return maxNum * minNum
}
solution([[60, 50], [30, 70], [60, 30], [80, 40]]    )
0%5
1%5
2%5
3%5
4%5
5%5
