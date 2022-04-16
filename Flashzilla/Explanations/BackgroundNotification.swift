//
//  BackgroundNotification.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 12/04/22.
//

import SwiftUI

struct BackgroundNotification: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct BackgroundNotification_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundNotification()
    }
}
