import XCTest

final class ChatUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-uiTesting")
        app.launch()
    }

    // Helper for polling
    func waitForCellCount(_ cells: XCUIElementQuery, toBe count: Int, timeout: TimeInterval = 5) -> Bool {
        let start = Date()
        while Date().timeIntervalSince(start) < timeout {
            if cells.count == count { return true }
            RunLoop.current.run(until: Date().addingTimeInterval(0.1))
        }
        return false
    }

    // Test 1: Check for Chat tab with bubble icon
    func testChatTabExists() {
        let chatTab = app.tabBars.buttons["Chat"]
        XCTAssertTrue(chatTab.exists, "Chat tab should exist in the bottom navigation bar.")
    }

    // Test 2: Check navigation to Conversations and presence of plus button
    func testConversationsScreenAndAddButton() {
        app.tabBars.buttons["Chat"].tap()
        let conversationsTitle = app.navigationBars["Conversations"]
        XCTAssertTrue(conversationsTitle.exists, "Should display 'Conversations' heading.")
        let addButton = conversationsTitle.buttons["Add Conversation"]
        XCTAssertTrue(addButton.exists, "Should have a plus button to add a conversation.")
    }

    // Test 3: Add conversation and check list increment
    func testAddConversationIncrementsList() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        let initialCount = cells.count
        let addButton = app.navigationBars["Conversations"].buttons["Add Conversation"]
        addButton.tap()

        let didIncrement = waitForCellCount(cells, toBe: initialCount + 1)
        XCTAssertTrue(didIncrement, "Should have one more conversation cell after adding.")
    }

    // Test 4: Enter conversation, check for input and send button
    func testEnterConversationShowsInputAndSend() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        XCTAssertTrue(textField.exists, "Text input should be present in chat view.")
        XCTAssertTrue(sendButton.exists, "Send button should be present in chat view.")
    }

    // Test 5: Send message and check display
    func testSendMessageAppears() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        textField.tap()
        textField.typeText("Hello, world!")
        sendButton.tap()
        let sentMessage = app.staticTexts["Hello, world!"]
        XCTAssertTrue(sentMessage.waitForExistence(timeout: 2), "Sent message should appear in chat view.")
    }

    // Test 6: LLM response and typing indicator
    func testLLMResponseAndTypingIndicator() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        textField.tap()
        textField.typeText("Test LLM")
        sendButton.tap()
        let typingIndicator = app.otherElements["PulsingDotsView"]
        XCTAssertTrue(typingIndicator.waitForExistence(timeout: 1), "Typing indicator should appear after sending a message.")
        let llmResponse = app.staticTexts["This is a simulated response to: 'Test LLM'"]
        XCTAssertTrue(llmResponse.waitForExistence(timeout: 5), "LLM response should appear in chat view.")
    }

    // Test 7: Message ordering
    func testMessageOrdering() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        textField.tap()
        textField.typeText("First")
        sendButton.tap()
        textField.tap()
        textField.typeText("Second")
        sendButton.tap()
        let firstMessage = app.staticTexts["First"]
        let secondMessage = app.staticTexts["Second"]
        XCTAssertTrue(firstMessage.exists && secondMessage.exists, "Both messages should appear.")
        XCTAssertLessThan(firstMessage.frame.minY, secondMessage.frame.minY, "First message should appear above second message.")
    }

    // Test 8: Automatic scrolling
    func testAutomaticScrolling() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        for i in 0..<10 {
            textField.tap()
            textField.typeText("Message \(i)")
            sendButton.tap()
        }
        let lastMessage = app.staticTexts["Message 9"]
        XCTAssertTrue(lastMessage.waitForExistence(timeout: 2), "Last message should be visible (scrolled to bottom).")
    }

    // Test 9: Conversation persistence
    func testConversationPersistence() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        let initialCount = cells.count
        let addButton = app.navigationBars["Conversations"].buttons["Add Conversation"]
        addButton.tap()
        let didIncrement = waitForCellCount(cells, toBe: initialCount + 1)
        XCTAssertTrue(didIncrement, "Should have one more conversation cell after adding.")
        app.terminate()
        app.launch()
        app.tabBars.buttons["Chat"].tap()
        let afterRelaunchCount = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).count
        XCTAssertGreaterThanOrEqual(afterRelaunchCount, initialCount + 1, "Conversations should persist after relaunch.")
    }

    // Test 10: Conversation deletion
    func testConversationDeletion() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let initialCount = cells.count
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.swipeLeft()
        let deleteButton = app.buttons["DeleteConversationButton"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 2), "Delete button should appear after swipe.")
        deleteButton.tap()
        let didDecrement = waitForCellCount(cells, toBe: initialCount - 1)
        XCTAssertTrue(didDecrement, "Deleting a conversation should decrement the list by 1.")
    
    }

    // Test 11: UI appearance (bubble alignment)
    func testMessageBubbleAlignment() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        textField.tap()
        textField.typeText("User bubble test")
        sendButton.tap()
        let userBubble = app.staticTexts["User bubble test"]
        XCTAssertTrue(userBubble.exists, "User message bubble should exist.")
        // LLM bubble will appear after a delay
        let llmBubble = app.staticTexts["This is a simulated response to: 'User bubble test'"]
        XCTAssertTrue(llmBubble.waitForExistence(timeout: 5), "LLM message bubble should exist.")
    }

    // Test 12: Input validation
    func testSendButtonDisabledForEmptyInput() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let textField = app.textFields["Type a message..."]
        let sendButton = app.buttons["Send"]
        textField.tap()
        textField.typeText("")
        sendButton.tap()
        // No new message should appear
        let messageCount = app.staticTexts.count
        sendButton.tap()
        XCTAssertEqual(app.staticTexts.count, messageCount, "No message should be sent for empty input.")
    }

    // Test 13: Navigation back
    func testNavigationBackToConversationList() {
        app.tabBars.buttons["Chat"].tap()
        let label = "New Conversation"
        let cells = app.staticTexts.matching(NSPredicate(format: "label == %@", label))
        if cells.count == 0 {
            app.navigationBars["Conversations"].buttons["Add Conversation"].tap()
        }
        let firstCell = app.staticTexts.matching(NSPredicate(format: "label == %@", label)).element(boundBy: 0)
        firstCell.tap()
        let backButton = app.navigationBars.buttons.element(boundBy: 0)
        backButton.tap()
        XCTAssertTrue(app.navigationBars["Conversations"].exists, "Should return to conversation list after tapping back.")
    }
} 
