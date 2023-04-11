//
//  main.swift
//  이것이코딩테스트
//
//  Created by 전성훈 on 2023/04/05.
//
/// 우선순위 큐를 활용한 다익스트라 알고리즘


import Foundation


struct Heap {
    var elements = [(Int,Int)]()
    
    let sort: (Int,Int) -> Bool
    
    init(elements: [(Int,Int)] = [(Int,Int)](), sort: @escaping (Int, Int) -> Bool) {
        self.elements = elements
        self.sort = sort
        
        if !elements.isEmpty {
            for i in stride(from: count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    func peek() -> (Int,Int)? {
        elements.first
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }
    
    func parentIndex(orParentAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    private mutating func siftDown(from index: Int) {
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            
            var candidate = parent
            
            if left < count && sort(elements[left].1, elements[candidate].1) {
                candidate = left
            }
            
            if right < count && sort(elements[right].1, elements[right].1) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            
            parent = candidate
        }
    }
    
    private mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(orParentAt: child)
        
        while child > 0 && sort(elements[child].1, elements[parent].1) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(orParentAt: child)
        }
    }
    
    mutating func remove() -> (Int,Int)? {
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        
        defer {
            siftDown(from: 0)
        }
        
        return elements.removeLast()
    }
    
    mutating func insert(_ element: (Int,Int)) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
}

struct PriorityQueue {
    private var heap: Heap
    
    init(sort: @escaping (Int,Int) -> Bool, elements:[(Int,Int)] = []) {
        heap = Heap(elements: elements,sort: sort)
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var peek: (Int,Int)? {
        heap.peek()
    }
    
    @discardableResult mutating func enqueue(_ element: (Int,Int)) -> Bool {
        heap.insert(element)
        return true
    }
    
    mutating func dequene() -> (Int,Int)? {
        heap.remove()
    }
}

let INF = Int.max


let line = readLine()!.components(separatedBy: " ").map { Int($0)!}
// 노드
var n = line[0]
// 간선
var m = line[1]
// 시작 노드 번호를 입력받기
let start = Int(readLine()!)!
// 각 노드에 연결되어 있는 노드에 대한 정보를 담는 리스트 만들기
var graph = [[(Int,Int)]](repeating:[(Int,Int)](), count: n + 1)
// 최단 거리 테이블을 모두 무한으로 초기화
var distance = [Int](repeating: INF, count: n + 1)

// 모든 간선 정보 입력받기
for _ in 0..<m {
    let line2 = readLine()!.components(separatedBy: " ").map { Int($0)!}
    let a = line2[0]
    let b = line2[1]
    let c = line2[2]
    // a번 노드에서 b번 노드로 가는 비용이 c
    graph[a].append((b,c))
}

func dijkstra(_ start: Int) {
    var queue = PriorityQueue(sort: <, elements: [(start,0)])
    
    distance[start] = 0
    
    while !queue.isEmpty {
        // 가장 최단 거리가 짧은 노드에 대한 정보 꺼내기
        let queueValue = queue.dequene()!
        let dist = queueValue.1
        let nowNode = queueValue.0
        
        // 현재 노드가 이미 처리된 적이 있다면 무시
        if distance[nowNode] < dist {
            continue
        }
        
        // 현재 노드와 연결된 다른 인접한 노드들을 확인
        for i in graph[nowNode] {
            let cost = dist + i.1
            if cost < distance[i.0] {
                distance[i.0] = cost
                queue.enqueue((i.0,cost))
            }
        }
    }
}

dijkstra(start)
print(graph)

for i in 1...n {
    if distance[i] == INF {
        print("INFINITY")
    } else {
        print(distance[i])
    }
}
