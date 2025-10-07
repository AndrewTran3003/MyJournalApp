//
//  UserMessageBubbleShape.swift
//  QuestionAndAnswer
//
//  Created by Andrew Tran on 9/7/2025.
//

import SwiftUI

struct UserMessageBubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let width = rect.width
        let height = rect.height
        
        var path = Path()
        
        path.move(to: CGPoint(x: width - 20, y: height))
        path.addLine(to: CGPoint(x: 15, y: height))
        path.addCurve(to: CGPoint(x: 0, y: height - 15), control1: CGPoint(x: 8, y: height), control2: CGPoint(x: 0, y: height - 8))
        path.addLine(to: CGPoint(x: 0, y: 15))
        path.addCurve(to: CGPoint(x: 15, y: 0), control1: CGPoint(x: 0, y: 8), control2: CGPoint(x: 8, y: 0))
        path.addLine(to: CGPoint(x: width - 20, y: 0))
        path.addCurve(to: CGPoint(x: width - 5, y: 15), control1: CGPoint(x: width - 12, y: 0), control2: CGPoint(x: width - 5, y: 8))
        path.addLine(to: CGPoint(x: width - 5, y: height - 12))
        path.addCurve(to: CGPoint(x: width, y: height), control1: CGPoint(x: width - 5, y: height - 1), control2: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width + 1, y: height))
        path.addCurve(to: CGPoint(x: width - 12, y: height - 4), control1: CGPoint(x: width - 4, y: height + 1), control2: CGPoint(x: width - 8, y: height - 1))
        path.addCurve(to: CGPoint(x: width - 20, y: height), control1: CGPoint(x: width - 15, y: height), control2: CGPoint(x: width - 20, y: height))
        
        return path
    }
}
