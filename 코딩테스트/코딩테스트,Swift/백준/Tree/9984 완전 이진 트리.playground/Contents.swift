import Foundation

let height = Int(readLine()!)!

var list = readLine()!.split(separator: " ").map { Int(String($0))! }

var answer = Array(repeating: [Int](), count: height)

// 완전 이진트리 형식임
// 완전 이진 트리는 중앙 값이 최대 높이
// 완전 이진 트리 형식으로 값이 들어왔으니 해당 Tree 구조를 만들어서 대입하기만 하면 될것같은데

// 절반씩 나누어서, 왼쪽과 오른쪽에 절반씩 나눈값은 부모 노드가 된다.

func check(left: Int,right: Int, level: Int) {
    if left >= right { return }
    let mid = (left + right) / 2
    
    answer[level].append(list[mid])
    
    check(left: left, right: mid - 1, level: level + 1)
    check(left: mid + 1, right: right, level: level + 1)
}

check(left: 0, right: list.count - 1, level: 0)

answer.forEach {
    $0.forEach {
        print($0, terminator: " ")
    }
    print()
}
