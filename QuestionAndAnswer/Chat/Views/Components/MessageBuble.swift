//
//  MessageBuble.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/7/2025.
//
import SwiftUI
import MarkdownUI

struct MessageBubble: View {
   var message: String?
    
    var body: some View {
        MessageBubbleBase {
            Markdown(message ?? "")
                .padding(20)
        }
    }
}
