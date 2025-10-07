//
//  RootView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var state = AppState()  // Create the state object

    var body: some View {

        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .environmentObject(state)  // Inject into HomeView
            FormsRootView(viewModel: FormsRootViewModel(state: state))
                .tabItem {
                    Label("Forms", systemImage: "folder")
                }
                .environmentObject(state)
            ChatRootView()
                .tabItem {
                    Label("Chat", systemImage: "bubble.left.and.bubble.right")
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
