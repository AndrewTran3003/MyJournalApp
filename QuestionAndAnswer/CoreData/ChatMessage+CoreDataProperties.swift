//
//  ChatMessage+CoreDataProperties.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//
//

import Foundation
import CoreData


extension ChatMessage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatMessage> {
        return NSFetchRequest<ChatMessage>(entityName: "ChatMessage")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var sender: String?
    @NSManaged public var text: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var conversation: ChatConversation?

}

extension ChatMessage : Identifiable {

} 