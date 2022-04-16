//
//  AccessibilityNeeds.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 12/04/22.
//

import SwiftUI



struct AccessibilityNeeds: View {
    //@Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    //@Environment(\.accessibilityReduceMotion) var reduceMotion
    //@State private var scale = 1.0
    
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
        
        // MARK: REDUCE MOTION
//        Text("Hello")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
        
        // MARK: DIFFERENTIATE WITHOUT COLOR
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? .black : .green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
    }
}

struct AccessibilityNeeds_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityNeeds()
    }
}
