//
//  DesignFormView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 19/1/2025.
//

import SwiftUI

struct FormListView: View {
    @EnvironmentObject var state: AppState  // Add environment object
    @State private var navigateToCreateForm = false

    var body: some View {
        NavigationView {
            VStack {
                // This NavigationLink is hidden and is activated programmatically.
                NavigationLink(destination: CreateNewFormView(viewModel: CreateNewFormViewModel(state: state)),
                               isActive: $navigateToCreateForm) { EmptyView() }

                List {
                    Button(action: {
                        // 1. Create the new form and update the state.
                        let newForm = Form(formName: StringConstants.Form.FormName.formNameUntitled, fields: [FormField(fieldName: "Default Field", fieldType: FieldType.singleLineText)])
                        state.formList.forms.append(newForm)
                        state.formList.activeFormId = newForm.id

                        // 2. Trigger the navigation.
                        self.navigateToCreateForm = true
                    }) {
                        Text(StringConstants.Form.createANewFormTitle)
                    }
                }
            }
            .navigationTitle(StringConstants.Navigation.forms)
        }
    }
}
