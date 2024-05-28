//
//  TaskViewModel.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import Foundation

class TaskViewModel {
    var tasks: [Task] = []
    init() {
        self.tasks = Task.fetchAll()
    }
    
    @discardableResult
    func create(
        title: String,
        description: String,
        dueDate: Date,
        priority: Int16
    ) -> Task? {
        let task = Task.create(
            title: title,
            description: description,
            dueDate: dueDate,
            priority: priority
        )
        self.tasks = Task.fetchAll()
        return task
    }
    
    
    func delete(task: Task) {
        task.delete()
        self.tasks = Task.fetchAll()
    }
    
    func update(task: Task, _ action: (Task) -> Void) {
        action(task)
        Task.update()
        self.tasks = Task.fetchAll()
    }
    
    
}
