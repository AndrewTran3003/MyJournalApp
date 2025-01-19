//
//  HomeView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var state: AppState  // Add environment object

    var body: some View {
        NavigationView {
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
                // Modified NavigationLink code to pass the person data into the QuestionListView
                NavigationLink(
                    destination: QuestionListView(viewModel: QuestionListViewModel(state: state))
                ) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}
