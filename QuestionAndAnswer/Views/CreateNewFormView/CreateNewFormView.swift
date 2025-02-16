import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NewFormNameView(viewModel: viewModel)
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
