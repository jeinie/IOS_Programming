//
//  SelectContentViewController.swift
//  ch10-jangjungyoon-stackView
//
//  Created by 장정윤 on 2023/05/14.
//

import UIKit

class SelectContentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var previous = ""
    var pdvc: PlanDetailViewController!
    
    let contents = [
        "엄마 도와 드리기",
        "아르바이트",
        "청소하기",
        "학교 가서 밥 먹기",
        "10주차 과제하기",
        "친구와 카페가기",
        "데이트하기"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        previous = pdvc.contentTextView.text
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        pdvc.contentTextView.text = previous
        dismiss(animated: true)
    }
    
    
    @IBAction func selectButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension SelectContentViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = contents[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pdvc.contentTextView.text = contents[indexPath.item]
    }
}
