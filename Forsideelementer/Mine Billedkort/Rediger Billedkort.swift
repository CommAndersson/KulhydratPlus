//
//  Rediger Billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/02/2024.
//

import SwiftUI

struct RedigerKort: View {
    
    var flashcard: Flashcard
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    
    
    @State private var redigeretNavn = ""
    @State private var redigeretKulhydrat = ""
    @State private var redigeretMåleenhed = "Gram"
    @State private var redigeretMængde = ""
    let muligeMåleenheder = ["Gram", "mL", "Antal"]
    @State private var mængdeværdiIndsatIndeIFlashcard = 0.0
    
    @State private var kulhydratDouble: Double = 0.0
    @State private var mængdeDouble: Double = 0.0
    @State private var totalBilledkortKulhydratAfrundet: String = "0 Gram"
    
    var body: some View {
        Text("Rediger Kort")
        List {
            Section(header: Text("Tilføj Billedkort")) {
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
                
                // Calculate the totalBilledkortKulhydratAfrundet here
                let billedkortKulhydratPr100Gram = Double(flashcard.kulhydrat) / Double(flashcard.mængde)
                let totalBilledkortKulhydrat = billedkortKulhydratPr100Gram * Double(mængdeværdiIndsatIndeIFlashcard)
                let totalBilledkortKulhydratAfrundet = String(format: "%.0f", totalBilledkortKulhydrat.rounded(.toNearestOrAwayFromZero))
                
                switch totalBilledkortKulhydrat {
                case _ where totalBilledkortKulhydrat > 1.0:
                    Text("\(totalBilledkortKulhydratAfrundet) gram")
                        .bold()
                        .font(.system(size: 20))
                        .padding(.leading, 0)
                        .padding(.bottom, 50)
                        .padding(.top, -10)
                case _ where totalBilledkortKulhydrat < 1.0:
                    Text("0 gram")
                        .bold()
                        .font(.system(size: 20))
                        .padding(.leading, 0)
                        .padding(.bottom, 50)
                        .padding(.top, -10)
                default:
                    Text("0 Gram")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    // Check if redigeretNavn is not empty and is different from the current value
                    if !redigeretNavn.isEmpty, redigeretNavn != flashcard.navn {
                        // Update the flashcard with the edited values
                        flashcardManager.updateCard(
                            in: deck,
                            cardID: flashcard.id,
                            newNavn: redigeretNavn,
                            newKulhydrat: flashcard.kulhydrat,
                            newMåleenhed: flashcard.måleenhed,
                            newMængde: flashcard.mængde,
                            newAktivMængde: mængdeDouble
                        )
                        // Recalculate values here
                        let billedkortKulhydratPr100Gram = Double(flashcard.kulhydrat) / Double(flashcard.mængde)
                        let totalBilledkortKulhydrat = billedkortKulhydratPr100Gram * Double(mængdeværdiIndsatIndeIFlashcard)
                        let totalBilledkortKulhydratAfrundetDouble = Double(totalBilledkortKulhydratAfrundet) ?? 0
                        // Update the UI or perform any actions with the recalculated values
                    }
                    // Repeat similar checks and updates for other fields
                    else if let redigeretKulhydrat = Double(redigeretKulhydrat), redigeretKulhydrat != flashcard.kulhydrat {
                        flashcardManager.updateCard(
                            in: deck,
                            cardID: flashcard.id,
                            newNavn: flashcard.navn,
                            newKulhydrat: redigeretKulhydrat,
                            newMåleenhed: flashcard.måleenhed,
                            newMængde: flashcard.mængde,
                            newAktivMængde: mængdeDouble
                        )
                        // Recalculate values here
                        let billedkortKulhydratPr100Gram = Double(flashcard.kulhydrat) / Double(flashcard.mængde)
                        let totalBilledkortKulhydrat = billedkortKulhydratPr100Gram * Double(mængdeværdiIndsatIndeIFlashcard)
                        let totalBilledkortKulhydratAfrundetDouble = Double(totalBilledkortKulhydratAfrundet) ?? 0
                        // Update the UI or perform any actions with the recalculated values
                    }
                    // Repeat for other conditions
                    else {
                        // Update only mængdeDouble if none of the above conditions are met
                        flashcardManager.updateCard(
                            in: deck,
                            cardID: flashcard.id,
                            newNavn: flashcard.navn,
                            newKulhydrat: flashcard.kulhydrat,
                            newMåleenhed: flashcard.måleenhed,
                            newMængde: flashcard.mængde,
                            newAktivMængde: mængdeDouble
                        )
                        // Recalculate values here
                        let billedkortKulhydratPr100Gram = Double(flashcard.kulhydrat) / Double(flashcard.mængde)
                        let totalBilledkortKulhydrat = billedkortKulhydratPr100Gram * Double(mængdeværdiIndsatIndeIFlashcard)
                        let totalBilledkortKulhydratAfrundetDouble = Double(totalBilledkortKulhydratAfrundet) ?? 0
                        // Update the UI or perform any actions with the recalculated values
                    }
                    dismiss()
                }) {
                    HStack {
                        Text("Done")
                    }
                }
            }
        }
    }
}
