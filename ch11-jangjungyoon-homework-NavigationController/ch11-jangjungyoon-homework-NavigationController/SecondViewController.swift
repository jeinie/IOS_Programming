//
//  SecondViewController.swift
//  ch11-jangjungyoon-homework-NavigationController
//
//  Created by 장정윤 on 2023/05/16.
//

import UIKit

class SecondViewController: UIViewController {

    var textValue: String?
    weak var delegate: SecondViewControllerDelegate?
    
    @IBOutlet weak var secondTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        secondTextField.text = textValue
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("창 닫힘")
        
        delegate?.updateTextField(secondTextField.text)
        print(">> dismiss")
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
}
