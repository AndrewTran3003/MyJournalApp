import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @State private var fieldName: String = ""
    @State private var selectedFieldType: FieldType = .singleLineText
    @Binding var newFieldCount: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Field Name")
                    .font(.headline)
                Spacer()
                RemoveButton {
                    if newFieldCount > 0 {
                        newFieldCount -= 1
                    }
                }
            }

            TextField("Enter the field name here", text: $fieldName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Field Type")
                .font(.headline)

            Picker("", selection: $selectedFieldType) {
                ForEach(FieldType.allCases, id: \.self) { type in
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
