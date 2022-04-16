//
//  ViewModel.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 15/04/22.
//

import Foundation

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var cards = [Card]()
        
        @Published var timeRemaining = 100
        @Published var isActive = true
        
        @Published var newPrompt = ""
        @Published var newAnswer = ""
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("Cards")
        
        init() {
            loadData()
        }
        
        func loadData() {
            do {
                cards = try FileManager.default.decode(from: savePath)
            } catch {
                print("Error getting data from url: \(error.localizedDescription)")
            }
        }
        
        func addCard() {
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            
            guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
            
            let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
            cards.insert(newCard, at: 0)
            saveData()
            newPrompt = ""
            newAnswer = ""
        }
        
        func removeCard(at index: Int, userAnsweredRight: Bool) {
            guard index >= 0 else { return }
            
            if userAnsweredRight {
                cards.remove(at: index)
            } else {
                if index > 0 {
                    let tempCard = cards[index]
                    cards.remove(at: index)
                    cards.insert(tempCard, at: 0)
                }
            }
            if cards.isEmpty {
                isActive = false
            }
        }
        
        func removeCards(at offsets: IndexSet) {
            cards.remove(atOffsets: offsets)
            saveData()
        }
        
        func countdown() {
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        
        func resetCards() {
            timeRemaining = 100
            isActive = true
            loadData()
        }
        
        private func saveData() {
            FileManager.default.save(cards, to: savePath)
        }
    }
}
