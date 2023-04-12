//
//  main.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/04/12.
//

import Foundation
let line = readLine()!
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
