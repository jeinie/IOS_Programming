//
//  MapViewController.swift
//  ch06-장정윤-tabBarController
//
//  Created by 장정윤 on 2023/04/11.
//

import UIKit
import MapKit

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
        
        updateMap(title: city, longitute: longitute, latitute: latitute)
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
