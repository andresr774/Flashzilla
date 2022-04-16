//
//  optionalAnimation.swift
//  Flashzilla
//
//  Created by Andres Raigoza on 12/04/22.
//

import SwiftUI

// MARK: GLOBAL FUNCTION
func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    // Evaluate the parameter you want to check: ReduceMotion in this case
    if UIAccessibility.isReduceMotionEnabled {
        // The body gets executed without animation
        return try body()
    } else {
        // The body gets executed with animation
        return try withAnimation(animation, body)
    }
}

// MARK: USE CASE
struct MyView: View {
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
    }
}
