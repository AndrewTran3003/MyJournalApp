import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        let activeForm = viewModel.getActiveForm()
        let _ = print(activeForm?.id)
        if activeForm != nil {
            NavigationView {
                VStack(alignment: .leading) {
                    NewFormNameView(form: Binding(
                        get: { activeForm! },
                        set: { _ in }  // Handle form name updates in NewFormNameView
                    ))
                    ScrollView {
                        NewFieldListView(viewModel: viewModel)
                        AddNewFieldButtonView(viewModel: viewModel)
                    }
                    .background(Color.gray.opacity(0.1))
                    SaveButton()
                }
                .navigationTitle(StringConstants.Form.createANewFormTitle)
            }
        }
    }
}
