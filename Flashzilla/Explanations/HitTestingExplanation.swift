//
//  HitTestingExplanation.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 11/04/22.
//

import SwiftUI

struct HitTestingExplanation: View {
    var body: some View {
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World!")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
        
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//                //.allowsHitTesting(false)
//        }
    }
}

struct HitTestingExplanation_Previews: PreviewProvider {
    static var previews: some View {
        HitTestingExplanation()
    }
}
