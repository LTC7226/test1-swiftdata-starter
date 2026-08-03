//
//  TodoDetailView.swift
//  Todo
//
//  Created by YJ Soon 
//

import SwiftUI
import SwiftData

struct TodoDetailView: View {

    @Bindable var todo: Todo
    @State private var hasDueDate: Bool
    @State private var newPersonName = ""
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Person.name) var people: [Person]

    init(todo: Todo) {
        self.todo = todo
        _hasDueDate = State(initialValue: todo.dueDate != nil)
    }

    var body: some View {
        Form {
            Section("Info") {
                TextField("Title", text: $todo.title)
                TextField("Subtitle", text: $todo.subtitle)
                    .foregroundStyle(.gray)
                Toggle("Completed?", isOn: $todo.isCompleted)
            }

            Section("Due Date") {
                Toggle("Set Due Date", isOn: $hasDueDate)
                    .onChange(of: hasDueDate) { _, enabled in
                        todo.dueDate = enabled ? (todo.dueDate ?? .now) : nil
                    }
                if hasDueDate, let dueDate = Binding($todo.dueDate) {
                    DatePicker("Due", selection: dueDate, displayedComponents: [.date, .hourAndMinute])
                }
            }

            Section("Delegate To") {
                Picker("Person", selection: $todo.assignedTo) {
                    Text("Nobody").tag(Optional<Person>.none)
                    ForEach(people) { person in
                        Text(person.name).tag(Optional(person))
                    }
                }
                HStack {
                    TextField("Add new person…", text: $newPersonName)
                    Button("Add") {
                        let person = Person(name: newPersonName)
                        modelContext.insert(person)
                        todo.assignedTo = person
                        newPersonName = ""
                    }
                    .disabled(newPersonName.isEmpty)
                }
            }
        }
        .navigationTitle("Todo Detail")
    }
}

#Preview {
    let todo = Todo(title: "Feed demo cat")
    TodoDetailView(todo: todo)
        .modelContainer(for: [Todo.self, Person.self], inMemory: true)
}
