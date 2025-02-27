import XCTest

class FormNavigationUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testFormsTab_ShouldHaveCreateANewFormButton() throws {
        // Tap on Forms tab
        app.tabBars.buttons["Forms"].tap()

        // Verify "Create a new form" link exists
        let createNewFormLink = app.buttons["Create a new form"]
        XCTAssertTrue(createNewFormLink.exists, "Create a new form link should be visible")

        // Optional: Verify it's within a NavigationLink
        XCTAssertTrue(createNewFormLink.isEnabled, "Create a new form link should be tappable")
    }

    func testFormsTab_ClickOnCreateANewForm_ShouldOpenCreateANewFormScreen() throws {
        // Tap on Forms tab
        app.tabBars.buttons["Forms"].tap()

        // Tap on Create a new form link
        app.buttons["Create a new form"].tap()

        let navBar = app.navigationBars["Create a new form"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 2), "Navigation bar should be visible")

        let navBarTitle = navBar.staticTexts["Create a new form"]
        XCTAssertTrue(
            navBarTitle.exists,
            "Navigation bar should have title 'Create a new form'")
        let formNameLabel = app.staticTexts["Form name"]
        XCTAssertTrue(
            formNameLabel.exists,
            "Form name label should be visible")
        let formNameInput = app.textFields["Enter form name here"]
        XCTAssertTrue(
            formNameInput.exists,
            "Text field with placeholder 'Enter form name here' should be visible")

        // Debug: Print UI hierarchy
        print("UI HIERARCHY:")
        print(app.debugDescription)

        // Check for exactly one NewFieldView by verifying its components
        let fieldNameLabels = app.staticTexts.matching(identifier: "Field Name").count
        let fieldTypeLabels = app.staticTexts.matching(identifier: "Field Type").count
        let fieldNameInputs = app.textFields.matching(identifier: "Enter the field name here").count

        let pickerElements = app.buttons.matching(identifier: "fieldTypePicker").count

        let removeButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'")).count
        let addButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'plus.circle.fill'")).count

        print("Remove buttons found: \(removeButtons)")

        XCTAssertEqual(fieldNameLabels, 1, "Should have exactly one Field Name label")
        XCTAssertEqual(fieldTypeLabels, 1, "Should have exactly one Field Type label")
        XCTAssertEqual(fieldNameInputs, 1, "Should have exactly one field name input")
        XCTAssertEqual(pickerElements, 1, "Should have exactly one field type picker")  // Use whichever approach works
        XCTAssertEqual(removeButtons, 1, "Should have exactly one remove button")
        XCTAssertEqual(addButtons, 1, "Should have exactly one add button")
    }

    func testCreateNewFormScreenWithInteraction() throws {
        // Given: Navigate to Forms tab
        app.tabBars.buttons["Forms"].tap()

        // When: Tap on Create a new form
        let createNewFormButton = app.buttons["Create a new form"]
        XCTAssertTrue(
            createNewFormButton.waitForExistence(timeout: 2),
            "Create new form button should be visible")
        createNewFormButton.tap()

        // Then: Verify screen elements
        let navBar = app.navigationBars["Create a new form"]
        XCTAssertTrue(
            navBar.waitForExistence(timeout: 2),
            "Navigation bar should be visible")

        let formNameLabel = app.staticTexts["Form name"]
        XCTAssertTrue(
            formNameLabel.exists,
            "Form name label should be visible")

        let textField = app.textFields["Enter form name here"]
        XCTAssertTrue(
            textField.exists,
            "Form name text field should be visible")

        // Optional: Test interaction
        textField.tap()
        textField.typeText("Test Form")
        XCTAssertEqual(
            textField.value as? String, "Test Form",
            "Text field should contain entered text")
    }
}
