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

                // Display the calculated total carbohydrates
                Text("Total Kulhydrater: \(calculatedTotalBilledkortKulhydrat, specifier: "%.0f") Gram")
                    .bold()
                    .font(.system(size: 20))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    // Convert the edited kulhydrat and mængde from String to Double
                    if let redigeretKulhydratDouble = Double(redigeretKulhydrat), let redigeretMængdeDouble = Double(redigeretMængde) {
                        // Call updateCard to update the flashcard with new values
                        flashcardManager.updateCard(
                            in: deck,
                            cardID: flashcard.id,
                            newNavn: redigeretNavn.isEmpty ? nil : redigeretNavn, // Use nil if no change to preserve existing value
                            newKulhydrat: redigeretKulhydratDouble,
                            newMåleenhed: redigeretMåleenhed,
                            newMængde: redigeretMængdeDouble,
                            newAktivMængde: mængdeværdiIndsatIndeIFlashcard // Assuming this is the value you want to update, adjust as necessary
                        )
                    }

                    // Dismiss the view after updating
                    dismiss()
                }
            }
        }
    }
}

                    /* // Repeat similar checks and updates for other fields
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
                     */
                
