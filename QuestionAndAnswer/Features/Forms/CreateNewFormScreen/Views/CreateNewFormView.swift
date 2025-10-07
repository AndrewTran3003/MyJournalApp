import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        let activeForm = viewModel.getActiveForm()
        if activeForm != nil {
            NavigationView {
                VStack(alignment: .leading) {
                    NewFormNameView(form: Binding(
                        get: { activeForm! },
                        set: { _ in }  // Handle form name updates in NewFormNameView
                    ))
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            NewFieldListView(viewModel: viewModel)
                            AddNewFieldButtonView(viewModel: viewModel)
                        }
                        .padding()
                    }
                    .background(Color.gray.opacity(0.1))
                    SaveButton()
                }
                .navigationTitle(Constants.Form.createANewFormTitle)
            }
        }
    }
}
