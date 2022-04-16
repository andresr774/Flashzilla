//
//  EditCards.swift
//  Flashzilla
//
//  Created by Andres camilo Raigoza misas on 13/04/22.
//

import SwiftUI

struct EditCards: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var vm: ContentView.ViewModel
    
    @FocusState private var fieldInFocus: Field?
    enum Field {
        case prompt, answer
    }
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt", text: $vm.newPrompt)
                        .focused($fieldInFocus, equals: .prompt)
                    TextField("Answer", text: $vm.newAnswer)
                        .focused($fieldInFocus, equals: .answer)
                    Button("Add card") {
                        vm.addCard()
                        fieldInFocus = nil
                    }
                }
                
                Section {
                    ForEach(vm.cards) { card in
                        VStack(alignment: .leading) {
                            Text(card.prompt)
                                .font(.headline)
                            Text(card.answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { offsets in
                        vm.removeCards(at: offsets)
                    }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
            .listStyle(.grouped)
            .onAppear {
                vm.loadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    fieldInFocus = .prompt
                }
            }
        }
    }    
}

struct EditCards_Previews: PreviewProvider {
    static var previews: some View {
        EditCards(vm: ContentView.ViewModel())
    }
}
