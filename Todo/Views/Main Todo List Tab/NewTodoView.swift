import SwiftUI
import SwiftData

struct NewTodoView: View {

    @State private var todoTitle = ""
    @State private var todoSubtitle = ""
    @State private var hasDueDate = false
    @State private var dueDate = Date.now
    @State private var selectedPerson: Person? = nil
    @State private var newPersonName = ""
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Person.name) var people: [Person]
    var nextOrder: Int

    var body: some View {
        Form {
            Section("Info") {
                TextField("Title", text: $todoTitle)
                TextField("Subtitle", text: $todoSubtitle)
            }

            Section("Due Date") {
                Toggle("Set Due Date", isOn: $hasDueDate)
                if hasDueDate {
                    DatePicker("Due", selection: $dueDate, displayedComponents: [.date, .hourAndMinute])
                }
            }

            Section("Delegate To") {
                Picker("Person", selection: $selectedPerson) {
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
                        selectedPerson = person
                        newPersonName = ""
                    }
                    .disabled(newPersonName.isEmpty)
                }
            }

            Section("Actions") {
                Button("Save") {
                    let todo = Todo(
                        title: todoTitle,
                        subtitle: todoSubtitle,
                        order: nextOrder,
                        dueDate: hasDueDate ? dueDate : nil,
                        assignedTo: selectedPerson
                    )
                    modelContext.insert(todo)
                    dismiss()
                }
                .disabled(todoTitle.isEmpty)

                Button("Cancel", role: .destructive) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    NewTodoView(nextOrder: 0)
        .modelContainer(for: [Todo.self, Person.self], inMemory: true)
}
