import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        let activeForm = viewModel.getActiveForm()
        if activeForm != nil {
            NavigationView {
                VStack(alignment: .leading) {
                    NewFormNameView(formName: Binding(
                        get: { activeForm!.formName },
                        set: { viewModel.updateFormName($0) }
                    ))
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            NewFieldListView(viewModel: viewModel, formFields: Binding(
                                get: { activeForm?.fields ?? [] },
                                set: { viewModel.updateFields($0) }
                            ))
                            AddNewFieldButtonView(viewModel: viewModel)
                        }
                        .padding()
                    }
                    .background(Color.gray.opacity(0.1))
                }
                .navigationTitle(Constants.Form.createANewFormTitle)
            }
        }
    }
}
