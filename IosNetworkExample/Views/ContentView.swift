//
//  ContentView.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 01/01/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: TodoViewModel = TodoViewModel()
    var body: some View {
        Text(Constants.title)
            .font(.title)
        Text(Constants.subTitle)
            .font(.subheadline)
        TodoListView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
