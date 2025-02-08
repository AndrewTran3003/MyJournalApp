import SwiftUI

class CreateNewFormViewModel: ObservableObject {
    private var state: AppState
    
    // Add the new published properties
    @Published var formName: String = ""
    @Published var title: String = ""
    
    enum FieldType: String, CaseIterable {
        case singleLineText = "Single Line Text"
        case multiLineText = "Multi Line Text"
        case radioSelection = "Radio Selection"
        case multiSelection = "Multi Selection"
    }
    
    @Published var selectedFieldType: FieldType = .singleLineText

    init(state: AppState) {
        self.state = state
    }
}
