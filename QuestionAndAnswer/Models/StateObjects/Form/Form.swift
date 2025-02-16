//
//  Form.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/2/2025.
//
import Foundation

struct Form: Codable, Identifiable {
    let id: UUID
    var formName: String
    var fields: [FormField]

    init(formName: String) {
        self.id = UUID()
        self.formName = formName
        self.fields = []
    }
}
