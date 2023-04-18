//
//  main.swift
//  코딩테스트
//
//  Created by 전성훈 on 2023/04/13.
//

import Foundation


var num: [Int] = Array(repeating: 0, count: 10)

for n in (readLine()!)) {
    num[Int(String(n))!] += 1
}

num[6] = (num[6] + num.removeLast() + 1) / 2

print(num.max()!)
