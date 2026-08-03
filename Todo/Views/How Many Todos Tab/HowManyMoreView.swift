//
//  HowManyMoreview.swift
//  Todo
//
//  Created by YJ Soon 
//

import SwiftUI
import SwiftData

struct HowManyMoreView: View {

    @Query var todos: [Todo]

    var numTodosLeft: Int {
        todos.filter { !$0.isCompleted }.count
    }

    var numTodosDone: Int {
        todos.filter { $0.isCompleted }.count
    }

    var body: some View {
        VStack {
            Text("You have:")
                .font(.largeTitle)
            Text("\(numTodosLeft)")
                .font(.system(size: 140))
                .foregroundStyle(.blue)
                .padding()
            Text(numTodosLeft == 1 ? "todo left.": "todos left.")
                .font(.largeTitle)
            Text("You have completed ^[\(numTodosDone) todos](inflect: true). Good job.")
                .padding(.top)
        }

    }
}

#Preview {
    HowManyMoreView()
        .modelContainer(for: Todo.self, inMemory: true)
}
