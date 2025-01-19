import SwiftUI

class CreateNewFormViewModel: ObservableObject {
    private var state: AppState

    init(state: AppState) {
        self.state = state
    }

}
