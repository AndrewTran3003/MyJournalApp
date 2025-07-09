//
//  PulsingDotsView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/7/2025.
//

import SwiftUI

struct PulsingDotsView: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .scaleEffect(scale)
                    .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(Double(index) * 0.2), value: scale)
            }
        }
        .onAppear {
            self.scale = 0.5
        }
        .padding()
        .accessibilityIdentifier("PulsingDotsView") // <-- Add this line
    }
}
