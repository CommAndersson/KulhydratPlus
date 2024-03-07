//
//  Rediger Billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/02/2024.
//

import SwiftUI

struct RedigerKort: View {
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var flashcard: Flashcard
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck

    @State private var redigeretNavn = ""
    @State private var redigeretKulhydrat = ""
    @State private var redigeretMåleenhed = "Gram"
    @State private var redigeretMængde = ""
    let muligeMåleenheder = ["Gram", "mL", "Antal"]
    @State private var mængdeværdiIndsatIndeIFlashcard = 0.0

    // Computed property to dynamically calculate total carbohydrates
    var calculatedTotalBilledkortKulhydrat: Double {
        guard let redigeretKulhydratDouble = Double(redigeretKulhydrat),
              let redigeretMængdeDouble = Double(redigeretMængde),
              redigeretMængdeDouble > 0 else {
            return 0.0
        }

        let billedkortKulhydratPr100Gram = redigeretKulhydratDouble / redigeretMængdeDouble * 100
        let totalKulhydrat = billedkortKulhydratPr100Gram * mængdeværdiIndsatIndeIFlashcard / 100
        return totalKulhydrat
    }

    var body: some View {
        List {
            Section(header: Text("Rediger Billedkort")) {
                TextField("Navn", text: $redigeretNavn)
                Picker("Måleenhed", selection: $redigeretMåleenhed) {
                    ForEach(muligeMåleenheder, id: \.self) { måleenhed in
                        Text(måleenhed)
                    }
                }
                .pickerStyle(.menu)
                TextField("Mængde \(redigeretNavn) i \(redigeretMåleenhed)", text: $redigeretMængde)
                    .keyboardType(.decimalPad)
                TextField("Kulhydrater i fødevaren i gram (fx. 50)", text: $redigeretKulhydrat)
                    .keyboardType(.decimalPad)

            
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    // Check for duplicate name only if the name has been changed.
                    if redigeretNavn != flashcard.navn && deck.cards.contains(where: { $0.navn == redigeretNavn }) {
                        alertMessage = "Et kort med navnet '\(redigeretNavn)' findes allerede."
                        showingAlert = true
                    } else {
                        // Your existing code to update the flashcard.
                        if let redigeretKulhydratDouble = Double(redigeretKulhydrat), let redigeretMængdeDouble = Double(redigeretMængde) {
                            flashcardManager.updateCard(
                                in: deck,
                                cardID: flashcard.id,
                                newNavn: redigeretNavn.isEmpty ? flashcard.navn : redigeretNavn,
                                newKulhydrat: redigeretKulhydratDouble,
                                newMåleenhed: redigeretMåleenhed,
                                newMængde: redigeretMængdeDouble,
                                newAktivMængde: mængdeværdiIndsatIndeIFlashcard
                            )
                        }
                        dismiss()
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

                    
