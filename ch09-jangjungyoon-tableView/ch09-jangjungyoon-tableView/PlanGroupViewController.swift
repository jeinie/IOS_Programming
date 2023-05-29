//
//  ViewController.swift
//  ch09-tableView
//
//  Created by 장정윤 on 2023/05/02.
//

import UIKit

class PlanGroupViewController: UIViewController {
    
    @IBAction func editingPlans(_ sender: UIButton) {
        if planGroupTableView.isEditing == true{
            planGroupTableView.isEditing = false
            sender.setTitle("Edit", for: .normal)
        }else{
            planGroupTableView.isEditing = true
            sender.setTitle("Done", for: .normal)
        }
    }
    
    @IBAction func addingPlan(_ sender: UIButton) {
        let plan = Plan(date: nil, withData: true)        // 가짜 데이터 생성
            planGroup.saveChange(plan: plan, action: .Add)
    }
    
    @IBOutlet weak var planGroupTableView: UITableView!
    var planGroup: PlanGroup!
    
    var x = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        planGroupTableView.dataSource = self
        
        planGroup = PlanGroup(parentNotification: receivingNotification)
        planGroup.queryData(date: Date())
        
        //planGroupTableView.isEditing = true
        
        planGroupTableView.dataSource = self        // 데이터 소스로 등록
        planGroupTableView.delegate = self
        
        view.addSubview(x)
    }
    
    func receivingNotification(plan: Plan?, action: DbAction?) {
        self.planGroupTableView.reloadData()
    }
}

extension PlanGroupViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let planGroup = planGroup{
            return planGroup.getPlans().count
        }
        return 0    // planGroup가 생성되기전에 호출될 수도 있다
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableViewCell")!

        // planGroup는 대략 1개월의 플랜을 가지고 있다.
        let plan = planGroup.getPlans()[indexPath.row] // Date를 주지않으면 전체 plan을 가지고 온다

        // 적절히 cell에 데이터를 채움
//        cell.textLabel!.text = plan.date.toStringDateTime()
//        cell.detailTextLabel?.text = plan.content
        
        
        (cell.contentView.subviews[0] as! UIImageView).image = UIImage(named: "user.png")
        (cell.contentView.subviews[1] as! UILabel).text = plan.content
        (cell.contentView.subviews[2] as! UILabel).text = plan.date.toStringDateTime()
        
//        cell.accessoryType = .none
//        cell.accessoryView = nil
//        if indexPath.row % 2 == 0 {
//            cell.accessoryType = .detailDisclosureButton    // type
//        }else{
//            cell.accessoryView = UISwitch(frame: CGRect())  // View
//        }

        return cell
    }
}

extension PlanGroupViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            // 선택된 row의 플랜을 가져온다
            let plan = self.planGroup.getPlans()[indexPath.row]
            let title = "Delete \(plan.content)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action:UIAlertAction) -> Void in
                
                // 선택된 row의 플랜을 가져온다
                let plan = self.planGroup.getPlans()[indexPath.row]
                // 단순히 데이터베이스에 지우기만 하면된다. 그러면 꺼꾸로 데이터베이스에서 지워졌음을 알려준다
                self.planGroup.saveChange(plan: plan, action: .Delete)
            })
            
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil) //여기서 waiting 하지 않는다

        }
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 이것은 데이터베이스에 까지 영향을 미치지 않는다. 그래서 planGroup에서만 위치 변경
        let from = planGroup.getPlans()[sourceIndexPath.row]
        let to = planGroup.getPlans()[destinationIndexPath.row]
        planGroup.changePlan(from: from, to: to)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension PlanGroupViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPlan" {
            let planDetailViewController = segue.destination as! PlanDetailViewController
            planDetailViewController.saveChangeDelegate = saveChange
            
            if let row = planGroupTableView.indexPathForSelectedRow?.row {
                planDetailViewController.plan = planGroup.getPlans()[row].clone()
            }
        }
    }
}
