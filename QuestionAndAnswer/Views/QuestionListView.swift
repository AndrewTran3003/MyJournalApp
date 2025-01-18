import SwiftUI

struct QuestionListView: View {
    @ObservedObject var viewModel: QuestionListViewModel

    var body: some View {
        VStack {
            Text("Journal Entry")
                .font(.title)
                .padding(.top)
            
            TextField("New Journal Entry", text: $viewModel.journalName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List {
                ForEach($viewModel.questions) { $question in
                    VStack(alignment: .leading) {
                        Text(question.text)
                            .font(.headline)
                        TextEditor(text: $question.answer.toNonOptionalString())
                            .frame(height: 100)  // Set a specific height for the editor
                            .border(Color.gray.opacity(0.2))  // Add a subtle border
                    }
                }
            }
            
            Button("Save") {
                viewModel.saveData()
            }
            .padding()
        }
    }
}


extension Binding {
    // Binding transform to handle optionals in TextField
    func toNonOptionalString() -> Binding<String> where Value == String? {
        Binding<String>(
            get: { self.wrappedValue ?? "" },
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 }
        )
    }
}
