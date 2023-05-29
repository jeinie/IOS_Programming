import UIKit

// document 디렉토리를 찾는다.
let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
print(docDir!.path) // 디렉토리 출력

// documents밑에 myfolder이라는 디렉토리를 만들어보자
let myfolderDir = docDir?.appendingPathComponent("myfolder")
// try?를 사용하면 이미 myfoder이 있으면 nil로 리턴되나 프로그램은 죽지않는다.
try! FileManager.default.createDirectory(atPath: myfolderDir!.path, withIntermediateDirectories: true, attributes: nil)

// 단순히 텍스트 파일을 write해보자
let myfileText = myfolderDir!.appendingPathComponent("jungyoon.txt")
let text = "Jang Jung Yoon"
if let _ = try? text.write(to: myfileText, atomically: true, encoding: .utf8){
    print("OK: writing text")
}else{
    print("NG: writing text")
}

// 아카이빙을 하여 아카이빙된 파일을 write해 보자
let archived = try? NSKeyedArchiver.archivedData(withRootObject: text, requiringSecureCoding: false)
let myfileArchive = myfolderDir!.appendingPathComponent("jungyoon.archive")
if let _ = try? archived?.write(to: myfileArchive){
    print("OK: writing archive")
}else{
    print("NG: writing archive")
}

// 파일의 존재여부 체크
if FileManager.default.fileExists(atPath: myfileText.path){
    print("OK: \(myfileText.path) exists")
}else{
    print("NG: \(myfileText.path) nonexists")
}

// 디렉토리내 파일목록
let fileList1 = try? FileManager.default.contentsOfDirectory(atPath: myfolderDir!.path)
if var fileList = fileList1{
    fileList.sort(by: {$0 < $1})
    for file in fileList{
        print("\t\(file)")
    }
    print("\tTotal \(fileList.count) files.")
}

// 아카이브 파일 읽어서 복원하기
let unarchived = try Data(contentsOf: myfileArchive)  // 파일에서 읽어오기
let text1 = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchived) // 복원하기
print("archived file: \(text1!)")

// 텍스트파일 읽기
let text2 = try? Data(contentsOf: myfileText) // 파일에서 읽어오기
print("text file: \(String(data: text2!, encoding: .utf8))")
