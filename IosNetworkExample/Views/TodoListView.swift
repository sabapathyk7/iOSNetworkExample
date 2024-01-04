//
//  TodoListView.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import SwiftUI

struct TodoListView: View {
    @ObservedObject var viewModel: TodoViewModel
    @State private var showError = false
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.todos, id: \.id) { todo in
                    TodoRowView(todo: todo)
                }
            }
            .listStyle(.plain)
            .overlay {
                if showError && viewModel.todosError.isNotEmpty {
                    VStack {
                        ErrorView(errorTitle: viewModel.todosError, todoViewModel: viewModel)
                        Spacer()
                    }.transition(.move(edge: .top))
                }
            } .transition(.move(edge: .top))
        }
        .animation(.default, value: viewModel.todosError)
        .task {
            try? await Task.sleep(for: .seconds(30))
            showError.toggle()
            viewModel.networkSelection()
        }
        .onChange(of: viewModel.todosError) { _, newValue in
            showError = newValue.isNotEmpty
        }
    }
}

#Preview {
    TodoListView(viewModel: TodoViewModel())
}
