//
//  DesignFormView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 19/1/2025.
//

import SwiftUI

struct FormListView: View {
    @EnvironmentObject var state: AppState // Add environment object

    var body: some View {
        NavigationView{
            VStack{
                Text("All Forms created will be displayed here")
                    .font(.title)
                    .padding(.top)
                Text("Under development :)")
                    .font(.title)
                    .padding(.top)
            }
            .navigationTitle("Forms")
        }
    }
}

