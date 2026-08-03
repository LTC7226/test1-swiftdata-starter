//
//  ContentView.swift
//  Todo
//
//  Created by YJ Soon 
//

import SwiftUI
import SwiftData

struct ContentView: View {
        
    var body: some View {
        TabView {
            Tab("Todos", systemImage: "list.bullet") {
                MainTodoListView()
            }
            
            Tab("Remaining" , systemImage: "checkmark.circle") {
                HowManyMoreView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Todo.self, inMemory: true)
}
