//
//  main.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/05/10.
//

import Foundation

let line = Int(readLine()!)!

var numArray = [[String]]()
var dict = [String:Int]()

var sum = 0

for _ in 0...line - 1 {
    let line2 = Array(readLine()!).map { String($0)}

    numArray.append(line2)
}


for i in 0..<line{
    for j in 0..<numArray[i].count{
        dict[numArray[i][j]] = 0
    }
}


// 자릿수 더하기
for i in 0..<line{
    for j in 0..<numArray[i].count{
        dict[numArray[i][j]]! += Int(pow(10, Double(numArray[i].count - j - 1)))
    }
}


// 9 부터 거꾸로
var j = 9
for i in dict.sorted(by: {$0.value > $1.value}){
    sum += i.value * j
    j = j - 1
}

let answer = dict.sorted(by: >).enumerated()
    .map { (index, value) in
        return value.value * Int(9 - index)
    }
    .reduce(0, +)

print(sum)
print(answer)
