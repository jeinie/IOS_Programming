import UIKit

func my(number: Int) -> Int {
    return number * 3
}

let numbers = [10,21,30]
//let y = numbers.map(my)

let y = numbers.map({
//    (number: Int) -> Int in
    // 위에 대신에
//    (number) in
    
//    3 * number
    // 위에 대신에
    3 * $0 // 인덱스로 생각하면 될 듯?
    

//    let result = 3 * number
//    return result
})

y

