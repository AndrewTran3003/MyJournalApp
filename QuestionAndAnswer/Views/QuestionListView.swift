import SwiftUI

struct QuestionListView: View {
    @ObservedObject var viewModel: QuestionListViewModel

    var body: some View {
        ZStack {
            // Background wallpaper - fixed position
            Image(uiImage: #imageLiteral(resourceName: "pexels-scottwebb-1029604.jpg"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
                .clipped()

            // Content wrapper
            GeometryReader { geometry in
                VStack {
                    Text("Journal Entry")
                        .font(.title)
                        .padding(.top)

                    TextField("New Journal Entry", text: $viewModel.journalName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    ScrollView {
                        List {
                            ForEach($viewModel.questions) { $question in
                                VStack(alignment: .leading) {
                                    Text(question.text)
                                        .font(.headline)
                                    TextEditor(text: $question.answer.toNonOptionalString())
                                        .frame(height: 100)
                                        .border(Color.gray.opacity(0.2))
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: CGFloat(viewModel.questions.count * 120))
                    }
                    .ignoresSafeArea(.keyboard, edges: .bottom)

                    SaveButtonView {
                        viewModel.saveData()
                    }
                    .padding()
                }
                .frame(maxWidth: min(600, UIScreen.main.bounds.width - 32))
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        .background(Color.white)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil)
                }
            }
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
