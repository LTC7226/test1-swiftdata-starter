//
//  Todo.swift
//  Todo
//
//  Created by YJ Soon 
//

import Foundation
import SwiftData

@Model
class Todo {
    var title: String
    var subtitle: String
    var isCompleted: Bool
    var order: Int
    var dueDate: Date?
    var assignedTo: Person?

    init(title: String, subtitle: String = "", isCompleted: Bool = false, order: Int = 0, dueDate: Date? = nil, assignedTo: Person? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.isCompleted = isCompleted
        self.order = order
        self.dueDate = dueDate
        self.assignedTo = assignedTo
    }
}
