//
//  AddNewFieldButtonView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//
import SwiftUI

struct AddNewFieldButtonView: View {
    @ObservedObject var viewModel: FormViewerViewModel

    var body: some View {
        HStack {
            Spacer()
            AddButton {
                viewModel.addNewField()
            }
            Spacer()
        }
    }
}
