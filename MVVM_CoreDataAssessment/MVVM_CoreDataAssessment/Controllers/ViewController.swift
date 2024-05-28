//
//  ViewController.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    
    var viewModel: TaskViewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "TaskTVC", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TaskTVC")
    }
    
    
    @IBAction func onCreateTask(_ sender: UIButton) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailVC else {
            return
        }
        vc.viewModel = self.viewModel
        vc.delegate = self
        self.present(vc, animated: true)
    }
}

extension ViewController: TaskDetailVCDelegate {
    func taskDetailVC(_ taskDetailVC: TaskDetailVC, onChange task: Task?) {
        self.tableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTVC", for: indexPath) as! TaskTVC
        
        let task = self.viewModel.tasks[indexPath.row]
        cell.config(task: task)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailVC else {
            return
        }
        
        vc.task = self.viewModel.tasks[indexPath.row]
        vc.viewModel = self.viewModel
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = viewModel.tasks[indexPath.row]
            self.viewModel.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
}
