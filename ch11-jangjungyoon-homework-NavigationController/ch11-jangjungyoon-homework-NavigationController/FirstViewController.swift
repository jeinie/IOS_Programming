//
//  FirstViewController.swift
//  ch11-jangjungyoon-homework-NavigationController
//
//  Created by 장정윤 on 2023/05/16.
//

import UIKit

class FirstViewController: UIViewController, SecondViewControllerDelegate {
    
    func updateTextField(_ text: String?) {
        textField.text = text
    }
    

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func firstButton(_ sender: Any) {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.textValue = textField.text
        secondViewController.delegate = self
        present(secondViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func secondButton(_ sender: Any) {
        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        secondViewController.textValue = textField.text
        secondViewController.delegate = self
        navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @IBAction func thirdButton(_ sender: Any) {
        performSegue(withIdentifier: "ShowText", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowText" {
            print(">> prepare")
            let secondViewController = segue.destination as! SecondViewController
            secondViewController.textValue = textField.text
            secondViewController.delegate = self
        }
    }
    
}

protocol SecondViewControllerDelegate: AnyObject {
    func updateTextField(_ text: String?)
}
