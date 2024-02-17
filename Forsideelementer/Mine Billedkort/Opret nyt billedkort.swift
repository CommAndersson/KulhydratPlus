//
//  Opret nyt billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/02/2024.
//
import SwiftUI

struct OpretNytKort: View {
    
    @Environment(\.dismiss) private var dismiss

    @State var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    
    @State private var kulhydratDouble: Double = 0.0
    @State private var mængdeDouble: Double = 0.0
    
    @State private var mængdeværdiIndsatIndeIFlashcard = 0.0
    
    @State private var newNavn = ""
    @State private var newKulhydrat = ""
    @State private var newMåleenhed = "Gram"
    let muligeMåleenheder = ["Gram", "mL", "Antal"]
    @State private var newMængde = ""
    
    var body: some View {
        List {
            Section(header: Text("Tilføj Billedkort")) {
                TextField("Navn", text: $newNavn)
                Picker("Måleenhed", selection: $newMåleenhed) {
                    ForEach(muligeMåleenheder, id: \.self) { måleenhed in
                        Text(måleenhed)
                    }
                } //Text("\(flashcard.måleenhed):")
                .pickerStyle(.menu)
                TextField("Mængde \(newNavn) i \(newMåleenhed)", text: $newMængde)
                    .keyboardType(.decimalPad)
                TextField("Kulhydrater i fødevaren i gram (fx. 50)", text: $newKulhydrat)
                    .keyboardType(.decimalPad)
                Button("Add Flashcard") {
                    mængdeDouble = Double(newMængde) ?? 0.0 // Provide a default value if conversion fails
                    kulhydratDouble = Double(newKulhydrat) ?? 0.0
                    flashcardManager.addCard(to: deck, navn: newNavn, kulhydrat: kulhydratDouble, måleenhed: newMåleenhed, mængde: mængdeDouble, aktivMængde: mængdeværdiIndsatIndeIFlashcard)
                    newNavn = ""
                    newKulhydrat = ""
                    newMåleenhed = ""
                    newMængde = ""

                }
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                EditButton()
            }
            ToolbarItem(placement: .topBarLeading){
                Button{
                    dismiss()
                } label: {
                    HStack{
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
    }
      
}
   
