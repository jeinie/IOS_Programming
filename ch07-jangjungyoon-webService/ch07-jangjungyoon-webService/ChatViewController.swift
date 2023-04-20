//
//  ChatViewController.swift
//  ch07-jangjungyoon-webService
//
//  Created by 장정윤 on 2023/04/18.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var chatView: UITextView!
    @IBOutlet weak var input: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parent = self.parent as! UITabBarController
        let cityViewController = parent.viewControllers![0] as! CityViewController
        let (city, _, _) = cityViewController.getCurrentLonLat()
        
        input.text = city
    }
    
    @IBAction func queryBtn(_ sender: UIButton) {
        let apiKey = "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"
        let baseURL = "https://api.openai.com/v1/engines/curie/completions"
        
        let parameters: [String: Any] = [
            "prompt": "\(input.text!)",
            "temperature": 0.5,
            "max_tokens": 500
        ]
        
        guard let url = URL(string: baseURL) else {
            print("유효하지 않은 URL 입니다.")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        urlRequest.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let jsonData = data else { print(error!); return }
            if let jsonStr = String(data:jsonData, encoding: .utf8) {
                print(jsonStr)
            }
            
            let json = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
            guard let choices = json["choices"] as? [[String: Any]], let text = choices.first?["text"] as?
                    String else {
                    print("유효하지 않은 응답 데이터입니다.")
                    return
            }
            DispatchQueue.main.async {
                self.chatView.text = text
            }
        }
        task.resume()
    }
    
}
