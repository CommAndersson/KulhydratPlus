//
//  Opret nyt billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/02/2024.
//
import SwiftUI

struct OpretNytKort: View {
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.dismiss) private var dismiss

    
    @ObservedObject var flashcardManager: FlashcardManager
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
    
    @State private var showingImagePicker = false
        @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack{
            Color("GrønBaggrund")
                .ignoresSafeArea()
        VStack{
            
            
            ZStack{
                
                Rectangle()
                    .frame(width: 150, height: 40)
                    .foregroundColor(Color("GrønEmneBaggrund").opacity(0.6))
                    .cornerRadius(10)
                    .cornerRadius(10)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 150, height: 40)
                
                Text("Opret Kort")
                    .font(.system(size: 20))
                    .bold()
            }
            .padding(.bottom, -70)
            .padding(.top, 20)
            ZStack{
                List {
                    Section(header: Text("Indtast Værdier:")) {
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
                    }
                }
                .scrollContentBackground(.hidden)
                .scrollDisabled(true)
                .background(Color("GrønBaggrund"))
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 350, height: 230)
                    .padding(.bottom, 200)
                
            }
            
            .padding(.top, 70)
            
            
            ZStack{
                Button("Vælg et billede") {
                    showingImagePicker = true
                }
                .foregroundColor(.black)
                .font(.system(size: 20))
                .padding(.bottom, 2)
                .frame(width: 300, height: 50)
                
                Rectangle()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.black.opacity(0))
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
            }
            .frame(width: 350, height: 50)
            .background(Color("GrønEmneBaggrund"))
            .cornerRadius(10)
            .padding(.bottom, 30)
            .contentShape(Rectangle())
            .padding(.bottom, 280)
            .padding(.top, -150)
            
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("GrønEmneBaggrund").opacity(0.2))
                    .frame(width: 200, height: 200)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 200, height: 200)
                
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 190, height: 190)
                        .cornerRadius(10)
                }
                
                
                
                
                
            }
            .padding(.top, -300)
            
            
            
            Button("Tilføj Kort") {
                guard !newNavn.isEmpty else {
                    alertMessage = "Giv venligst kortet et navn."
                    showingAlert = true
                    return
                }
                let imageData = selectedImage?.jpegData(compressionQuality: 1.0)
                
                if deck.cards.contains(where: { $0.navn == newNavn }) {
                    alertMessage = "Et kort med navnet '\(newNavn)' findes allerede i denne kategori."
                    showingAlert = true
                } else {
                    if let kulhydratDouble = Double(newKulhydrat), let mængdeDouble = Double(newMængde) {
                        flashcardManager.addCard(to: deck, navn: newNavn, kulhydrat: kulhydratDouble, måleenhed: newMåleenhed, mængde: mængdeDouble, aktivMængde: mængdeværdiIndsatIndeIFlashcard, imageData: imageData)
                        
                        // Reset the fields after adding
                        newNavn = ""
                        newKulhydrat = ""
                        newMåleenhed = "Gram" // Reset to default value if needed
                        newMængde = ""
                        selectedImage = nil
                    }
                    dismiss()
                }
            }
            .frame(width: 150, height: 50)
            .background(Color("GrønEmneBaggrund"))
            .foregroundColor(.black)
            .bold()
            .font(.system(size: 18))
            .cornerRadius(10)
            .padding(.bottom, 30)
            .contentShape(Rectangle())
            .padding(.bottom, 20)
            .padding(.top, -90)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
        .padding(.bottom, 50)
        .navigationBarBackButtonHidden(true)
        .toolbar{
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
   
