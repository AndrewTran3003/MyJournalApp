import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    @EnvironmentObject var state: AppState  // Add environment object

    var body: some View {
        NavigationView {
            VStack {
                Text("Create a new form")
                    .font(.title)
                    .padding(.top)
                Text("Under development :)")
                    .font(.title)
                    .padding(.top)
            }
            .navigationTitle("Forms")
        }
    }
}
