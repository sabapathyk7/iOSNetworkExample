//
//  TodoViewModel.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import Combine
import Foundation
import NetworkKit

enum RequestVariant {
    case combineFRP
    case asyncAwait
    case escapingClosure
}

@MainActor
final class TodoViewModel: ObservableObject {
    @Published var todos: Todos = Todos()
    @Published var todosError: String = String()
    private var cancellables = Set<AnyCancellable>()
    private var networkService: Networkable
    init(networkService: Networkable = NetworkService() ) {
        self.networkService = networkService
        networkSelection()
    }
    func networkSelection() {
        print("Executed")
        networkSelection(variant: .escapingClosure)
    }
}

extension TodoViewModel {
    func networkSelection(variant: RequestVariant) {
        switch variant {
        case .asyncAwait:
            Task(priority: .background) {
                await makeAsyncAwaitRequest()
            }
        case .combineFRP:
            makeCombineRequest()
        case .escapingClosure:
            makeClosureRequest()
        }
    }

    func makeAsyncAwaitRequest() async {
        do {
            let todoData = try await networkService.sendRequest(endpoint: TodoEndPoint.todo) as Todos
            if todoData.isNotEmpty {
                todos = todoData
            }
        } catch {
            guard let error = error as? NetworkError else {
                return
            }
            todosError = error.debugDescription
        }
    }

    func makeCombineRequest() {
        networkService.sendRequest(endpoint: TodoEndPoint.todo, type: Todos.self)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("Finished")
                case .failure(let error):
                    self?.todosError = error.debugDescription
                }
            } receiveValue: { [weak self] todoData in
                self?.todos = todoData
            }
            .store(in: &cancellables)
    }

    func makeClosureRequest() {
        networkService.sendRequest(endpoint: TodoEndPoint.todo) { (response: Result<Todos, NetworkError>) in
            switch response {
            case .success(let todoData):
                DispatchQueue.main.async {
                    self.todos = todoData
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.todosError = error.debugDescription
                }
            }
        }
    }
}
