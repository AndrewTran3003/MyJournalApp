//
//  NewFieldListView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//
import SwiftUI

struct NewFieldListView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        VStack {
            ForEach(0..<viewModel.fieldCount, id: \.self) { _ in
                NewFieldView(viewModel: viewModel)
            }
            .padding()
        }
    }
}
