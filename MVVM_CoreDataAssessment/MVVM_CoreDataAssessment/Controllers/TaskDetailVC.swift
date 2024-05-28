//
//  TaskDetailVC.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import UIKit


protocol TaskDetailVCDelegate: NSObject {
    func taskDetailVC(_ taskDetailVC: TaskDetailVC, onChange task: Task?)
}

class TaskDetailVC: UIViewController {

    weak var viewModel: TaskViewModel?
    weak var delegate: TaskDetailVCDelegate?
    var task: Task?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewDescription: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var textFieldPriority: UITextField!
    
    @IBOutlet weak var buttonCreateNow: UIButton!
    @IBOutlet weak var buttonUpdate: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setupView()
        
    }
    
    func setupView() {
        if self.task != nil {
            self.buttonDelete.isHidden = false
            self.buttonUpdate.isHidden = false
            self.buttonCreateNow.isHidden = true
            
            self.datePicker.date = self.task?.dueDate ?? .now
            self.textFieldTitle.text = self.task?.title
            self.textViewDescription.text = self.task?.taskDescription
            self.textFieldPriority.text = String(self.task?.priority ?? 0)
            
        } else {
            self.buttonDelete.isHidden = true
            self.buttonUpdate.isHidden = true
            self.buttonCreateNow.isHidden = false
        }
        
        self.scrollView.keyboardDismissMode = .onDrag
        
        // Outline
        textViewDescription.layer.borderColor = UIColor.lightGray.cgColor
        textViewDescription.layer.borderWidth = 0.5
        textViewDescription.layer.cornerRadius = 5.0
    }
    
    
    @IBAction func actionCreateNow(_ sender: UIButton) {
        
        if self.isDataVerified() == false {
            self.showAlert(message: "Please fill every field")
            return
        }
        
        let task = self.viewModel?.create(
            title: self.textFieldTitle.text!,
            description: self.textViewDescription.text!,
            dueDate: self.datePicker.date,
            priority: Int16(self.textFieldPriority.text!) ?? 0
        )
        self.dismiss(animated: true)
        self.delegate?.taskDetailVC(self, onChange: task)
    }
    
    @IBAction func actionUpdate(_ sender: UIButton) {
        if self.isDataVerified() == false {
            self.showAlert(message: "Please fill every field")
            return
        }
        guard let task = self.task else { return }
        self.viewModel?.update(task: task, { task in
            task.title = self.textFieldTitle.text!
            task.taskDescription = self.textViewDescription.text!
            task.dueDate = self.datePicker.date
            task.priority = Int16(self.textFieldPriority.text!) ?? 0
        })
        self.dismiss(animated: true)
        self.delegate?.taskDetailVC(self, onChange: task)
    }
    
    @IBAction func actionDelete(_ sender: UIButton) {
        guard let task = self.task else { return }
        self.viewModel?.delete(task: task)
        self.dismiss(animated: true)
        self.delegate?.taskDetailVC(self, onChange: nil)
    }

    func isDataVerified() -> Bool {
        guard let taskTitle = self.textFieldTitle.text,
              let taskDesc = self.textViewDescription.text,
              let priority = self.textFieldPriority.text,
              !taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !taskDesc.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !priority.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            return false
        }
        return true
    }

    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert!", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        self.present(alert, animated: true)
        
    }
    
    
}
