import SwiftUI

struct CreateNewFormView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Form name")
                    .font(.headline)
                    .padding(.top)
                    .frame(maxWidth: .infinity, alignment: .leading)
                TextField("Enter form name here", text: $viewModel.formName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                ScrollView{
                    VStack (alignment: .leading) {
                        Text("Field Name")
                            .font(.headline)
                        TextField("Enter the field name here", text: $viewModel.title)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        Text("Field Type")
                            .font(.headline)
                        Picker("", selection: $viewModel.selectedFieldType) {
                            ForEach(CreateNewFormViewModel.FieldType.allCases, id: \.self) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .padding()
            .navigationTitle("Create a new form")
        }
    }
}
