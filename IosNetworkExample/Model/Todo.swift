//
//  Todo.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import Foundation

// MARK: - Todo
struct Todo: Codable, Identifiable {
    let userID, id: Int
    let title: String
    var completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

typealias Todos = [Todo]

extension Todo {
    static func testTodoData() -> Todo {
        Todo(userID: 1, id: 1, title: "et labore eos enim rerum consequatur sunt", completed: true)
    }
    static func testTodosData() -> Todos {
        [
            Todo(userID: 1, id: 1, title: "et labore eos enim rerum consequatur sunt", completed: true),
            Todo(userID: 2, id: 2, title: "suscipit repellat esse quibusdam voluptatem incidunt", completed: false)
        ]
    }
}
