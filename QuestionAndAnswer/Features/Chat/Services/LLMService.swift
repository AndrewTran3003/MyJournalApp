import Foundation

enum LLMError: Error, LocalizedError {
    case networkError
    case apiError(String)
    case rateLimitExceeded

    var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network error occurred."
        case .apiError(let message):
            return message
        case .rateLimitExceeded:
            return "API rate limit exceeded."
        }
    }
}

protocol LLMServiceProtocol {
    func getResponse(for query: String, conversationHistory: [ChatMessage], completion: @escaping (Result<String, LLMError>) -> Void)
}

// Global service provider for dependency injection
class LLMServiceProvider {
    static var shared: LLMServiceProtocol = LLMService()
    
    static func configureForTesting() {
        shared = MockLLMService()
    }
}

class LLMService: LLMServiceProtocol {
    init() {}
    let apiKey = ProcessInfo.processInfo.environment["deepseek-api-key"] ?? ""
    let serviceUrl = ProcessInfo.processInfo.environment["deepseek-service-url"] ?? ""

    func getResponse(for query: String, conversationHistory: [ChatMessage], completion: @escaping (Result<String, LLMError>) -> Void) {
        if apiKey.isEmpty || serviceUrl.isEmpty {
            let errorMessage = "Unable to connect to DeepSeek. Verify that your environment variables are correct."
            completion(.failure(.apiError(errorMessage)))
            return
        }

        guard let url = URL(string: serviceUrl) else {
            completion(.failure(.apiError("Invalid service URL.")))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = [
            "messages": [
                ["content": query, "role": "user"]
            ],
            "model": "deepseek-chat",
            "frequency_penalty": 0,
            "max_tokens": 2048,
            "presence_penalty": 0,
            "response_format": ["type": "text"],
            "stop": NSNull(),
            "stream": false,
            "stream_options": NSNull(),
            "temperature": 1,
            "top_p": 1,
            "tools": NSNull(),
            "tool_choice": "none",
            "logprobs": false,
            "top_logprobs": NSNull()
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(.apiError("Failed to encode request body.")))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.apiError("Network error: \(error.localizedDescription)")))
                return
            }

            guard let data = data else {
                completion(.failure(.apiError("No data received from server.")))
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]] {
                    let contents = choices.compactMap { choice in
                        (choice["message"] as? [String: Any])?["content"] as? String
                    }
                    let result = contents.joined(separator: " ")
                    completion(.success(result))
                } else {
                    completion(.failure(.apiError("Invalid response format.")))
                }
            } catch {
                completion(.failure(.apiError("Failed to parse response: \(error.localizedDescription)")))
            }
        }
        task.resume()
    }
}

class MockLLMService: LLMServiceProtocol {
    func getResponse(for query: String, conversationHistory: [ChatMessage], completion: @escaping (Result<String, LLMError>) -> Void) {
        // Simulate a 3-second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let response = "This is a simulated response to: '\(query)'"
            completion(.success(response))
        }
    }
} 
