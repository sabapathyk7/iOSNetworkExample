# iOSNetworkExample

iOSNetworkExample is a sample iOS application that demonstrates the usage of the NetworkKit Swift package. This example app showcases how to leverage the power of Combine, Async-await, and Escaping Closures provided by NetworkKit to simplify and enhance your networking code in iOS projects.

The full Tutorial can be found on [Medium](https://sabapathy7.medium.com/how-to-create-a-network-layer-for-your-ios-app-623f99161677)

<img src= "https://github.com/sabapathyk7/iOSNetworkExample/assets/40764138/bb122350-c5a1-47b2-84fa-8d8ba49d60ac" height = 550> 


## Features

- 📡 **Networking with NetworkKit:** Explore the usage of NetworkKit for handling network requests.
- 🔄 **Combine Framework:** Understand how Combine is integrated to manage asynchronous operations.
- ⚡ **Async-await:** Experience the benefits of writing asynchronous code using Swift's async-await feature.
- 🔄 **Escaping Closures:** Learn how to use escaping closures for customizing callback behavior.

## Getting Started

To run the iOSNetworkExample project, follow these steps:

Clone the repository and open iOSNetworkExample.xcodeproj

## Examples

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

### Installation

Simply add NetworkKit to your project using Swift Package Manager - https://github.com/sabapathyk7/NetworkKit.git

## Connect with Me

Stay updated on the latest features and releases by following me on [LinkedIn](https://www.linkedin.com/in/sabapathy7/) and [Medium](https://sabapathy7.medium.com/) 


    
