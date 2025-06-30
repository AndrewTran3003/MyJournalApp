//
//  QuestionAndAnswerApp.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//

import SwiftUI

@main
struct QuestionAndAnswerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
