//
//  TaskTVC.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import UIKit

class TaskTVC: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var taskDetailsLbl: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var priority: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(task: Task) {
        self.titleLbl.text = task.title
        self.taskDetailsLbl.text = task.taskDescription
        self.dueDate.text = "\(task.dueDate ?? .now)"
        self.priority.text = "\(task.priority)"
    }
    
}
