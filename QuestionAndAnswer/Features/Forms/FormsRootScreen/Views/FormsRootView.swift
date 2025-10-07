//
//  DesignFormView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 19/1/2025.
//

import SwiftUI

struct FormsRootView: View {
    
    @ObservedObject var viewModel: FormsRootViewModel

    @EnvironmentObject var state: AppState  // Add environment object
    @State private var navigateToCreateForm = false

    var body: some View {
        NavigationView {
            VStack {
                // This NavigationLink is hidden and is activated programmatically.
                NavigationLink(destination: CreateNewFormView(viewModel: CreateNewFormViewModel(state: state)),
                               isActive: $navigateToCreateForm) { EmptyView() }

                List {
                    ForEach(state.formList.forms) {form in
                        Text(form.formName)
                    }
                    Button(action: {
                        // 1. Create the new form and update the state.
                        viewModel.addNewDefaultForm()
                        // 2. Trigger the navigation.
                        self.navigateToCreateForm = true
                    }) {
                        Text(Constants.Form.createANewFormTitle)
                    }
                }
            }
            .navigationTitle(StringConstants.Navigation.forms)
        }
    }
}
