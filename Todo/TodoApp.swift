//
//  TodoApp.swift
//  Todo
//
//  Created by YJ Soon 
//

import SwiftUI
import SwiftData

@main
struct TodoApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Todo.self, Person.self])
    }
}
