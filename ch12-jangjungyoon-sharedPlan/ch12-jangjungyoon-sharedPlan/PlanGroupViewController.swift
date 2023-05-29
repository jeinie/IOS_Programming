//
//  ViewController.swift
//  ch09-tableView
//
//  Created by 장정윤 on 2023/05/02.
//

import UIKit
import FSCalendar

class PlanGroupViewController: UIViewController {
    
    @IBOutlet weak var fsCalendar: FSCalendar!
    
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

//        let plan = Plan(date: nil, withData: true)        // 가짜 데이터 생성
//        planGroup.saveChange(plan: plan, action: .Add)

//        self.performSegue(withIdentifier: "AddPlan", sender: self)
        
        let planDetailViewController = storyboard?.instantiateViewController(withIdentifier: "PlanDetail")
        if let viewController = planDetailViewController {
//            present(viewController, animated: true, completion: nil)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @IBOutlet weak var planGroupTableView: UITableView!
    var planGroup: PlanGroup!
    var selectedDate: Date? = Date()
    
    var x = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        planGroupTableView.dataSource = self        // 데이터 소스로 등록
        planGroupTableView.delegate = self
        
        fsCalendar.dataSource = self
        fsCalendar.delegate = self

        planGroup = PlanGroup(parentNotification: receivingNotification)
        planGroup.queryData(date: Date())
        
        //planGroupTableView.isEditing = true
        
        view.addSubview(x)
        
        
        let leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editingPlans1))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.title = "Plan Group"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Owner.loadOwner(sender: self)
    }
    
    func receivingNotification(plan: Plan?, action: DbAction?) {
        self.planGroupTableView.reloadData()
        fsCalendar.reloadData()
    }
}

extension PlanGroupViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let planGroup = planGroup {
            return planGroup.getPlans(date: selectedDate).count
        }
        return 0    // planGroup가 생성되기전에 호출될 수도 있다
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "")
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableViewCell")!

        // planGroup는 대략 1개월의 플랜을 가지고 있다.
        let plan = planGroup.getPlans(date: selectedDate)[indexPath.row] // Date를 주지않으면 전체 plan을 가지고 온다

        // 적절히 cell에 데이터를 채움
//        cell.textLabel!.text = plan.date.toStringDateTime()
//        cell.detailTextLabel?.text = plan.content
        
        
//        (cell.contentView.subviews[0] as! UIImageView).image = UIImage(named: "user.png")
        (cell.contentView.subviews[1] as! UILabel).text = plan.content
        (cell.contentView.subviews[0] as! UILabel).text = plan.date.toStringDateTime()
        (cell.contentView.subviews[2] as! UILabel).text = plan.owner
        
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
            let plan = self.planGroup.getPlans(date: selectedDate)[indexPath.row]
            let title = "Delete \(plan.content)"
            let message = "Are you sure you want to delete this item?"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [self] (action:UIAlertAction) -> Void in
                
                // 선택된 row의 플랜을 가져온다
                let plan = self.planGroup.getPlans(date: selectedDate)[indexPath.row]
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
        let from = planGroup.getPlans(date: selectedDate)[sourceIndexPath.row]
        let to = planGroup.getPlans(date: selectedDate)[destinationIndexPath.row]
        planGroup.changePlan(from: from, to: to)
        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
    }
}

extension PlanGroupViewController {

    func saveChange(plan: Plan) {
        if planGroupTableView.indexPathForSelectedRow != nil {
            planGroup.saveChange(plan: plan, action: .Modify)
        }else {
            planGroup.saveChange(plan: plan, action: .Add)
        }
    }
}

extension PlanGroupViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        if segue.identifier == "ShowPlan"{
            let planDetailViewController = segue.destination as! PlanDetailViewController
            // plan이 수정되면 이 saveChangeDelegate를 호출한다
            planDetailViewController.saveChangeDelegate = saveChange
            
            // 선택된 row가 있어야 한다
            if let row = planGroupTableView.indexPathForSelectedRow?.row{
                // plan을 복제하여 전달한다. 왜냐하면 수정후 취소를 할 수 있으므로
                planDetailViewController.plan = planGroup.getPlans(date:selectedDate)[row].clone()
            }
        }
        if segue.identifier == "AddPlan"{
            let planDetailViewController = segue.destination as! PlanDetailViewController
            planDetailViewController.saveChangeDelegate = saveChange
            
            // 빈 plan을 생성하여 전달한다
            planDetailViewController.plan = Plan(date:selectedDate, withData: false)
            planGroupTableView.selectRow(at: nil, animated: true, scrollPosition: .none)

        }
    }
}

extension PlanGroupViewController {
    @IBAction func editingPlans1(_ sender: UIBarButtonItem) {
        if planGroupTableView.isEditing == true {
            planGroupTableView.isEditing = false
            //sender.setTitle("Edit", for: .normal)
            sender.title = "Edit"
        } else {
            planGroupTableView.isEditing = true
            //sender.setTitle("Done", for: .normal)
            sender.title = "Done"
        }
    }
}

extension PlanGroupViewController {
    @IBAction func addPlans1(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "AddPlan", sender: sender.self)
    }
}

extension PlanGroupViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // 날짜가 선택되면 호출된다
        selectedDate = date.setCurrentTime()
        planGroup.queryData(date: date)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // 스와이프로 월이 변경되면 호출된다
        selectedDate = calendar.currentPage
        planGroup.queryData(date: calendar.currentPage)
    }
    
    // 이함수를 fsCalendar.reloadData()에 의하여 모든 날짜에 대하여 호출된다.
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let plans = planGroup.getPlans(date: date)
        if plans.count > 0 {
            return "[\(plans.count)]"    // date에 해당한 plans의 갯수를 뱃지로 출력한다
        }
        return nil
    }
}
