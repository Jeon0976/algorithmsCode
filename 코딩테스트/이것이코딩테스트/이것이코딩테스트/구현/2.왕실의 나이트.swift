//
//  main.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/03/30.
//

// 2. 왕실의 나이트
//import Foundation
//
//var line = Array(readLine()!)
//
//var xString = String(line.removeFirst())
//
//var x = 0
//var y = Int(String(line.removeFirst()))!
//
//
//for _ in 1...8 {
//    if xString == "a" {
//        x = 1
//    }
//    else if xString == "b" {
//        x = 2
//    }
//    else if xString == "c" {
//        x = 3
//    }
//    else if xString == "d" {
//        x = 4
//    }
//    else if xString == "e" {
//        x = 5
//    }
//    else if xString == "f" {
//        x = 6
//    }
//    else if xString == "g" {
//        x = 7
//    } else {
//        x = 8
//    }
//}
//
//
//var count = 0
//let horse = [
//    [-2,-1],
//    [-2,1],
//    [-1,-2],
//    [1,-2],
//    [2,-1],
//    [2,1],
//    [1,2],
//    [-1,2]
//]
//
//var newX = 0
//var newY = 0
//print(x,y)
//for horseMove in horse {
//    newX = x + horseMove[0]
//    newY = y + horseMove[1]
//    print("CC: \(newX) \(newY)")
//    if newX >= 1 && newX <= 8 && newY >= 1 && newY <= 8 {
//        count += 1
//    }
//    newX = x
//    newY = y
//}
//
//print(count)
