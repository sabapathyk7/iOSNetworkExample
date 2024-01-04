//
//  Constants.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import Foundation

extension Collection {
    var isEmpty: Bool { startIndex == endIndex }
    var isNotEmpty: Bool { !isEmpty }
}

enum Constants {
    static let title = "iOS Network Example"
    static let subTitle = "Todos"
    static let reloadList = "Reload List"
}
