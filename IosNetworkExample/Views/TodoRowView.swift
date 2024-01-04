//
//  TodoRowView.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import SwiftUI

struct TodoRowView: View {
    @State private var todo: Todo
    init(todo: Todo) {
        self.todo = todo
    }
    var body: some View {
        HStack {
            Toggle(isOn: $todo.completed) {
                Text(todo.title)
            }
            .toggleStyle(CheckboxiOSToggleStyle())
        }
    }
}

#Preview {
    TodoRowView(todo: Todo.testTodoData())
}
