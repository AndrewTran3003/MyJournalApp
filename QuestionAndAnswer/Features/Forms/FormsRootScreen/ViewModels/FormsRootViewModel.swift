//
//  FormsRootViewModel.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 7/10/2025.
//
import SwiftUI

class FormsRootViewModel : ObservableObject {
    @Published private var state: AppState
    init(state: AppState) {
        self.state = state
    }
    
    func addNewDefaultForm(){
        let newForm = Form(formName: Constants.Form.FormName.formNameUntitled, fields: [FormField(fieldName: "Default Field", fieldType: FieldType.singleLineText)])
        state.formList.forms.append(newForm)
        state.formList.activeFormId = newForm.id
    }

}

