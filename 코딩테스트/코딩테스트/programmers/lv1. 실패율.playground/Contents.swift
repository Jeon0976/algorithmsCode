import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var Narray = [Int:Double]()
    var countArr = Array(repeating: 0, count: N + 2)
        
    for num in stages {
        countArr[num] += 1
    }
    
    
    // 0 키 값, 1 실패율
    
    var count = Double(stages.count)
    
    for i in 1..<N + 1 {
        if countArr[i] == 0 {
            Narray[i] = 0.0
        } else {
            Narray[i] = Double(countArr[i]) / count
            count = count - Double(countArr[i])

            print(count)
        }
    }
        
    let sortArr = Narray.sorted(by: <).sorted(by: { $0.1 > $1.1 })
    
    let result = sortArr.map { $0.key }
    

    return result
}

solution(5, [2, 1, 2, 6, 2, 4, 3, 3]    )



func solution2(_ N:Int, _ stages:[Int]) -> [Int] {
    var failureDic:[Int:Double] = [:]
    
    // stage count 변수
    var accumulateCount: Double = 0.0
    // stage same level 변수
    var sameCount: Double = 0.0
    
    
    for i in 1...N {
        for stage in stages {
            if stage >= i {
                accumulateCount += 1
            }
            if i == stage {
                sameCount += 1
            }
        }
        failureDic[i] = sameCount/accumulateCount
        accumulateCount = 0
        sameCount = 0
    }
    // 값이 가장 큰 순서대로 먼저 정렬 후, 그 다음 key값의 오름차순으로 정렬
    let sortedFailure = failureDic.sorted(by: <).sorted(by: {$0.1 > $1.1})
    
    let result = sortedFailure.map { $0.key }
    
    return result
}
solution2(5, [2, 1, 2, 6, 2, 4, 3, 3]    )
