//
//  IosNetworkExampleTests.swift
//  IosNetworkExampleTests
//
//  Created by kanagasabapathy on 01/01/24.
//

import XCTest
@testable import IosNetworkExample
import NetworkKit
import Combine

final class IosNetworkExampleTests: XCTestCase {
    var sut: TodoViewModel!

    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        sut = TodoViewModel(networkService: MockServiceable())
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchTodosAsync() async {
        var todos = await sut.todos
        await sut.makeAsyncAwaitRequest()
        todos = await sut.todos
        XCTAssertGreaterThan(todos.count, 0, "")
        XCTAssertEqual(todos.first?.title, "et labore eos enim rerum consequatur sunt")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            Task {
                await sut.makeAsyncAwaitRequest()
            }
            Task { @MainActor in
                sut.makeCombineRequest()
                sut.makeClosureRequest()
            }
        }
    }

}

final class MockServiceable: Networkable {

    func sendRequest<T>(endpoint: NetworkKit.EndPoint,
                        resultHandler: @escaping (Result<T, NetworkKit.NetworkError>) -> Void) where T: Decodable {
        let todoData = Todo.testTodosData()
        guard let todo = todoData as? T else {
            fatalError("Not TodoData we are expecting")
        }
        print(todo)
        resultHandler(.success(todo))
    }

    func sendRequest<T>(endpoint: NetworkKit.EndPoint,
                        type: T.Type) -> AnyPublisher<T, NetworkKit.NetworkError> where T: Decodable {
        let todoData = Todo.testTodosData()
        guard let todo = todoData as? T else {
            fatalError("Not TodoData we are expecting")
        }
        return Just(todo)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
    func sendRequest<T>(endpoint: EndPoint) async throws -> T where T: Decodable {
        let todoData = Todo.testTodosData()
        guard let todo = todoData as? T else {
            fatalError("Not TodoData we are expecting")
        }
        return todo
    }
}
