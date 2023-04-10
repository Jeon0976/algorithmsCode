//
//  main.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/03/30.
//

// 구현 예제
// 구현 유형은 크게 2가지로 나눌 수 있다.
// 1. 완전 탐색 - 모든 경우의 수를 주저 없이 다 계산하는 해결 방법
// 2. 시뮬레이션 - 문제에서 제시한 알고리즘을 한 단계씩 차례대로 직접 수행하는 방법
// 보통 구현 유형의 문제는 사소한 입력 조건 등을 문제에서 명시해주며 문제의 길이가 꽤 긴 편이다.
// 문제의 길이를 보고 지레 겁먹는데, 고차원적인 사고력을 요구하는 문제는 나오지 않는 편이라 문법에 익숙하다면 오히려 쉽게 풀 수 있다.
//import Foundation
//
//// 예제 1 상하좌우
//// 무시 -> continune 사용
//// 책에서는 배열로 만들어서 풀었음
//let line1 = readLine()
//let line2 = readLine()
//
//var maxLand = 0
//var move:[String] = []
//
//var x = 1
//var y = 1
//
//if let line1 = line1 {
//    maxLand = Int(line1)!
//}
//
//if let line2 = line2 {
//    move = line2.components(separatedBy: " ")
//}
//
//for moveMen in move {
//    if moveMen == "R" {
//        if y < maxLand {
//            y += 1
//        }
//    }
//    else if moveMen == "L" {
//        if y > 1 {
//            y -= 1
//        }
//    }
//    
//    else if moveMen == "U" {
//        if x > 1 {
//            x -= 1
//        }
//    }
//    
//    else if moveMen == "D" {
//        if x < maxLand {
//            x += 1
//        }
//    }
//}
//
//print(x,y)
//
