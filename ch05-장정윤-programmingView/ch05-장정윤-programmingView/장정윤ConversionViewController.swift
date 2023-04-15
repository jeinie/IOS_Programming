//
//  ViewController.swift
//  ch05-장정윤-programmingView
//
//  Created by 장정윤 on 2023/04/04.
//

import UIKit

class 장정윤ConversionViewController: UIViewController {
    
    var fahrenheitTextField: UITextField!
    var celsiusLabel: UILabel!
    
    var isLabel, fdegreeLabel, cdegreeLabel: UILabel!
    
    // 클래스 변수 추가
    var segmentedControl: UISegmentedControl!
    
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        x = 10
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
////        x = 10 // x 초기화되는 위치 확인 (여기서는 에러)
//    }
//
//    required init?(coder: NSCoder) {
//        x = 5
//        super.init(coder: coder)
//    }
    
//    var x: Int
//    var helloLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        isLabel = createLabel("is", fontSize: 36)
        isLabel.translatesAutoresizingMaskIntoConstraints = false
        isLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        isLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        fahrenheitTextField = createTextField(placeHolder: "VALUE")
        fdegreeLabel = createLabel("degrees Fahrenheit", fontSize: 36)
        celsiusLabel = createLabel("???", fontSize: 70)
        cdegreeLabel = createLabel("degrees Celsius", fontSize: 36)
        
        connectVertically(views: fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel, spacing: 10)
        connectHorizontally(views: fahrenheitTextField, fdegreeLabel, isLabel, celsiusLabel, cdegreeLabel)
        
        // 컨트롤들 수직 연결
        fahrenheitTextField.bottomAnchor.constraint(equalTo: fdegreeLabel.topAnchor, constant: -8).isActive = true
        
        // 컨트롤들 수평 연결
        fahrenheitTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        
        let label2 = UILabel(frame: CGRect())
        label2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label2)
        label2.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        label2.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true

        fahrenheitTextField.addTarget(self, action: #selector(fahrenheitEditingChanged), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        fahrenheitTextField.delegate = self
        
        addSegmentedControl()
        
        /*let helloLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 30))
        helloLabel.text = "Hello, Autolayout"
        helloLabel.backgroundColor = UIColor.green
        helloLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        helloLabel.textAlignment = .center
        view.addSubview(helloLabel)
        
        helloLabel.translatesAutoresizingMaskIntoConstraints = false
//        let centerXConstraint = helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
//        helloLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
//        let centerYConstraint = helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
//        helloLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            helloLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            helloLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            helloLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])*/
        
//        view.addSubview(helloLabel)
//        centerXConstraint.isActive = true
//        centerYConstraint.isActive = true
//        view.addSubview(helloLabel)
        
        /*let nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameLabel.text = "Name"
        nameLabel.backgroundColor = UIColor.green
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameLabel.textAlignment = .center
        
        let nameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        nameTextField.backgroundColor = UIColor.brown
        nameTextField.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        nameTextField.textAlignment = .left
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: nameTextField.leadingAnchor, constant: -10),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])

        nameLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        nameTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        nameTextField.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        nameLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: nameTextField.widthAnchor, multiplier: 0.5).isActive = true
        
        // editingDidEnd 액션을 추가
        nameTextField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
        // editingDidEnd이 끝났다는 것을 UITextField에 알리기 위해
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)*/
    }
    
    /*@objc func editingDidEnd(sender: UITextField) {
        if let text = sender.text, let fahrenheitValue = Double(text) {
            sender.text = String.init(format: "%2f", (5.0/9.0)*(fahrenheitValue-32.0))
        }
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }*/
}

extension 장정윤ConversionViewController {
    func createTextField(placeHolder: String) -> UITextField {
        let textField = UITextField(frame: CGRect())
        textField.textAlignment = .center
        textField.placeholder = placeHolder
        textField.font = UIFont(name: textField.font!.fontName, size: 70)
        textField.keyboardType = .decimalPad
        view.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    func createLabel(_ text: String, fontSize: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect())
        label.text = text
        label.textColor = UIColor(red: CGFloat(0xe1)/CGFloat(256), green: CGFloat(0x58)/CGFloat(256),
                                  blue: CGFloat(0x29)/CGFloat(256), alpha: CGFloat(1))
        label.textAlignment = .center
        label.font = UIFont(name: label.font!.fontName, size: fontSize)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func connectVertically(views: UIView..., spacing: CGFloat) {
        for i in 0..<views.count-1 {
            views[i].bottomAnchor.constraint(equalTo: views[i+1].topAnchor, constant: spacing).isActive = true
        }
    }
    
    func connectHorizontally(views: UIView...) {
        for view in views {
            view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
    }
    
    @objc func fahrenheitEditingChanged(sender: UITextField) {
        if let text = sender.text {
            if let fahrenheitValue = Double(text) {
                // 변경
                if segmentedControl.selectedSegmentIndex == 0 {
                    let celsiusValue = 5.0/9.0*(fahrenheitValue-32.0)
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                } else {
                    let celsiusValue = 9.0/5.0*fahrenheitValue + 32.0
                    celsiusLabel.text = String.init(format: "%.2f", celsiusValue)
                }
            } else {
                celsiusLabel.text = "???"
            }
        }
    }
}

extension 장정윤ConversionViewController {
    @objc func dismissKeyboard(sender: UIGestureRecognizer) {
        fahrenheitTextField.resignFirstResponder()
    }
}

extension 장정윤ConversionViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) ->
    Bool {
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        if existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil {
            return false
            
        } else {
            return true
        }
    }
}

// addSegmentedControl() 추가
extension 장정윤ConversionViewController {
    func addSegmentedControl() {
        segmentedControl = UISegmentedControl(items: ["Fahrenheit", "Celsius"])
        let font = UIFont.systemFont(ofSize: 20)
        segmentedControl!.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        
        segmentedControl.addTarget(self, action: #selector(changeDegrees), for: .valueChanged)
    }
}

// changeDegrees() 추가
extension 장정윤ConversionViewController {
    @objc func changeDegrees(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            fdegreeLabel.text = "degrees Fahrenheit"
            cdegreeLabel.text = "degrees Celsius"
        } else {
            fdegreeLabel.text = "degrees Celsius"
            cdegreeLabel.text = "degrees Fahrenheit"
        }
        fahrenheitTextField.text = ""
        celsiusLabel.text = "???"
    }
}
