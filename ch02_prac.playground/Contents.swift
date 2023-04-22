import UIKit

// 타입 지정
let inplicitInteger = 70
let implicitDouble = 70.5
let explicitDouble: Float = 4 // 자동 형변환 OK
print(explicitDouble)

// 형 변환
let label = "The width is "
let width = 94
let widthLabel = label + String(width)

// '\()' >> 문자열 안에 변수 값 적용
let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."

// 실습: \() 를 이용해 문자열 안에 실수형 계산을 포함하도록 해보고, 인사말 안에 누군가의 이름을 넣어보자.
let a:Float = 3.2
let b: Float = 4
let name = "홍길동"
let res = "실수들의 합은 \(a+b) 입니다. 안녕하세요, \(name)입니다."

// 배열, 딕셔너리
var shoppingList = ["catfish", "water", "tulips", "blue paint"]
shoppingList[1] = "bottle of water"

var occupations = ["Malcom": "Captian", "Kaylee": "Mechanic", ]
occupations["Jayne"] = "Public Relations"

// 빈 배열, 딕셔너리
let emptyArray = [String]()
let emptyDictionary = Dictionary<String, Float>()

// 옵셔널 변수 (옵셔널 변수 아닌 경우 무조건 값이 저장되어 있어야 함)
var optionalString: String? = "Hello" // 옵셔널 변수
optionalString == nil // false

var optionalName:String? = nil // optional 변수
//var optionalName:String? = "John"
var greeting = "Hello!" // non-optional 변수

// 실습: optionalName 에 할당된 값이 nil 일 때 다른 값을 greeting 에 할당하도록 else 절을 추가하라.
if let name = optionalName { // 옵셔널 바인딩: 옵셔널 변수에 nil 이 들어가 있지 않으면 그 값을 추출해 변수에 저장
    greeting = "Hello, \(name)"
} else {
    greeting = "Hi"
}
greeting

// 흐름제어
let individualScores = [75, 43, 103, 87, 12]

var teamScore = 0
for score in individualScores {
    if score > 50 { // if 문 안의 조건은 반드시 Boolean 표현으로
        teamScore += 3
    } else {
        teamScore += 1
    }
}
teamScore

// Switch 문 (반드시 default 문 있어야 함)
let vegetable = "red pepper"
switch vegetable {
case "celery":
    let vegetableComment = "Add some raisins and make ants on a log."
case "cucumber", "watercress":
    let vegetableComment = "That would make a good tea sandwich."
case let x where x.hasSuffix("pepper"):
    let vegetableComment = "Is it a spicy \(x)?"
default:
    let vegetableComment = "Everything tastes good in soup"
}


// for-in
// 실습: 어떤 숫자가 가장 큰 수로 저장되는지 확인하기 위해 다른 변수를 추가하고, 가장 큰 수로 저장된 타입이 무엇인지 확인
let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25, 36]
]
var largest = 0
var largestKey = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
            largestKey = kind
        }
    }
}
largest
largestKey

// 배열 인자
func sumOf(numbers: Int...) -> Double {
    var sum = 0
    for number in numbers {
        sum += number
    }
    return Double(sum/numbers.count)
}
sumOf(numbers: 42, 597, 12)

// 중첩 함수
func returnFifteen() -> Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}
returnFifteen()

// 함수: 최상위 타입 / 함수도 매개변수로 받을 수 있음
func hasAnyMatchers(list: [Int], condition: (Int) -> Bool) -> Bool {
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}

func lessThanTen(number: Int) -> Bool {
    return number < 10
}
var numbers = [20, 19, 7, 12]
hasAnyMatchers(list: numbers, condition: lessThanTen(number:))

// 클로저: 이름 없는 함수
// 실습: 모든 홀수 값에 대해 0을 반환
let numberList = [10, 21, 30]
let y = numberList.map(
    {
        (number) in // in 키워드 사용해서 인자와 반환값 타입 분리
        var result = 0
        if number % 2 != 0 {
            result = 0
        } else {
            result = 3 * number
        }
        return result
    }
)
y

var sum = 0
for x in 1...100 {
    sum += x
}
sum

var list = [Int]()
var min = 0
var max = 0
for _ in 1...100 {
    list.append(Int.random(in: 1...1000))
    list.sort()
    min = list[0]
    max = list[list.count-1]
}
print("min: \(min), max: \(max)")

var arr = [Int]()
for _ in 1...100 {
    arr.append(Int.random(in: 1...1000))
}
arr
// 정렬 (후행 클로저)
arr.sort {
    (a, b) in a < b
}
arr
