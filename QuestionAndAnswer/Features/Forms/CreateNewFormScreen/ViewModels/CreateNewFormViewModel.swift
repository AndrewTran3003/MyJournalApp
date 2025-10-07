import SwiftUI

class CreateNewFormViewModel: ObservableObject {
    @Published private var state: AppState
    
    init(state: AppState) {
        self.state = state
    }
    
    // Get active form
    func getActiveForm() -> Form? {
        return state.formList.forms.first { $0.id == state.formList.activeFormId }
    }
    
    // Add new field
    func addNewField() {
        if var activeForm = getActiveForm() {
            let newField = FormField(fieldName: "", fieldType: .singleLineText)
            activeForm.fields.append(newField)
            updateForm(activeForm)
        }
    }
    
    // Update field name
    func updateFieldName(at index: Int, name: String) {
        if var activeForm = getActiveForm() {
            activeForm.fields[index].fieldName = name
            updateForm(activeForm)
        }
    }
    
    // Update field type
    func updateFieldType(at index: Int, type: FieldType) {
        if var activeForm = getActiveForm() {
            activeForm.fields[index].fieldType = type
            updateForm(activeForm)
        }
    }
    
    func updateFields (fields: [FormField]) {
        if var activeForm = getActiveForm() {
            activeForm.fields = fields
            updateForm(activeForm)
        }
    }
    
    func updateFormName(formName: String){
        if var activeForm = getActiveForm() {
            activeForm.formName = formName
            updateForm(activeForm)
        }
    }
    // Remove field
    func removeField(at index: Int) {
        if var activeForm = getActiveForm() {
            activeForm.fields.remove(at: index)
            updateForm(activeForm)
        }
    }
    
    // Helper to update form in state
    func updateForm(_ updatedForm: Form) {
        if let index = state.formList.forms.firstIndex(where: { $0.id == updatedForm.id }) {
            state.formList.forms[index] = updatedForm
        }
    }
}
