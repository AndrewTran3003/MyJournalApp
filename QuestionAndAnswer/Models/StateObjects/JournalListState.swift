//
//  JournalList.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 17/1/2025.
//
import Foundation

class JournalListState: ObservableObject {
    @Published var people: [JournalEntryState] = []
    
    init() {}
}
