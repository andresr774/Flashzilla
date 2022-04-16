//
//  CardView.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 12/04/22.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: ((_ userAnsweredRight: Bool) -> Void)? = nil
    
    @State private var feedback = UINotificationFeedbackGenerator()
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var offsetGraterThanZero = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor ? .white : .white.opacity(1 - Double(abs(offset.width / 50)))
                )
                .background {
                    differentiateWithoutColor ? nil :
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .cardColor(
                            offset: offset,
                            offsetXGraterThanZero: offsetGraterThanZero
                        )
                }
                .shadow(radius: 10)
            
            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(dragGesture)
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.spring(), value: offset)
    }
    
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                offset = gesture.translation
                feedback.prepare()
                if offset.width > 0 {
                    offsetGraterThanZero = true
                }
            }
            .onEnded { _ in
                if abs(offset.width) > 100 {
                    if offset.width > 0 {
                        removal?(true)
                    } else {
                        feedback.notificationOccurred(.error)
                        removal?(false)
                        offset = .zero
                        isShowingAnswer = false
                    }
                } else {
                    offset = .zero
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        offsetGraterThanZero = false
                    }
                }
            }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
