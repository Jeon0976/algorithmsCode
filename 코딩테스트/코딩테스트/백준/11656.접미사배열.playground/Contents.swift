import Foundation

let stringValue = readLine()!

var suffixes: [String] = []

for i in stringValue.indices {
    let suffix = String(stringValue.suffix(from: i))
    suffixes.append(suffix)
}


