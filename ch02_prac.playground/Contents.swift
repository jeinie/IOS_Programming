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
var greeting = "Hello!" // non-optional 변수

// 실습: optionalName 에 할당된 값이 nil 일 때 다른 값을 greeting 에 할당하도록 else 절을 추가하라.
if let name = optionalName {
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
