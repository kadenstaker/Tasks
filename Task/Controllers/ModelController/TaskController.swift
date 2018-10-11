//
//  TaskController.swift
//  Task
//
//  Created by Kaden Staker on 10/10/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let shared = TaskController()
    
    var tasks: [Task] {
        do {
            try fetchedResultsController.performFetch()
            guard let tasks = fetchedResultsController.fetchedObjects else { return [] }
            return tasks
        } catch {
            print("There was an error fetching tasks: \(error) \(error.localizedDescription)")
            return []
        }
    }
    
    let fetchedResultsController: NSFetchedResultsController<Task> = {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
    }
    
    func remove(task: Task) {
        let moc = CoreDataStack.context
        moc.delete(task)
        saveToPersistentStore()
    }
    
    func toggleIsComplete(for task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func fetchTasks() -> [Task]  {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return (try? moc.fetch(fetchRequest)) ?? []
    }
    
    private func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            print("There was an error saving to persistent store: \(error) \(error.localizedDescription)")
        }
    }
}
