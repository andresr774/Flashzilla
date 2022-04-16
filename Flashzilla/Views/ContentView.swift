//
//  ContentView.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 11/04/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    
    @StateObject var vm = ViewModel()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var showingEditScreen = false
    @State private var userAnsweredRight = false
        
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(vm.timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack {
                    ForEach(vm.cards) { card in
                        if let index = vm.cards.firstIndex(of: card) {
                            CardView(card: card) { userAnsweredRight in
                                self.userAnsweredRight = userAnsweredRight
                                withAnimation {
                                    vm.removeCard(at: index, userAnsweredRight: userAnsweredRight)
                                }
                            }
                            .stacked(at: index, in: vm.cards.count)
                            .allowsHitTesting(index == vm.cards.count - 1)
                            .accessibilityHidden(index < vm.cards.count - 1)
                        }
                    }
                }
                .allowsHitTesting(vm.timeRemaining > 0)
                
                if vm.cards.isEmpty {
                    Button("Start Again", action: vm.resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || voiceOverEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button {
                            withAnimation {
                                vm.removeCard(at: vm.cards.count - 1, userAnsweredRight: userAnsweredRight)
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")
                        
                        Spacer()
                        
                        Button {
                            withAnimation {
                                vm.removeCard(at: vm.cards.count - 1, userAnsweredRight: userAnsweredRight)
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { _ in
            vm.countdown()
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if !vm.cards.isEmpty {
                    vm.isActive = true
                }
            } else {
                vm.isActive = false
            }
        }
        .fullScreenCover(isPresented: $showingEditScreen) {
            vm.resetCards()
        } content: {
            EditCards(vm: vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
