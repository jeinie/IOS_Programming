import UIKit

var sum: Int = 0

for x in 1...100 {
    sum += x
}

print(sum)

// 2번
var x: [Int] = []

for _ in 1...100 {
    var y = Int.random(in: 1...1000)
    x.append(y)
}

var min: Int = 0
var max: Int = 0

x.sort()
print(x[0], x[99])
// 2번

// 2번 다른 방법 (튜플 이용)
//func findMinMax(list: [Int]) -> (Int, Int) {
//    var min:Int = list[0]
//    var max:Int = list[0]
//    
//    for i in x {
//        if list[i] < min {
//            min = list[i]
//        }
//        if list[i] > max {
//            max = list[i]
//        }
//    }
//    return (min, max)
//}
//
//var y, z : Int, Int = findMinMax(list: x)
//print(y)
// 2번 다른 방법 (튜플 이용)

// 3번
x.sort(){
    return $0 > $1
}

print(x)



