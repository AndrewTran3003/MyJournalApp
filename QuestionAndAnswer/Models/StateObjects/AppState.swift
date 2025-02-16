import Foundation

class AppState: ObservableObject {
    @Published var journalList: JournalListState
    

    init(peopleDataList: JournalListState = JournalListState()) {
        self.journalList = peopleDataList
    }

    func SaveJournalData(entry: JournalEntryState) {
        if let index = journalList.journalEntryList.firstIndex(where: { $0.id == entry.id }) {
            journalList.journalEntryList[index] = entry
        } else {
            journalList.journalEntryList.append(entry)
        }
        objectWillChange.send()
    }
}
