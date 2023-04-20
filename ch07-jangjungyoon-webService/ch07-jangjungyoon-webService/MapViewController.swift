//
//  MapViewController.swift
//  ch06-장정윤-tabBarController
//
//  Created by 장정윤 on 2023/04/11.
//

import UIKit
import MapKit
import Progress

class MapViewController: UIViewController {

    @IBAction func sgcValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    @IBOutlet weak var mapView: MKMapView!
    
    let baseURLString = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "f34dffcdec93bc79cc8f95c386bc03ed"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("MapViewController.viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("MapViewController.viewWillApeer")
        
        let parent = self.parent as! UITabBarController
        let cityViewController = parent.viewControllers![0] as! CityViewController
        let (city, longitute, latitute) = cityViewController.getCurrentLonLat()
        
        getWeatherData(cityName: city)
//        updateMap(title: city, longitute: longitute, latitute: latitute)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
    }
}

extension MapViewController {
    func updateMap(title: String, longitute: Double?, latitute: Double?) {
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        var center = mapView.centerCoordinate
        if let longitute = longitute,let latitute = latitute {
            center = CLLocationCoordinate2D(latitude: latitute, longitude: longitute)
        }
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController {
    func getWeatherData(cityName city: String) {
        Prog.start(in: self, .activityIndicator)
        var urlStr = baseURLString + "?" + "q=" + city + "&" + "appid=" + apiKey
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let session = URLSession(configuration: .default)
        let url = URL(string: urlStr)
        let request = URLRequest(url: url!)
        
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            guard let jsonData = data else{ print(error!); return }
            if let jsonStr = String(data: jsonData, encoding: .utf8) {
                print(jsonStr)
            }
            
            let (temperature, longitute, latitute) = self.extractWeatherData(jsonData: jsonData)
            var title = city
            if let temperature = temperature {
                title += String.init(format: ": %.2f℃", temperature)
            }
            DispatchQueue.main.async { // 후행 클로저
                self.updateMap(title: title, longitute: longitute, latitute: latitute)
                print(1)
                Prog.dismiss(in: self)
            }
            print(2)
        }
        dataTask.resume()
    }
}

extension MapViewController {
    func extractWeatherData(jsonData: Data) -> (Double?, Double?, Double?) {
        let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
        
        if let code = json["cod"] {
            if code is String, code as! String == "404" {
                return (nil, nil, nil)
            }
        }
        
        let latitude = (json["coord"] as! [String: Double])["lat"]
        let longitude = (json["coord"] as! [String: Double])["lon"]
        
        guard var temperature = (json["main"] as! [String: Double])["temp"] else {
            return (nil, longitude, latitude)
        }
        temperature = temperature - 273.0
        return (temperature, longitude, latitude)
    }
}
