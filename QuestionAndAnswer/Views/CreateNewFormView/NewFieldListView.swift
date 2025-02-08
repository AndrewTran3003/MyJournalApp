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
        ScrollView{
            NewFieldView(viewModel: viewModel)
            AddButtonView()
        }
    }
}
