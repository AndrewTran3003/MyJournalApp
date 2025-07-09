import SwiftUI

struct MessageBubbleBase<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack {
            content()
                .background(Color.gray.opacity(0.2))
                .clipShape(MessageBubbleShape())
            Spacer()
        }
    }
} 
