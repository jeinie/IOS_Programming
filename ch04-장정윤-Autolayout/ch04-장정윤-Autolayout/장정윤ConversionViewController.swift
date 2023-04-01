//
//  ConversionViewController.swift
//  ch03-convert
//
//  Created by 장정윤 on 2023/03/21.
//

import UIKit

class 장정윤ConversionViewController: UIViewController {
    
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var celsiusLabel: UILabel!
}
 
extension 장정윤ConversionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fahrenheitTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
}
    
extension 장정윤ConversionViewController {
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        fahrenheitTextField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitEditingChange(_ sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text) {
                let celsiusVlaue = 5.0/9.0*(fahrenheitValue - 32.0)
                celsiusLabel.text = String.init(format: "%.2f", celsiusVlaue)
            } else {
                celsiusLabel.text = "???"
            }
        }
    }
}

extension 장정윤ConversionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
     }
}
