import SwiftUI

class FormViewerViewModel: ObservableObject {
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
    
    // Generic form update method
    func updateForm(_ update: (inout Form) -> Void) {
        if var activeForm = getActiveForm() {
            update(&activeForm)
            state.formList.UpdateActiveForm(form: activeForm)
        }
    }
    
    // Convenience methods for common operations
    func updateFormName(_ name: String) {
        updateForm { $0.formName = name }
    }
    
    func updateFields(_ fields: [FormField]) {
        updateForm { $0.fields = fields }
    }
    // Remove field
    func removeField(at index: Int) {
        updateForm { $0.fields.remove(at: index) }
    }
    
    // Helper to update form in state
    func updateForm(_ updatedForm: Form) {
        if let index = state.formList.forms.firstIndex(where: { $0.id == updatedForm.id }) {
            state.formList.forms[index] = updatedForm
        }
    }
}
