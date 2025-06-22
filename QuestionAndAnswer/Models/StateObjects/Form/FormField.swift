import Foundation

struct FormField: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    var fieldName: String
    var fieldType: FieldType

    static func == (lhs: FormField, rhs: FormField) -> Bool {
        return lhs.id == rhs.id && lhs.fieldName == rhs.fieldName && lhs.fieldType == rhs.fieldType
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(fieldName)
        hasher.combine(fieldType)
    }
    init (fieldName: String, fieldType: FieldType) {
        self.id = UUID()
        self.fieldName = fieldName
        self.fieldType = fieldType
    }
}
