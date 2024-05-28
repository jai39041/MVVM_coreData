//
//  Task+Extension.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import Foundation

extension Task: CoreDataCRUDOperations {
    
    typealias ManageObject = Task
    
    @discardableResult
    static func create(
        title: String,
        description: String,
        dueDate: Date,
        priority: Int16
    ) -> Task? {
       return Task.create { task in
            task.title = title
            task.dueDate = dueDate
            task.priority = priority
            task.taskDescription = description
        }
    }
    
    
    func delete() { Self.delete(self) }
    
}
