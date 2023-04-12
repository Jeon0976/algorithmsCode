import Foundation

/// 1. 모함가 길드
func adventureGuild(_ N: Int,_ array: [Int]) -> Int {
    let arr = array.sorted()
    
    var result = 0
    // 현재 그룹에 포함된 모험가의 수
    var count = 0
    
    for i in arr {
        count += 1
        if count >= i {
            result += 1
            count = 0
        }
    }
    
    return result
}

adventureGuild(8, [4,3,2,2,2,2,1,1])

/// 2. 곱하기 혹은 더하기
func MutiOrPlus(_ string: String) -> Int {
    let array = string.map { Int(String($0))!}
    
    var result = 1
    
    for num in array {
        if num == 0 {
            result += num
        } else {
            result *= num
        }
    }
    
    return result
}

MutiOrPlus("567")

/// 3. 문자열 뒤집기
/// - 나의 풀이
func splitString(_ n:String)  -> Int {
    var nArray = n.map { Int(String($0))! }
    var array = [[Int]](repeating: [Int](), count: nArray.count)
    
    var count = 0
    
    for i in 0..<nArray.count {
        if count == i {
            for j in i..<nArray.count {
                if nArray[i] == nArray[j] {
                    array[i].append(nArray[i])
                    count += 1
                } else {
                    break
                }
            }
        }
    }
    
    array = array.filter { !$0.isEmpty }
    print(array)
    if array[0].count == nArray.count {
        return 0
    } else {
        return (array.count)/2
    }
}
/// - 답지 풀이
/// - 모두 0으로 만드는 경우와 모두 1로 만드는 경우를 고려하고 최솟값 뽑기
func splitString2(_ n:String) -> Int {
    var nArray = n.map { Int(String($0))! }
    
    var count0 = 0
    var count1 = 0
    
    if nArray[0] == 1 {
        count0 += 1
    } else {
        count1 += 1
    }
    
    for i in 0..<nArray.count - 1 {
        if nArray[i] != nArray[i + 1] {
            if nArray[i + 1] == 1 {
                count0 += 1
            } else {
                count1 += 1
            }
        }
    }
    
    return min(count0,count1)
}

splitString("0001")
splitString2("0001100")

/// 4. 만들 수 없는 금액
func unMakeableprice(_ array:[Int]) -> Int {
    var array = array.sorted()
    
    var target = 1
    
    for num in array {
        if target < num {
            break
        } else {
            target += num
        }
    }
    
    return target
}

unMakeableprice([3,1,6,2,7,30,1])


/// 5. 볼링공 고르기
func pickBall(_ array: [Int]) -> Int {
    var result = 0
    
    for i in 0..<array.count {
        for j in i+1..<array.count {
            if array[i] != array[j] {
                result += 1
            }
        }
    }
    return result
}

pickBall([1,5,4,3,2,4,5,2])

/// 6. 무지의 먹방 라이브
/// 앞으로 나가면서 하나씩 하나씩 감소하는 방법보단 우선순위 큐를 활용해서
/// 최소 금액부터
func solution3(_ food_times:[Int], _ k:Int64) -> Int {
    var food = food_times
    var count = food.count
    var result = 0
    
    var nextIndex = -1
    
    for i in 0...k-1 {
        if food[Int(i)%count] != 0 && nextIndex == -1 {
            food[Int(i)%count] -= 1
            result = Int(i)%count
            print("1: ",result)
        } else {
            if nextIndex == 0 {
                for j in Int(i)%count...count - 1 {
                    if nextIndex != 0 {
                        break
                    } else if food[j] != 0 {
                        nextIndex = j
                        result = j
                        food[nextIndex] -= 1
                    }
                    print("2: ",result)
                }
            } else {
                if result + 1 == count {
                    nextIndex = 0
                    result = 0
                    if food[nextIndex] == 0 {
                        while food[nextIndex] == 0 {
                            nextIndex += 1
                            result += 1
                        }
                        food[nextIndex] -= 1
                    } else {
                        food[nextIndex] -= 1
                    }
                    print("3: ",result)

                } else {
                    if food[nextIndex + 1] == 0 {
                        nextIndex += 1
                        while food[nextIndex] == 0 && nextIndex == count - 1 {
                            nextIndex += 1
                            result += 1
                        }
                        food[nextIndex % count] -= 1
                    } else {
                        nextIndex += 1
                        result = nextIndex
                        food[nextIndex] -= 1
                        print("4: ",result)
                    }
                }
            }
            
        }
        print(food)
    }
    print(food)
    if result == count - 1 {
        result = 0
    }

    while food[result] == 0 {
        result += 1
    }
    
       
    
    let filterArray = food.filter { $0 == 0 }
    
    
    return filterArray.count == count ? -1 : result + 1
}

