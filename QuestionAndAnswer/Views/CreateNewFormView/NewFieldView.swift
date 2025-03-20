import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @Binding var field: FormField
    let index: Int
    @State private var selectedFieldType: FieldType = FieldType.singleLineText

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Field Name")
                    .font(.headline)
                Spacer()
                RemoveButton {
                    viewModel.removeField(at: index)
                }
            }

            TextField("Enter the field name here", text: $field.fieldName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text("Field Type")
                .font(.headline)

            Picker("Pick field type", selection: $field.fieldType) {
                ForEach(FieldType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accessibilityIdentifier("fieldTypePicker")  // Add this line
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .frame(maxWidth: min(600, UIScreen.main.bounds.width - 32))
    }
}
