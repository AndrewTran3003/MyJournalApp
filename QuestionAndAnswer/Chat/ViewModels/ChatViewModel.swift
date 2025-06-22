import Foundation
import CoreData
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isComposing: Bool = false
    public let conversation: ChatConversation
    private let viewContext: NSManagedObjectContext
    private let llmService = LLMService.shared

    init(conversation: ChatConversation, viewContext: NSManagedObjectContext) {
        self.conversation = conversation
        self.viewContext = viewContext
        fetchMessages()
    }

    func fetchMessages() {
        let request: NSFetchRequest<ChatMessage> = ChatMessage.fetchRequest()
        request.predicate = NSPredicate(format: "conversation == %@", conversation)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ChatMessage.timestamp, ascending: true)]

        do {
            messages = try viewContext.fetch(request)
        } catch {
            print("Error fetching messages: \(error)")
        }
    }

    func sendMessage(text: String, sender: String) {
        let newMessage = ChatMessage(context: viewContext)
        newMessage.id = UUID()
        newMessage.text = text
        newMessage.timestamp = Date()
        newMessage.sender = sender
        newMessage.conversation = conversation

        conversation.lastMessageTimestamp = newMessage.timestamp

        do {
            try viewContext.save()
            messages.append(newMessage)

            if sender == "user" {
                fetchLLMResponse(for: text)
            }
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    private func fetchLLMResponse(for text: String) {
        isComposing = true
        llmService.getResponse(for: text, conversationHistory: messages) { [weak self] result in
            DispatchQueue.main.async {
                self?.isComposing = false
                switch result {
                case .success(let responseText):
                    self?.sendMessage(text: responseText, sender: "llm")
                case .failure(let error):
                    // Handle error appropriately, e.g., show an alert
                    print("LLM Error: \(error)")
                }
            }
        }
    }
} 
