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
        let createNewFormLink = app.buttons["Create a new form"]
        XCTAssertTrue(createNewFormLink.exists, "Create a new form link should be visible")
        XCTAssertTrue(createNewFormLink.isEnabled, "Create a new form link should be tappable")
    }

    func testShouldOpenCreateANewFormScreenWhenTappingFormsTab() throws {
        // Arrange and Act
        app.tabBars.buttons["Forms"].tap()
        app.buttons["Create a new form"].tap()

        // Assert
        let navBar = app.navigationBars["Create a new form"]
        let navBarTitle = navBar.staticTexts["Create a new form"]
        let formNameLabel = app.staticTexts["Form name"]
        let formNameInput = app.textFields["Enter form name here"]
        let fieldNameLabels = app.staticTexts.matching(identifier: "Field Name").count
        let fieldTypeLabels = app.staticTexts.matching(identifier: "Field Type").count
        let fieldNameInputs = app.textFields.matching(identifier: "Enter the field name here").count
        let pickerElements = app.buttons.matching(identifier: "fieldTypePicker").count
        let removeButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'")).count
        let addButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'plus.circle.fill'")).count

        XCTAssertTrue(navBarTitle.exists, "Navigation bar should have title 'Create a new form'")
        XCTAssertTrue(
            formNameInput.exists,
            "Text field with placeholder 'Enter form name here' should be visible")
        XCTAssertTrue(navBar.waitForExistence(timeout: 2), "Navigation bar should be visible")
        XCTAssertTrue(formNameLabel.exists, "Form name label should be visible")
        XCTAssertEqual(fieldNameLabels, 1, "Should have exactly one Field Name label")
        XCTAssertEqual(fieldTypeLabels, 1, "Should have exactly one Field Type label")
        XCTAssertEqual(fieldNameInputs, 1, "Should have exactly one field name input")
        XCTAssertEqual(pickerElements, 1, "Should have exactly one field type picker")
        XCTAssertEqual(removeButtons, 1, "Should have exactly one remove button")
        XCTAssertEqual(addButtons, 1, "Should have exactly one add button")
    }

    func testShouldEnterFormName() throws {
        // Arrange
        app.tabBars.buttons["Forms"].tap()
        let createNewFormButton = app.buttons["Create a new form"]
        createNewFormButton.tap()
        let textField = app.textFields["Enter form name here"]

        // Act
        textField.tap()
        textField.typeText("Test Entering Form Name")

        // Assert
        XCTAssertEqual(
            textField.value as? String, "Test Entering Form Name",
            "Text field should contain entered text")
    }

    func testShouldHave3NewFieldViews() throws {
        // Arrange
        app.tabBars.buttons["Forms"].tap()
        app.buttons["Create a new form"].tap()
        let addButton = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'plus.circle.fill'"))
            .firstMatch
        
        // Act
        addButton.tap()
        addButton.tap()

        let fieldNameLabels = app.staticTexts.matching(identifier: "Field Name").count
        let fieldNameInputs = app.textFields.matching(identifier: "Enter the field name here").count

        let fieldTypeLabels = app.staticTexts.matching(identifier: "Field Type").count
        let fieldTypePickers = app.buttons.matching(identifier: "fieldTypePicker").count

        let removeButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'")).count

        // Assert
        XCTAssertEqual(fieldNameLabels, 3, "Should have exactly 3 Field Name label")
        XCTAssertEqual(fieldNameInputs, 3, "Should have exactly 3 field name input")

        XCTAssertEqual(fieldTypeLabels, 3, "Should have exactly 3 Field Type label")
        XCTAssertEqual(fieldTypePickers, 3, "Should have exactly 3 field type picker")

        XCTAssertEqual(removeButtons, 3, "Should have exactly 3 remove button")
    }
}
