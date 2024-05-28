//
//  CoreDataCRUDOperations.swift
//  MVVM_CoreDataAssessment
//
//  Created by jai prakash on 28/05/24.
//

import Foundation
import CoreData

protocol CoreDataCRUDOperations {
    associatedtype ManageObject: NSManagedObject
    
    func delete()
    
    static func create(_ object: (ManageObject) -> Void) -> ManageObject?
    static func update()
    
    static func delete(_ object: ManageObject)
    static func fetchAll() -> [ManageObject]
}

extension CoreDataCRUDOperations {
    
    @discardableResult
    static func create(_ object: (ManageObject) -> Void) -> ManageObject? {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let task = ManageObject.init(entity: Task.entity(), insertInto: context)
        object(task)
        do {
            try context.save()
            return task
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func update() {
        self.saveContext()
    }
    
    
    static func delete(_ object: ManageObject) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        context.delete(object)
        self.saveContext()
    }
    
    static func fetchAll() -> [ManageObject] {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let request = NSFetchRequest<ManageObject>(entityName: ManageObject.entity().name ?? "")
        do {
            return try context.fetch(request)
        } catch {
            return []
        }
    }
    
    
    static func saveContext(_ action: (() -> Void)? = nil) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        do {
            try context.save()
            action?()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
}
