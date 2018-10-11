//
//  Task+Convenience.swift
//  Task
//
//  Created by Kaden Staker on 10/10/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String?, due: Date?, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.due = due
        self.isComplete = false
    }
}
