import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @Binding var field: FormField
    let index: Int
    @State private var selectedFieldType: FieldType = FieldType.singleLineText

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Constants.Form.Field.fieldNameLabel)
                    .font(.headline)
                Spacer()
                RemoveButton {
                    viewModel.removeField(at: index)
                }
            }

            TextField(Constants.Form.Field.fieldNamePlaceholder, text: $field.fieldName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Text(Constants.Form.Field.fieldTypeLabel)
                .font(.headline)

            Picker(Constants.Form.Field.fieldTypePickerLabel, selection: $field.fieldType) {
                ForEach(FieldType.allCases, id: \.self) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .accessibilityIdentifier(Constants.Form.Field.fieldTypePickerIdentifier)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .frame(maxWidth: 600)
    }
}
