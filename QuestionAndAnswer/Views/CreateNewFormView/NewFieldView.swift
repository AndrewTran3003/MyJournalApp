import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel

    var body: some View {

        VStack(alignment: .leading) {
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
