//
//  FieldListView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//
import SwiftUI

struct FieldListView: View {
    @ObservedObject var viewModel: FormViewerViewModel
    
    @Binding var formFields : [FormField]
    
    var body: some View {
        VStack {
            ForEach(Array(formFields.enumerated()), id: \.element.id) { index, field in
                    FieldView(
                        viewModel: viewModel,
                        field: Binding(
                            get: { formFields[index] },
                            set: { formFields[index] = $0 }
                        ),
                        index: index
                    )
                }
            
        }
    }
}
