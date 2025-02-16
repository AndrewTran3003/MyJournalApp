import Foundation

struct FormField: Codable, Identifiable {
    let id: UUID
    var fieldName: String
    var fieldType: FieldType

    init (fieldName: String, fieldType: FieldType) {
        self.id = UUID()
        self.fieldName = fieldName
        self.fieldType = fieldType
    }
}
