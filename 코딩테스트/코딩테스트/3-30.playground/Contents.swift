import Foundation

// 프로그래밍 면접 이렇게 준비한다. 221P 단어 뒤집기
// 나의 풀이 방법
func flip(_ strings: String) -> String {
    var beforeFlip = String(strings.reversed())
    var bufferFlip:String = ""
    var afterFlip:String = ""
    
    
    
    for flip in beforeFlip {
        bufferFlip.append(flip)
        if flip == " " {
            afterFlip.append(String(bufferFlip.reversed()))
            afterFlip.append(" ")
            
            bufferFlip = ""
        }
    }
    afterFlip.append(String(bufferFlip.reversed()))

    return afterFlip
}

print(flip("Do or do not, there is no try."))


// 가로 세로 중 가장 긴 숫자를 중심으로 두고
// 그 다음 반대편 큰 숫자의 반대편이 작을때 교환하고
// 그 다음 가장 큰 숫자끼리 곱하고 리턴
func solution1(_ sizes:[[Int]]) -> Int {
    var maxNum = 0
    var minNum = 0

    for size in sizes {
        print(size)
        maxNum = max(maxNum, size.max()!)
        minNum = max(minNum, size.min()!)
    }
    return maxNum * minNum
}
solution1([[60, 50], [30, 70], [60, 30], [80, 40]]    )


// 수포자 모의고사
// 1번 1,2,3,4,5
// 2번 2,1,2,3,2,4,2,5
// 3번 3,3,1,1,2,2,4,4,5,5
// 정답을 많이 맞춘사람 배열로 반환
// 높은 점수 다 같으면 오름차순으로 반환
func takingMockTest(_ answers:[Int]) -> [Int] {
    var mans:[Int] = []
    
    var man1:[Int] = [1,2,3,4,5]
    var man2:[Int] = [2,1,2,3,2,4,2,5]
    var man3:[Int] = [3,3,1,1,2,2,4,4,5,5]
    
    var man1Collect = 0
    var man2Collect = 0
    var man3Collect = 0
    
    for i in 0...answers.count-1 {
        if answers[i] == man1[i%man1.count] {
            man1Collect += 1
        }
        if answers[i] == man2[i%man2.count] {
            man2Collect += 1
        }
        if answers[i] == man3[i%man3.count] {
            man3Collect += 1
        }
    }
    
    mans.append(man1Collect)
    mans.append(man2Collect)
    mans.append(man3Collect)
    
    let mansMax = mans.max()!
    
    let mansCount = mans.count - 1
    var orderMans:[Int] = []
    
    for i in 0...mansCount {
        if mans[i] == mans.max()! {
            orderMans.append(i+1)
        }
    }
    
    return orderMans
}

func takingMockTestH(_ answers:[Int]) -> [Int] {
    let answer = (
        a: [1, 2, 3, 4, 5], // index % 5
        b: [2, 1, 2, 3, 2, 4, 2, 5], // index % 8
        c: [3, 3, 1, 1, 2, 2, 4, 4, 5, 5] // index % 10
    )
    var point = [1:0, 2:0, 3:0]
    
    for (i, v) in answers.enumerated() {
        if v == answer.a[i % 5] { point[1] = point[1]! + 1 }
        if v == answer.b[i % 8] { point[2] = point[2]! + 1 }
        if v == answer.c[i % 10] { point[3] = point[3]! + 1 }
    }

    return point.sorted{ $0.key < $1.key }.filter{ $0.value == point.values.max() }.map{ $0.key }
}
takingMockTest([3,3,2,3]    )
0%5
1%5
2%5
3%5
4%5
5%5
6%5
7%5
