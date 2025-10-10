//
//  FormNameView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//

import SwiftUI

struct FormNameView: View {
    @Binding var formName: String
    

    var body: some View {
        VStack {
            Text(Constants.Form.FormName.formNameLabel)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.Form.FormName.formNamePlaceholder, text: $formName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()

    }
}
