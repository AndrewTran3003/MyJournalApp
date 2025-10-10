import SwiftUI

struct FormViewerView: View {
    @ObservedObject var viewModel: FormViewerViewModel

    var body: some View {
        let activeForm = viewModel.getActiveForm()
        if activeForm != nil {
            NavigationView {
                VStack(alignment: .leading) {
                    FormNameView(formName: Binding(
                        get: { activeForm!.formName },
                        set: { viewModel.updateFormName($0) }
                    ))
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            FieldListView(viewModel: viewModel, formFields: Binding(
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
