//
//  DesignFormView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 19/1/2025.
//

import SwiftUI

struct FormListView: View {
    @EnvironmentObject var state: AppState  // Add environment object

    var body: some View {
        NavigationView {
            VStack {

                List {
                    NavigationLink(
                        destination: CreateNewFormView(
                            viewModel: CreateNewFormViewModel(state: state))
                    ) {
                        Text("Create a new form")
                    }
                }
            }
            .navigationTitle("Forms")
        }
    }
}
