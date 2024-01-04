//
//  ErrorView.swift
//  IosNetworkExample
//
//  Created by kanagasabapathy on 04/01/24.
//

import SwiftUI

struct ErrorView: View {
    let errorTitle: String?
    @ObservedObject var todoViewModel: TodoViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(.blue)
            .frame(height: 200)
            .padding()
            .overlay {
                VStack {
                    Text(errorTitle ?? "")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    Button(Constants.reloadList) {
                        Task {
                            todoViewModel.networkSelection()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
    }
}

#Preview {
    ErrorView(errorTitle: "invalidURL", todoViewModel: TodoViewModel())
}
