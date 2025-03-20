import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        if let activeForm = viewModel.getActiveForm() {
            NavigationView {
                VStack(alignment: .leading) {
                    NewFormNameView(form: Binding(
                        get: { activeForm },
                        set: { _ in }  // Handle form name updates in NewFormNameView
                    ))
                    ScrollView {
                        NewFieldListView(viewModel: viewModel)
                        AddNewFieldButtonView(viewModel: viewModel)
                    }
                    .background(Color.gray.opacity(0.1))
                    SaveButton()
                }
                .navigationTitle("Create a new form")
            }
        }
    }
}
