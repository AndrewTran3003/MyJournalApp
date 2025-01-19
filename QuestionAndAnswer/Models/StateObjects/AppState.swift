import Foundation


class AppState: ObservableObject {
    @Published var peopleDataList: JournalListState

    init(peopleDataList: JournalListState = JournalListState()) {
        self.peopleDataList = peopleDataList
    }
    
    func SaveJournalData(entry : JournalEntryState) {
        if let index = peopleDataList.people.firstIndex(where: { $0.id == entry.id}) {
            peopleDataList.people[index] = entry
        }
        else {
            peopleDataList.people.append(entry)
        }
        objectWillChange.send()
    }
}
