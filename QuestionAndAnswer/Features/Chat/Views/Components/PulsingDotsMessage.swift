//
//  Untitled.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/7/2025.
//
import SwiftUI

struct PulsingDotsMessage: View {
    var body : some View {
        MessageBubbleBase{
            PulsingDotsView()
        }
        .padding(.leading, 20)
    }
}
