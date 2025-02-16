//
//  FormList.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/2/2025.
//

import Foundation

struct FormList : Codable {
    let savedForms : [Form]
    let unsavedForms : [Form]
}
