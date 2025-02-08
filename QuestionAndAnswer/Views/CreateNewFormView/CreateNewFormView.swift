import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NewFormNameView(viewModel: viewModel)
                NewFieldListView(viewModel: viewModel)
            }
            .padding()
            .navigationTitle("Create a new form")
        }
    }
}
