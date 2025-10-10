//
//  FormList.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/2/2025.
//

import Foundation

struct FormList : Codable, Hashable, Equatable{
    var forms : [Form]
    var activeFormId : UUID?
    
    init(forms: [Form] = []) {
        self.forms = forms
    }
    
    mutating func UpdateActiveForm(form: Form) {
        if let index = forms.firstIndex(where: {$0.id == activeFormId}) {
            forms[index] = form
        }
    }
    static func == (lhs: FormList, rhs: FormList) -> Bool {
        return lhs.forms == rhs.forms
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(forms)
    }
}
