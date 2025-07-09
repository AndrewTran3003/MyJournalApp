import SwiftUI
import CoreData
import MarkdownUI

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
                            if (message.sender == "user"){
                                UserMessageBubble(message: message.text)
                                    .id(message.id)
                            }
                            else {
                                MessageBubble(message: message.text)
                                    .id(message.id)
                            }
                        }
                    }
                    .padding(.horizontal, 15)
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
                PulsingDotsMessage()
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