//solution3([1,1,5,2,2], 10)
//var arr2 = [[Int]](repeating: Array(repeating: 1,count: 5 ), count: 3)
//
//arr2.count
//
//0%3
//1%3
//2%3
//3%3
//4%3
//5%3
//
//for i in 1...5 {
//    print(i)
//}
0/2
struct Heap {
    var elements = [(Int,Int)]()
    
    let sort: (Int,Int) -> Bool
    
    init(sort: @escaping (Int,Int) -> Bool, elements: [(Int,Int)] = [(Int,Int)]()) {
        self.sort = sort
        self.elements = elements
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
    
    func parentIndex(ofChild index: Int) -> Int {
        (index - 1) / 2
    }
    
    private mutating func shiftDown(from index: Int) {
        var parent = index
        
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            
            if left < count && sort(elements[left].0, elements[candidate].0) {
                candidate = left
            }
            if right < count && sort(elements[right].0, elements[candidate].0) {
                candidate = right
            }
            
            if candidate == parent {
                return
            }
            
            elements.swapAt(parent, candidate)
            
            parent = candidate
        }
    }
    
    private mutating func shitUp(form index: Int) {
        var child = index
        var parent = parentIndex(ofChild: child)
        
        while child > 0 && sort(elements[child].0, elements[parent].0 ) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChild: child)
        }
    }
    
    mutating func remove() -> (Int,Int)? {
        guard !isEmpty else {
            return nil
        }
        
        elements.swapAt(0, count - 1)
        
        defer {
            shiftDown(from: 0)
        }
        
        return elements.removeLast()
    }
    
    mutating func insert(_ element: (Int,Int)) {
        elements.append(element)
        
        shitUp(form: elements.count - 1)
    }
}


struct PriorityQueue {
    private var heap: Heap
    
    init(sort: @escaping (Int,Int) -> Bool, elements: [(Int,Int)] = [(Int,Int)]() ) {
        heap = Heap(sort: sort,elements: elements)
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    func peek()  -> (Int,Int)? {
        heap.peek()
    }
    
    @discardableResult mutating func enquene(_ element: (Int,Int)) -> Bool {
        heap.insert(element)
        return true
    }
    
    mutating func dequeue() -> (Int,Int)? {
        heap.remove()
    }
}

// 이 문제는 시간이 적게 걸리는 음식부터 확인하는 탐욕적 접근 방식으로 해결할 수 있다. 모든 음식을 시간을 기준으로 정렬한 뒤에, 시간이 적게 걸리는 음식부터 제거해 나가는 방식을 이용하면 된다.
// 이를 위해 우선순위 큐를 이용하여 구현할 수 있다.
// 1. 초기 단계에서는 모든 음식을 우선순위 큐에 삽입한다. 또한 마지막 K초 후에 먹어야 할 음식의 번호를 출력해야 하므로 우선순위 큐에 삽입할 때 (음식 시간, 음식 번호)의 튜플 형태로 삽입한다.
// 2. 첫 단계에서는 가장 적게 걸리는 음식을 뺀다. 음식의 개수 x 음식을 먹는 시간 을 최종 시간에서 뺀다.
// 3. 전체 남은 시간에서 다음 단계 음식을 뺀다. 전체 남은 시간이 뺄 시간보다 작으면 빼지 않는다.
// 4. 매 초 먹어야 할 음식들을 일렬로 나열하고, 전체 남은 시간의 + 1 음식의 번호를 출력하면 정답이다.
// 시간 순 정렬을 위해 (음식 시간, 음식 번호)
func solution3H(_ food_times:[Int], _ k:Int64) -> Int {
    var count = food_times.count
    let total = food_times.reduce(0, +)
    
    if total <= k {
        return -1
    }
    
    // 시간이 작은 음식부터 빼야 하므로 우선순위 큐 사용
    var foods = PriorityQueue(sort: <)
    
    for i in 0...count - 1 {
        // 음식 시간, 음식 번호 순
        foods.enquene((food_times[i],i+1))
    }
    // 현재 음식 시간
    var now = foods.peek()!
    
    // 먹기 위해 사용한 시간
    var sum_value = 0
    // 직전에 다 먹은 음식 시간
    var previous = 0
    
    // sum_value + (현재 음식 시간 - 이전 음식 시간) * 현재 음식 개수와 K 비교
    while (sum_value + (now.0 - previous) * count) <= k {
        now = foods.dequeue()!
        sum_value += (now.0 - previous) * count
        count -= 1
        previous = now.0
        now = foods.peek()!
    }
    var result = [(Int,Int)]()
    
    while !foods.isEmpty {
        result.append(foods.dequeue()!)
    }
    
    // 음식의 번호 기준으로 정렬
    result.sort(by: { $0.1 < $1.1} )
    return result[(Int(k) - sum_value) % count].1
}

solution3H([8,6,4], 15)
solution3H([3,1,2], 5)
