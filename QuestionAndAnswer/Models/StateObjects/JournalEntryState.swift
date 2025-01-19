//
//  JournalEntry.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 17/1/2025.
//

import Foundation

struct JournalEntryState: Codable, Identifiable {
    let id: UUID  // Add unique ID
    var journalEntryName: String = ""
    var questionsAndAnswers: [QuestionAndAnswerState] = []

    init(id: UUID = UUID()) {
        self.id = id
    }
    // Add an initializer
    init(id: UUID = UUID(), name: String, questionsAndAnswers: [QuestionAndAnswerState]) {
        self.id = id
        self.journalEntryName = name
        self.questionsAndAnswers = questionsAndAnswers
    }
}
