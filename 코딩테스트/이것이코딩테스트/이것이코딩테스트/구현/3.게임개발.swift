////
////  main.swift
////  이것이코딩테스트
////
////  Created by 전성훈 on 2023/04/01.
////
//
//import Foundation
//
//
//let line1 = readLine()
//let line2 = readLine()
//
//var mapSize:[Int] = []
//var map:[[Int]] = []
//
//var firstLocation:[Int] = []
//
//// look -> 0북,1동,2남,3서
//var firstLook: Int = 0
//
//
//if let line1 = line1 {
//    mapSize = line1.components(separatedBy: " ").map { Int($0)! }
//}
//
//print(mapSize)
//
//if let line2 = line2 {
//    var array = line2.components(separatedBy: " ").map { Int($0)!}
//    firstLocation = Array(array.prefix(2))
//    firstLook = array.popLast()!
//}
//
//print(firstLocation)
//print(firstLook)
//
//for _ in 1...mapSize[0] {
//    let line = readLine()!.components(separatedBy: " ").map { Int($0)!}
//    map.append(line)
//}
//
//print(map)
//
//var count = 1
//
//// 0 북
//// 1 동
//// 2 남
//// 3 서
//let move = [[-1,0],
//            [0,1],
//            [1,0],
//            [0,-1]]
//
//var nowLocation = firstLocation
//
//var isOcean: Bool = false
//
//var fourDirection = 0
//
//
//func direction(_ value: Int) -> Int {
//    var value = value
//    value -= 1
//    if value == -1 {
//        value = 3
//    }
//
//    return value
//}
//
//while isOcean == false {
//    firstLook = direction(firstLook)
//    nowLocation =  [move[firstLook][0] + firstLocation[0], move[firstLook][1] + firstLocation[1]]
//
//    if map[nowLocation[0]][nowLocation[1]] == 0 {
//        map[firstLocation[0]][firstLocation[1]] = 2
//        firstLocation = nowLocation
//        count += 1
//        fourDirection = 0
//    } else {
//        fourDirection += 1
//    }
//
//    if fourDirection == 4 {
//        if firstLook - 2 < 0 {
//            nowLocation = [move[firstLook+2][0] + firstLocation[0], move[firstLook+2][1] + firstLocation[1]]
//        } else {
//            nowLocation = [move[firstLook-2][0] + firstLocation[0], move[firstLook-2][1] + firstLocation[1]]
//        }
//
//        map[firstLocation[0]][firstLocation[1]] = 2
//        firstLocation = nowLocation
//
//        if map[firstLocation[0]][firstLocation[1]] == 1 {
//            isOcean = true
//        }
//        fourDirection = 0
//    }
//}
//
//print(count)
//print(map)
