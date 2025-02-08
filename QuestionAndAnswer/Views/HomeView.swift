//
//  HomeView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState  // Add environment object
    @State private var isShowingQuestionList = false  // Add state for navigation

    var body: some View {

        NavigationStack {
            VStack {
                List {
                    // Existing code to display the list of people
                    ForEach(state.journalList.journalEntryList) { person in
                        NavigationLink(
                            destination: QuestionListView(
                                viewModel: QuestionListViewModel(
                                    questions: person.questionsAndAnswers.map {
                                        Question(id: $0.id, text: $0.question, answer: $0.answer)
                                    },
                                    journalId: person.id, state: state,
                                    journalEntryName: person.journalEntryName))
                        ) {
                            Text(person.journalEntryName)
                        }
                    }
                }
                Spacer()
                AddButtonView {
                    isShowingQuestionList = true
                }
            }
            .navigationDestination(isPresented: $isShowingQuestionList) {
                QuestionListView(viewModel: QuestionListViewModel(state: state))
            }
            .navigationTitle("Home")
        }
    }
}
