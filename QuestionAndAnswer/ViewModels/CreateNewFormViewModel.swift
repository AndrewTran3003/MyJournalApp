import SwiftUI

class CreateNewFormViewModel: ObservableObject {
    private var state: AppState

    // Add the new published properties
    @Published var formName: String = ""
    @Published var title: String = ""
    @Published var fieldCount = 1

    @Published var selectedFieldType: FieldType = .singleLineText

    init(state: AppState) {
        self.state = state
    }

    func increaseFieldCount() {
        fieldCount += 1
    }

    func decreaseFieldCount() {
        if fieldCount > 0 {
            fieldCount -= 1
        }
    }
}
