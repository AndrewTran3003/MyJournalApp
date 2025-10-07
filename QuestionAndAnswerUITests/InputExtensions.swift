//
//  Created by Andrew Tran on 7/10/2025.
//

import XCTest

extension XCUIElement {
    func clearTextInput(){
        guard let stringValue = self.value as? String else {
            return
        }
        // Type delete for each character in existing value
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
    }
    
    func clearTextAndEnterNewValue(newValue: String) {
        self.tap()
        self.clearTextInput()
        self.typeText(newValue)
        // Typing "return" in the keyboard
        self.typeText("\n")
    }
}
