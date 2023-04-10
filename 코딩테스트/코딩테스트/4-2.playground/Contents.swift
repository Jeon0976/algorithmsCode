import Foundation

// K번째 수
func solution1(_ array:[Int], _ commands:[[Int]]) -> [Int] {
    var cutArray = [Int]()
    
    var start = [Int]()
    var end = [Int]()
    var numberLocation = [Int]()
    
    var result = [Int]()
    
    for i in 0..<commands.count {
        start.append(commands[i][0])
        end.append(commands[i][1])
        numberLocation.append(commands[i][2])
    }
    
    for i in 0..<start.count {
        let startIndex = start[i]
        let endIndex = end[i]
        let numberIndex = numberLocation[i]
        
        for j in 0..<array.count {
            if j >= startIndex-1 && j <= endIndex-1 {
                cutArray.append(array[j])
            }
            
        }
        
        cutArray = cutArray.sorted()
        print(cutArray)
        result.append(cutArray[numberIndex - 1])
        
        cutArray = []
    }
    
    return result
}

func solution1H(_ array:[Int], _ commands:[[Int]]) -> [Int] {
     return commands.map({(key) in
         return array[(key[0]-1)...(key[1]-1)].sorted()[key[2]-1]
     })

 }

solution1H([1, 5, 2, 6, 3, 7, 4]    , [[2, 5, 3], [4, 4, 1], [1, 7, 3]]    )

// 가운데 글자 가져오기

func solution2(_ s:String) -> String {
    var sArray = [String]()
    
    for ss in s {
        sArray.append(String(ss))
    }

    let count = sArray.count
    let half = count/2
    if count % 2 != 0 {
     return String(sArray[half])
    } else {
     return String(sArray[half-1]) + String(sArray[half])
    }
}

func solution2H(_ s:String) -> String {
    if Array(s).count % 2 == 0 {
        return String(Array(s)[(s.count/2)-1...(s.count/2)])
    }else{
        return String(Array(s)[s.count/2])
    }
}

func solution2HH(_ s:String) -> String {

    return String(s[String.Index(encodedOffset: (s.count-1)/2)...String.Index(encodedOffset: s.count/2)])
}



solution2H("qwer")

4 % 2
