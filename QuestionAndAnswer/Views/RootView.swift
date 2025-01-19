//
//  RootView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var state = State()  // Create the state object

    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(state) // Inject into HomeView
            FormListView()
                .tabItem {
                    Label("Forms", systemImage: "folder")
                }
                .environmentObject(state)
            Text("Coming Soon")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(state)
        .background(Color.white)

    }
}
