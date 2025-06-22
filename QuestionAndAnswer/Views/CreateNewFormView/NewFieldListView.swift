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
            if var activeForm = viewModel.getActiveForm() {
                let fieldsBinding = Binding(
                    get: { activeForm.fields },
                    set: { newFields in
                        activeForm.fields = newFields
                        viewModel.updateForm(activeForm)
                    }
                )
                
                ForEach(Array(activeForm.fields.enumerated()), id: \.element.id) { index, field in
                    NewFieldView(
                        viewModel: viewModel,
                        field: fieldsBinding[index],
                        index: index
                    )
                }
            }
        }
    }
}
