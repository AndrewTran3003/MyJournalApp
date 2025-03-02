//
//  Untitled.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 16/2/2025.
//

import XCTest
@testable import QuestionAndAnswer

class CreateNewFormViewModelTests: XCTestCase {
    var sut: CreateNewFormViewModel!  // system under test
    var mockState: AppState!
    
    override func setUp() {
        super.setUp()
        mockState = AppState()
        sut = CreateNewFormViewModel(state: mockState)
    }
    
    override func tearDown() {
        sut = nil
        mockState = nil
        super.tearDown()
    }
    
    func testFieldCountIncrement(){
        sut.fieldCount = 0;
        
        sut.increaseFieldCount();
        
        XCTAssertEqual(sut.fieldCount, 1)
    }
    
    func testFieldCountDecrement(){
        sut.fieldCount = 1;
        
        sut.decreaseFieldCount();
        
        XCTAssertEqual(sut.fieldCount, 0);
        
    }
    
    func testFieldCountDecrement_WhenCountIsZero_ShouldStayZero(){
        sut.fieldCount = 0;
        
        sut.decreaseFieldCount();
        
        XCTAssertEqual(sut.fieldCount, 0);
        
    }
    
    /*func testFieldTypeSelection() {
        // Arrange
        let newType = CreateNewFormViewModel.FieldType.multiLineText
        
        // Act
        sut.selectedFieldType = newType
        
        // Assert
        XCTAssertEqual(sut.selectedFieldType, newType)
    }*/
    
    // Add this test if you have a save function
    /*func testSaveForm() {
        // Arrange
        sut.formName = "Test Form"
        sut.title = "Field 1"
        sut.selectedFieldType = .singleLineText
        
        // Act
        sut.saveForm()  // Assuming you have this method
        
        // Assert
        XCTAssertTrue(mockState.forms.contains { $0.name == "Test Form" })
        XCTAssertEqual(mockState.forms.first?.fields.count, 1)
        XCTAssertEqual(mockState.forms.first?.fields.first?.fieldName, "Field 1")
        XCTAssertEqual(mockState.forms.first?.fields.first?.fieldType, .singleLineText)
    }*/
}
