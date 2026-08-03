//
//  Person.swift
//  Todo
//
//  Created by YJ Soon
//

import Foundation
import SwiftData

@Model
class Person {
    var name: String

    init(name: String) {
        self.name = name
    }
}
