import SwiftUI

struct Question: Codable, Identifiable {
    let id: UUID
    let text: String
    var answer: String? = nil // To store the user's input

    enum CodingKeys: String, CodingKey {
        case text
    }

    // Custom initializer to generate a unique ID
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = UUID()
        text = try container.decode(String.self, forKey: .text)
    }

    init(id: UUID = UUID(), text: String, answer: String? = nil) {
        self.id = id
        self.text = text
        self.answer = answer
    }
}
