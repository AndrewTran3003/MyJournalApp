//
//  FormsRootScreenTests.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 7/10/2025.
//
import XCTest

class FormsRootScreenTests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testShouldHaveFormsButtonInTabNavigation() throws {
        // Arrange and Act
        let formsButton = app.tabBars.buttons["Forms"]

        // Assert
        XCTAssertTrue(
            formsButton.waitForExistence(timeout: 2),
            "Forms button should be visible in the tab navigation")
    }

    func testShouldHaveCreateANewFormButtonInTheFormsTab() throws {
        // Arrage and Act
        app.tabBars.buttons["Forms"].tap()

        // Assert
        let FormViewerLink = app.buttons["Create a new form"]
        XCTAssertTrue(FormViewerLink.exists, "Create a new form link should be visible")
        XCTAssertTrue(FormViewerLink.isEnabled, "Create a new form link should be tappable")
    }

}
