//
//  AddNewFieldButtonView.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 8/2/2025.
//
import SwiftUI

struct AddNewFieldButtonView: View {
    @Binding var newFieldCount: Int

    var body: some View {
        HStack {
            Spacer()
            AddButton {
                newFieldCount += 1
            }
            Spacer()
        }
    }
}
