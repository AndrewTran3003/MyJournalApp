import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @Binding var newFieldCount: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Field Name")
                    .font(.headline)
                Spacer()
                RemoveButtonView {
                    if newFieldCount > 0 {
                        newFieldCount -= 1
                    }
                }
            }

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
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .frame(maxWidth: min(600, UIScreen.main.bounds.width - 32))
    }
}
