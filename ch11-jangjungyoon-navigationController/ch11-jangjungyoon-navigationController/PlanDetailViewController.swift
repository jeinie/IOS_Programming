//
//  PlanDetailViewController.swift
//  ch10-jangjungyoon-stackView
//
//  Created by 장정윤 on 2023/05/14.
//

import UIKit

class PlanDetailViewController: UIViewController {
    
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var typePicker: UIPickerView!
    @IBOutlet weak var contentTextView: UITextView!
    
    var lpCheck = true
    var plan: Plan? // 나중에 PlanGroupViewController로부터 데이터를 전달받는다
    var saveChangeDelegate: ((Plan)-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.dataSource = self
        typePicker.delegate = self
        
        plan = plan ?? Plan(date: Date(), withData: true)
        dateDatePicker.date = plan?.date ?? Date()
        ownerLabel.text = plan?.owner

        // typePickerView 초기화
        if let plan = plan{
            typePicker.selectRow(plan.kind.rawValue, inComponent: 0, animated: false)
        }
       contentTextView.text = plan?.content

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)

        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        contentTextView.addGestureRecognizer(longPressGesture)
    }

    override func viewDidDisappear(_ animated: Bool) {
        if let saveChangeDelegate = saveChangeDelegate {
            plan!.content = contentTextView.text
            plan!.date = dateDatePicker.date
            plan!.owner = ownerLabel.text
            plan!.kind = Plan.Kind(rawValue: typePicker.selectedRow(inComponent: 0))!
            plan!.content = contentTextView.text
            saveChangeDelegate(plan!)
        }
    }

    @IBAction func gotoBack(_ sender: UIButton) {
        
        plan!.date = dateDatePicker.date
        plan!.owner = ownerLabel.text
        plan!.kind = Plan.Kind(rawValue: typePicker.selectedRow(inComponent: 0))!
        plan!.content = contentTextView.text

        saveChangeDelegate?(plan!)
        dismiss(animated: true, completion: nil)
//        navigationController?.popViewController(animated: true) // 아래 Back 을 활성화하려면
    }
    
    @objc func dismissKeyboard(_ sender: UIGestureRecognizer) {
        view.endEditing(true)
    }
}

extension PlanDetailViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Plan.Kind.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = Plan.Kind(rawValue: row)
        return type!.toString()
    }
}

extension PlanDetailViewController {
    @objc func longPress(_ sender: UIGestureRecognizer) {
        if lpCheck {
            performSegue(withIdentifier: "SelectContent", sender: nil)
        }
        lpCheck = !lpCheck
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectContent" {
            let scvc = segue.destination as! SelectContentViewController
            scvc.pdvc = self
        }
    }
}
