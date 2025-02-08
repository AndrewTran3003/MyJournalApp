//
//  RemoveButtonView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//
import SwiftUI

struct RemoveButtonView: View {
    let action: (() -> Void)?

    init(action: (() -> Void)? = nil) {
        self.action = action
    }

    var body: some View {
        Button(action: {
            action?()
        }) {
            Image(systemName: "minus.circle.fill")
                .foregroundColor(.red)
                .font(.largeTitle)
        }

    }
}
