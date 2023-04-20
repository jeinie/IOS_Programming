import UIKit

var greeting = "Hello, playground"

let names: [String] = ["tiger", "lion", "fox", "bear"]
let reversed0 = names.sorted(by: {(first: String, second: String) -> Bool in
    return first < second
})
print(reversed0)

let reversed1 = names.sorted(){(first: String, second: String) -> Bool in
    return first < second
}
print(reversed1)

let reversed2 = names.sorted { // true, false 인 것도 알고 매개변수가 두 개인 것도 알기 때문에 생략, () 도 생략
    $0 < $1
}
print(reversed2)

let mapped = names.map() {
    $0.uppercased()
}
print(mapped)

let filtered = names.filter() {
    return $0 > "j"
}
print(filtered)

let reduced = names.reduce("jyjang") {
    return $0 + ", " + $1
}
print(reduced)

func myfunc(todo: () -> Void) {
    print("Hello, jyjnag")
}

myfunc(todo: {
    print("Hello, yyy")
})

let session = URLSession(configuration: .default)
let _url = URL(string: "http://www.hansung.ac.kr")

let request = URLRequest(url: _url!)

let dataTask = session.dataTask(with: _url!) {
    (data, response, error) in
    if let error = error {
        print(error)
        return
    }
    if let jsonData = data {
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
    }
}
