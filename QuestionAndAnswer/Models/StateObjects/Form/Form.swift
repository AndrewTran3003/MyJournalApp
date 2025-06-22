//
//  Form.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/2/2025.
//
import Foundation

struct Form: Codable, Identifiable, Equatable, Hashable, Observable {
    static func == (lhs: Form, rhs: Form) -> Bool {
        return lhs.id == rhs.id && lhs.formName == rhs.formName && lhs.fields == rhs.fields
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(formName)
    }
    let id: UUID
    var formName: String
    var fields: [FormField]

    init(formName: String, fields : [FormField] = []) {
        self.id = UUID()
        self.formName = formName
        self.fields = fields
    }
}
