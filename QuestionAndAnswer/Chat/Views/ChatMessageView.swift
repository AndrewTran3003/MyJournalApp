import SwiftUI
import CoreData

struct ChatMessageView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ChatViewModel
    @State private var inputText: String = ""

    init(conversation: ChatConversation) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(conversation: conversation, viewContext: PersistenceController.shared.container.viewContext))
    }

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .onChange(of: viewModel.messages.count) { _ in
                    if let lastMessage = viewModel.messages.last {
                        withAnimation {
                            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            if viewModel.isComposing {
                PulsingDotsView()
            }

            HStack {
                TextField("Type a message...", text: $inputText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading)

                Button(action: sendMessage) {
                    Text("Send")
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .navigationTitle(viewModel.conversation.title ?? "Conversation")
    }

    private func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        viewModel.sendMessage(text: inputText, sender: "user")
        inputText = ""
    }
}

struct MessageBubble: View {
    @ObservedObject var message: ChatMessage
    
    var body: some View {
        HStack {
            if message.sender == "user" {
                Spacer()
                Text(message.text ?? "")
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)
            } else {
                Text(message.text ?? "")
                    .padding(10)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}

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