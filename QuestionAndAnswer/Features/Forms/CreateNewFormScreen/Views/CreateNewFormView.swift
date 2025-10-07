import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        var activeForm = viewModel.getActiveForm()
        if activeForm != nil {
            NavigationView {
                VStack(alignment: .leading) {
                    NewFormNameView(formName: Binding(
                        get: { activeForm!.formName },
                        set: { formName in
                            viewModel.updateFormName(formName: formName)
                        }
                    ))
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            NewFieldListView(viewModel: viewModel)
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
