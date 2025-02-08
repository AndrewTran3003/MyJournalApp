//
//  AddButtonView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//

import SwiftUI

struct AddButtonView: View {
    let action: (() -> Void)?

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.largeTitle)
                .padding()
        }

    }
}
