//
//  WebViewController.swift
//  ch06-장정윤-tabBarController
//
//  Created by 장정윤 on 2023/04/15.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    let cityViewController = CityViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // WKWebView 초기화
        webView.navigationDelegate = self
        
        // webView 를 뷰에 추가
        view.addSubview(webView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // CityViewController 에서 선택한 도시이름 가져오기
        let parent = self.parent as! UITabBarController
        let cityViewController = parent.viewControllers![0] as! CityViewController
        var (city, _, _) = cityViewController.getCurrentLonLat()
        
        if city == "현재위치" {
            city = ""
        }
        
        let urlStr = "https://en.wikipedia.org/wiki/" + city
        
        // URL 객체 생성
        let myUrl = URL(string: urlStr)
        // URL Request 객체 생성
        let request = URLRequest(url: myUrl!)
        //
        webView.load(request)
        
    }
}
