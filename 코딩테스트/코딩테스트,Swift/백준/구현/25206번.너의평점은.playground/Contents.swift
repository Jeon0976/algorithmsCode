import Foundation

var mother = 0.0
var son = 0.0

var scoureTable = [
    "A+": 4.5, "A0": 4.0, "B+": 3.5, "B0": 3.0, "C+": 2.5, "C0": 2.0,
    "D+": 1.5, "D0": 1.0, "F": 0.0
]

for _ in 0...19 {
    let course = readLine()!.components(separatedBy: " ")
    let scoure = Double(course[1])!
    let check = course[2]
    
    if let check = scoureTable.first(where: { $0.key == check }) {
        mother += scoure
        son += scoure * check.value
    }
}
print(son/mother)
