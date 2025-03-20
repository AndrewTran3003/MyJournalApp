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
                        Text(StringConstants.Form.createANewFormTitle)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        let newForm = Form(formName: StringConstants.Form.FormName.formNameUntitled, fields: [FormField(fieldName: "Default Field", fieldType: FieldType.singleLineText)])
                        state.formList.forms.append(newForm)
                        state.formList.activeFormId = newForm.id
                    })
                }
            }
            .navigationTitle(StringConstants.Navigation.forms)
        }
    }
}
