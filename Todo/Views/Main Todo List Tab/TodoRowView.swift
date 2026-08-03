//
//  TodoRowView.swift
//  Todo
//
//  Created by YJ Soon 
//


import SwiftUI

struct TodoRowView: View {
    var todo: Todo

    private var dueDateLabel: String? {
        guard let date = todo.dueDate else { return nil }
        let formatted = date.formatted(date: .abbreviated, time: .shortened)
        if !todo.isCompleted && date < .now {
            return "Overdue: \(formatted)"
        }
        return formatted
    }

    var body: some View {
        NavigationLink {
            TodoDetailView(todo: todo)
        } label: {
            HStack {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .onTapGesture {
                        todo.isCompleted.toggle()
                    }
                VStack(alignment: .leading) {
                    Text(todo.title)
                        .strikethrough(todo.isCompleted)
                    if !todo.subtitle.isEmpty {
                        Text(todo.subtitle)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .strikethrough(todo.isCompleted)
                    }
                    if let label = dueDateLabel {
                        Text(label)
                            .font(.caption)
                            .foregroundStyle(todo.isCompleted ? .gray : (todo.dueDate! < .now ? .red : .secondary))
                    }
                    if let person = todo.assignedTo {
                        Text("→ \(person.name)")
                            .font(.caption)
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    let person = Person(name: "Alex")
    let todo = Todo(title: "Feed demo cat", dueDate: .now, assignedTo: person)
    List {
        TodoRowView(todo: todo)
    }
}
