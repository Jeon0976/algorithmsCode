//
//  main.swift
//  21-30
//
//  Created by 전성훈 on 2023/03/23.
//

import Foundation

let n = readLine()!.components(separatedBy: [" "]).map { Int($0)! }.map { int in
    for i in 1...int {
        for _ in 1...i {
            print("*", terminator: "")
        }
        print("")
    }
}

//let d = readLine()!
//print(d)
let re = readLine()!.split(separator: "1")
print(re)
print(type(of: re))
let rr = readLine()!.components(separatedBy: "1")
print(rr)

let test = readLine()!.components(separatedBy: " ").map {
    Int($0)!
}

print(test)
print(type(of: test))

let n2 = readLine()!.components(separatedBy: [" "]).map { Int($0)! }

(1...n2[0]).forEach {
    print((1...$0).map { _ in "*" }.joined())
}
