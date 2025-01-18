//
//  QuestionAndAnswer.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 17/1/2025.
//

import Foundation

struct QuestionAndAnswerState: Codable, Identifiable {
    let id: UUID
    var question: String
    var answer: String

    init(id: UUID = UUID(), question: String, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
}
