import SwiftUI

struct QuestionListView: View {
    @ObservedObject var viewModel: QuestionListViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background wallpaper
                Image(uiImage:#imageLiteral(resourceName: "pexels-scottwebb-1029604.jpg"))
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                
                // Content wrapper
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
                                    .frame(height: 100)
                                    .border(Color.gray.opacity(0.2))
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: CGFloat(viewModel.questions.count * 120))
                    
                    Button("Save") {
                        viewModel.saveData()
                    }
                    .padding()
                }
                .frame(maxWidth: min(600, UIScreen.main.bounds.width - 32))
                .background(Color.white.opacity(0.9))
                .cornerRadius(15)
                .shadow(radius: 10)
                .padding()
                .ignoresSafeArea(.keyboard)
                .position(x: geometry.size.width/2, y: geometry.size.height/2) // Center the content
            }
        }
        .ignoresSafeArea(.keyboard)
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
