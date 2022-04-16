//
//  GesturesExplanation.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 11/04/22.
//

import SwiftUI

struct GesturesExplanation: View {
    // MARK: DRAG GESTURE
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    // MARK: MAGNIFICATION GESTURE
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
    
    // MARK: ROTATION GESTURE
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
    
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
        
//        VStack {
//            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//                .onTapGesture {
//                    // Child view has the priority on gestures by default
//                    print("Text tapped!")
//                }
//        }
//        // MARK: SIMULTANEOUS GESTURE
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded {
//                    print("VStack tapped")
//                }
//        )
        
        // MARK: PRIORITY GESTURE
//        .highPriorityGesture(
//            TapGesture()
//                .onEnded {
//                    print("VStack tapped")
//                }
//        )
            
        
        
        // MARK: ROTATION GESTURE
//            .rotationEffect(currentAmount + finalAmount)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        // This amount starts in 1.0 = original size
//                        currentAmount = angle
//                    }
//                    .onEnded { angle in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    }
//            )
        
        // MARK: MAGNIFICATION GESTURE
        
//            .scaleEffect(currentAmount + finalAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { amount in
//                        // This amount starts in 1.0 = original size
//                        currentAmount = amount - 1
//                        print(currentAmount)
//                    }
//                    .onEnded { amount in
//                        finalAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
        
        // MARK: LONG PRESS GESTURE
        
//            .onLongPressGesture(minimumDuration: 2) {
//                print("Long pressed!")
//            } onPressingChanged: { inProgress in
//                print("In progress: \(inProgress)")
//            }

    }
}

struct GesturesExplanation_Previews: PreviewProvider {
    static var previews: some View {
        GesturesExplanation()
    }
}
