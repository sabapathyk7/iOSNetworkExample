//
//  TodoEndPoint.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import Foundation
import NetworkKit

enum TodoEndPoint {
    case todo
}

extension TodoEndPoint: EndPoint {
    var host: String {
       return "jsonplaceholder.typicode.com"
    }

    var scheme: String {
        return "https"
    }

    var path: String {
        return "/todos"
    }

    var method: NetworkKit.RequestMethod {
        switch self {
        case .todo:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .todo:
            return nil
        }
    }

    var body: [String: String]? {
        switch self {
        case .todo:
            return nil
        }
    }
}

extension NetworkError: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        default:
            return "Unknown Error"
        }
    }
}
