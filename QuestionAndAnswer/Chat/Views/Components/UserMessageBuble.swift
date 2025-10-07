//
//  UserMessageBuble.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/7/2025.
//
import SwiftUI

struct UserMessageBubble: View {
    var message: String?
    
    var body: some View {
        HStack {
            Spacer()
            Text(message ?? "")
                .padding(20)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(UserMessageBubbleShape())
                .padding(.leading, 40) // <-- This adds margin to the left
        }
    }
}
