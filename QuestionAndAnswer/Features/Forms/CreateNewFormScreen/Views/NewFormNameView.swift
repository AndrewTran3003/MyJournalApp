//
//  NewFormNameView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//

import SwiftUI

struct NewFormNameView: View {
    @Binding var form: Form

    var body: some View {
        VStack {
            Text(Constants.Form.FormName.formNameLabel)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField(Constants.Form.FormName.formNamePlaceholder, text: $form.formName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()

    }
}
