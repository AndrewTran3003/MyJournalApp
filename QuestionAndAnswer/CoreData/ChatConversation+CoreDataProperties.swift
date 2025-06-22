//
//  ChatConversation+CoreDataProperties.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 10/1/2025.
//
//

import Foundation
import CoreData


extension ChatConversation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChatConversation> {
        return NSFetchRequest<ChatConversation>(entityName: "ChatConversation")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lastMessageTimestamp: Date?
    @NSManaged public var title: String?
    @NSManaged public var messages: NSSet?

}

// MARK: Generated accessors for messages
extension ChatConversation {

    @objc(addMessagesObject:)
    @NSManaged public func addToMessages(_ value: ChatMessage)

    @objc(removeMessagesObject:)
    @NSManaged public func removeFromMessages(_ value: ChatMessage)

    @objc(addMessages:)
    @NSManaged public func addToMessages(_ values: NSSet)

    @objc(removeMessages:)
    @NSManaged public func removeFromMessages(_ values: NSSet)

}

extension ChatConversation : Identifiable {

} 