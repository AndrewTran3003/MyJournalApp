import SwiftUI
import CoreData

struct ChatRootView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ChatConversation.lastMessageTimestamp, ascending: false)],
        animation: .default)
    private var conversations: FetchedResults<ChatConversation>

    var body: some View {
        NavigationView {
            List {
                ForEach(conversations) { conversation in
                    NavigationLink {
                        ChatMessageView(conversation: conversation)
                    } label: {
                        Text(conversation.title ?? "New Conversation")
                    }
                    .accessibilityIdentifier("ConversationCell")
                    .swipeActions {
                        Button(role: .destructive, action: {
                            if let index = conversations.firstIndex(of: conversation) {
                                deleteConversations(offsets: IndexSet(integer: index))
                            }
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                        .accessibilityIdentifier("DeleteConversationButton")
                    }
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addConversation) {
                        Label("Add Conversation", systemImage: "plus")
                    }
                }
            }
        }
    }

    private func addConversation() {
        withAnimation {
            let newConversation = ChatConversation(context: viewContext)
            newConversation.id = UUID()
            newConversation.title = "New Conversation"
            newConversation.lastMessageTimestamp = Date()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteConversations(offsets: IndexSet) {
        withAnimation {
            offsets.map { conversations[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ChatRootView_Previews: PreviewProvider {
    static var previews: some View {
        ChatRootView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
} 
