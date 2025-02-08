//
//  NewFormNameView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//

import SwiftUI

struct NewFormNameView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        Text("Form name")
            .font(.headline)
            .padding(.top)
            .frame(maxWidth: .infinity, alignment: .leading)
        TextField("Enter form name here", text: $viewModel.formName)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
    }
}
