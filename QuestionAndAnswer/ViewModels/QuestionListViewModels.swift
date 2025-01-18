import SwiftUI
import Combine

class QuestionListViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var journalId: UUID?
    private var state: State

    init(state: State) {
        self.state = state
        loadQuestionsFromJSON()
    }

    init(questions: [Question], journalId: UUID, state: State) {
        self.state = state
        self.questions = questions
        self.journalId = journalId
    }

    func loadQuestionsFromJSON() {
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            questions = try decoder.decode([Question].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func clearInputs(){
        for i in 0..<questions.count {
            questions[i].answer = ""
        }
    }
    
    func extractJournalEntryFromInput () -> JournalEntryState {
        var updateJournalEntry = state.peopleDataList.people.first(where: {$0.id == journalId}) ?? JournalEntryState(id: UUID())
    
        updateJournalEntry.name = Date.now.description
        updateJournalEntry.questionsAndAnswers = questions.map {
            QuestionAndAnswerState(id: UUID(), question: $0.text, answer: $0.answer ?? "")
        }
        return updateJournalEntry
    }

    func saveData() {
        let updatedJournalEntry = extractJournalEntryFromInput()
        state.SaveJournalData(entry: updatedJournalEntry)
        clearInputs()
    }
    
}
