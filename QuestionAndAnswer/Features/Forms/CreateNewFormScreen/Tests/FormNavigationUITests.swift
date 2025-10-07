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
        let fieldTypeLabelCount = app.staticTexts.matching(identifier: "Field Type").count
        let fieldNameInputCount = app.textFields.matching(identifier: "Enter the field name here")
            .count
        let pickerElements = app.buttons.matching(identifier: "fieldTypePicker").count
        let removeButtonCount = app.descendants(matching: .button)
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
        XCTAssertEqual(fieldTypeLabelCount, 1, "Should have exactly one Field Type label")
        XCTAssertEqual(fieldNameInputCount, 1, "Should have exactly one field name input")
        XCTAssertEqual(pickerElements, 1, "Should have exactly one field type picker")
        XCTAssertEqual(removeButtonCount, 1, "Should have exactly one remove button")
        XCTAssertEqual(addButtons, 1, "Should have exactly one add button")
    }

    func testShouldEnterFormName() throws {
        // Arrange
        app.tabBars.buttons["Forms"].tap()
        let createNewFormButton = app.buttons["Create a new form"]
        createNewFormButton.tap()
        let formNameField = app.textFields["Enter form name here"]

        // Act
        formNameField.tap()
        
        formNameField.clearTextInput()
        
        formNameField.typeText("Test Entering Form Name")

        // Assert
        XCTAssertEqual(
            formNameField.value as? String, "Test Entering Form Name",
            "Text field should contain entered text")
    }

    func testShouldHaveNoFieldWhenTappingOnTheRemoveButton() throws {
        // Arrange
        app.tabBars.buttons["Forms"].tap()
        app.buttons["Create a new form"].tap()

        let removeButton = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'"))
            .firstMatch

        // Act
        removeButton.tap()

        let fieldNameLabels = app.staticTexts.matching(identifier: "Field Name").count
        let fieldNameInputCount = app.textFields.matching(identifier: "Enter the field name here")
            .count

        let fieldTypeLabelCount = app.staticTexts.matching(identifier: "Field Type").count
        let fieldTypePickerCount = app.buttons.matching(identifier: "fieldTypePicker").count

        let removeButtonCount = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'")).count

        // Assert
        XCTAssertEqual(fieldNameLabels, 0, "Should have exactly 0 Field Name label")
        XCTAssertEqual(fieldNameInputCount, 0, "Should have exactly 0 field name input")

        XCTAssertEqual(fieldTypeLabelCount, 0, "Should have exactly 0 Field Type label")
        XCTAssertEqual(fieldTypePickerCount, 0, "Should have exactly 0 field type picker")

        XCTAssertEqual(removeButtonCount, 0, "Should have exactly 0 remove button")

    }

    func testShouldRemoveTheRightField() throws {
        // Arrange and Act
        // Create two fields. First field to have the field name "Field to be removed". Second field to have the field name "Field to stay"
        // Then click on the remove button of the first field
        app.tabBars.buttons["Forms"].tap()
        app.buttons["Create a new form"].tap()

        let addButton = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'plus.circle.fill'")).firstMatch
        addButton.tap()

        let fieldNameInputs = app.textFields.matching(identifier: "Enter the field name here")
            .allElementsBoundByIndex

        fieldNameInputs[0].tap()
        fieldNameInputs[0].typeText("Field to be removed")

        fieldNameInputs[1].tap()
        fieldNameInputs[1].typeText("Field to stay")

        let removeButtons = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'"))
            .allElementsBoundByIndex
        removeButtons[0].tap()

        // Assert
        let removedFieldCount = app.textFields.matching(
            NSPredicate(format: "value CONTAINS 'Field to be removed'")
        ).count
        XCTAssertEqual(
            removedFieldCount, 0, "Field with text 'Field to be removed' should not exist")

        let remainingFieldCount = app.textFields.matching(
            NSPredicate(format: "value CONTAINS 'Field to stay'")
        ).count
        XCTAssertEqual(
            remainingFieldCount, 1, "Should have exactly one field with text 'Field to stay'")

    }
    func testShouldHave3NewFieldViewsWhenTappingTheAddButtonTwice() throws {
        // Arrange
        app.tabBars.buttons["Forms"].tap()
        app.buttons["Create a new form"].tap()
        let addButton = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'plus.circle.fill'"))
            .firstMatch

        // Act
        addButton.tap()
        addButton.tap()

        let fieldNameLabelCount = app.staticTexts.matching(identifier: "Field Name").count
        let fieldNameInputCount = app.textFields.matching(identifier: "Enter the field name here")
            .count

        let fieldTypeLabelCount = app.staticTexts.matching(identifier: "Field Type").count
        let fieldTypePickerCount = app.buttons.matching(identifier: "fieldTypePicker").count

        let removeButtonCount = app.descendants(matching: .button)
            .matching(NSPredicate(format: "identifier == 'minus.circle.fill'")).count

        // Assert
        XCTAssertEqual(fieldNameLabelCount, 3, "Should have exactly 3 Field Name label")
        XCTAssertEqual(fieldNameInputCount, 3, "Should have exactly 3 field name input")

        XCTAssertEqual(fieldTypeLabelCount, 3, "Should have exactly 3 Field Type label")
        XCTAssertEqual(fieldTypePickerCount, 3, "Should have exactly 3 field type picker")

        XCTAssertEqual(removeButtonCount, 3, "Should have exactly 3 remove button")
    }
}
