//
//  ViewController.swift
//  ch06-장정윤-tabBarController
//
//  Created by 장정윤 on 2023/04/11.
//

import UIKit
import CoreLocation // Core Location 프레임워크 임포트

class CityViewController: UIViewController, CLLocationManagerDelegate { // CLLocationManagerDelegate 구현 추가

    @IBOutlet weak var cityPickerView: UIPickerView!
    
    var cities: [String: [String:Double?]] = [
    "Seoul" : ["lon":126.9778,"lat":37.5683], "Athens" : ["lon":23.7162,"lat":37.9795], "Bangkok" : ["lon":100.5167,"lat":13.75], "Berlin" : ["lon":13.4105,"lat":52.5244], "Jerusalem" : ["lon":35.2163,"lat":31.769], "Lisbon" : ["lon":-9.1333,"lat":38.7167], "London" : ["lon":-0.1257,"lat":51.5085], "New York" : ["lon":-74.006,"lat":40.7143], "Paris" : ["lon":2.3488,"lat":48.8534], "Sydney" : ["lon":151.2073,"lat":-33.8679],
    "현재위치" : ["lon":nil, "lat":nil]
    ]
    
    // CLLocationManager 인스턴스 생성
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("CityViewController.viewDidLoad") // 먼저 호출되고 sceneDidBecomeActive 호출됨
        
        // cityPickerView 초기화
        cityPickerView.dataSource = self
        cityPickerView.delegate = self
        
        // CLLocationManager 인스턴스 초기화
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // 위치 권한 설정
        locationManager.startUpdatingLocation() // 위치 업데이트 시작
    }
}

extension CityViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let cityNames = Array(cities.keys)
        return cityNames.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var cityNames = Array(cities.keys)
        cityNames.sort()
        
        return cityNames[row]
    }
}

extension CityViewController {
    func getCurrentLonLat() -> (String, Double?, Double?) {
        var cityNames = Array(cities.keys)
        cityNames.sort()
        let selectedCity = cityNames[cityPickerView.selectedRow(inComponent: 0)]
        let city = cities[selectedCity]
        return (selectedCity, city?["lon"]!, city?["lat"]!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        
        // 현재 위치의 좌표 사용
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        
        // 현재 위치를 읽어오면 다음과 같이 변경
        cities["현재위치"]?["lon"] = longitude
        cities["현재위치"]?["lat"] = latitude   
    }
}

