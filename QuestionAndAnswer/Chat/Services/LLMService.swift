import Foundation

enum LLMError: Error {
    case networkError
    case apiError
    case rateLimitExceeded
}

class LLMService {
    static let shared = LLMService()

    private init() {}

    func getResponse(for query: String, conversationHistory: [ChatMessage], completion: @escaping (Result<String, LLMError>) -> Void) {
        
        // Simulate a network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // In a real implementation, you would make a network request here.
            // For now, we'll just return a canned response.
            let response = "This is a simulated response to: '\(query)'"
            completion(.success(response))
        }
    }
} 