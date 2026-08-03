//
//  Todo+Sample.swift
//  Todo
//
//  Created by YJ Soon 
//

extension Todo {

    static var sampleTodos: [Todo] {
        [
            Todo(title: "Feed the cat", isCompleted: true, order: 0),
            Todo(title: "Play with cat", subtitle: "Use his favourite String!", order: 1),
            Todo(title: "Get allergies", order: 2),
            Todo(title: "Run away from cat", order: 3),
            Todo(title: "Get a new cat", order: 4)
        ]
    }

}
