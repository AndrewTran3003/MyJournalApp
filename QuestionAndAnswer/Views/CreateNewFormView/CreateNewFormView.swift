import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @EnvironmentObject var state: AppState
    @State private var newFieldCount = 0

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NewFormNameView(viewModel: viewModel)
                ScrollView {
                    NewFieldListView(viewModel: viewModel, newFieldCount: self.$newFieldCount)
                    AddNewFieldButtonView(newFieldCount: self.$newFieldCount)
                }
                SaveButtonView()
            }
            .padding()
            .navigationTitle("Create a new form")
        }
    }
}
