//
//  View.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 12/04/22.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
