//
//  MainTodoListView.swift
//  Todo
//
//  Created by YJ Soon 
//

import SwiftUI
import SwiftData

struct MainTodoListView: View {

    @Query(sort: \Todo.order) var todos: [Todo]
    @Environment(\.modelContext) private var modelContext
    @State private var showConfirmAlert = false
    @State private var showAddSheet = false
    @State private var searchTerm = ""

    var body: some View {

        NavigationStack {
            List {
                ForEach(todos) { todo in
                    TodoRowView(todo: todo)
                }
                .onDelete(perform: deleteTodos)
                .onMove(perform: moveTodos)
            }
            .searchable(text: $searchTerm)
            .navigationTitle("Todos")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
#if DEBUG
                    Button {
                        showConfirmAlert = true
                    } label: {
                        Image(systemName: "list.bullet.clipboard.fill")
                    }
#endif

                    Button {
                        showAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .sheet(isPresented: $showAddSheet) {
                NewTodoView(nextOrder: todos.count)
                    .presentationDetents([.medium])
            }
            .alert("Load sample data? Warning: This cannot be undone!", isPresented: $showConfirmAlert) {
                Button("Replace", role: .destructive, action: loadSampleData)
            }

        }

    }

    private func deleteTodos(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(todos[offset])
        }
    }

    private func moveTodos(from source: IndexSet, to destination: Int) {
        var reordered = todos
        reordered.move(fromOffsets: source, toOffset: destination)
        for (index, todo) in reordered.enumerated() {
            todo.order = index
        }
    }

    private func loadSampleData() {
        for todo in todos {
            modelContext.delete(todo)
        }
        for sample in Todo.sampleTodos {
            modelContext.insert(sample)
        }
    }

}

#Preview {
    MainTodoListView()
        .modelContainer(for: Todo.self, inMemory: true)
}
