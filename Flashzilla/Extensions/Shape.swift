//
//  Shape.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 14/04/22.
//

import SwiftUI

extension Shape {
    func cardColor(offset: CGSize, offsetXGraterThanZero: Bool) -> some View {
        fill(offset.width > 0 ? .green : offsetXGraterThanZero ? .green : .red)
    }
}
