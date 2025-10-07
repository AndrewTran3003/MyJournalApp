import SwiftUI

struct NewFieldView: View {
    @ObservedObject var viewModel: CreateNewFormViewModel
    @Binding var field: FormField
    let index: Int
    @State private var selectedFieldType: FieldType = FieldType.singleLineText

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    Text(StringConstants.Form.Field.fieldNameLabel)
                        .font(.headline)
                    Spacer()
                    RemoveButton {
                        viewModel.removeField(at: index)
                    }
                }

                TextField(StringConstants.Form.Field.fieldNamePlaceholder, text: $field.fieldName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Text(StringConstants.Form.Field.fieldTypeLabel)
                    .font(.headline)

                Picker(StringConstants.Form.Field.fieldTypePickerLabel, selection: $field.fieldType) {
                    ForEach(FieldType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .accessibilityIdentifier(StringConstants.Form.Field.fieldTypePickerIdentifier)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .frame(maxWidth: min(600, geometry.size.width - 32))
        }
    }
}
