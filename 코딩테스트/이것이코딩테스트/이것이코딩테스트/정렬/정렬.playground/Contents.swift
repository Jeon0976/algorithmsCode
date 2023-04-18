import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var Narray = [(Int,Double)]()
    for i in 1...N {
        Narray.append((i,Double(i)))
    }
    
    
    // 0 키 값, 1 실패율
    
    var count = Double(stages.count)
    var eachNum:Double = 0

    for i in 0...Narray.count - 1 {
        for value in stages {
            if value == Narray[i].0 {
                eachNum += 1
            }
        }
        Narray[i].1 = eachNum / count
        count -= eachNum
        eachNum = 0
    }
    
    
   let result = Narray.sorted {
        if $0.1 == $1.1 {
           return $0.0 < $1.0
        } else {
            return $0.1 > $1.1
        }
    }.map { $0.0}

    return result
}

func solutionH(_ N:Int, _ stages:[Int]) -> [Int] {
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
            count = count - Double(countArr[i])
            Narray[i] = Double(countArr[i]) / count
        }
    }
    
    let sortArr = Narray.sorted(by: <).sorted(by: { $0.1 > $1.1 })
    
    let result = sortArr.map { $0.key }
    

    return result
}
solutionH(5, [2, 1, 2, 6, 2, 4, 3, 3]        )
