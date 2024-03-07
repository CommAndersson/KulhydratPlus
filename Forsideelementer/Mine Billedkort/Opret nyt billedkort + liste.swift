//
//  Opret nyt billedkort + liste.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 09/02/2024.
//

import SwiftUI



struct DeckDetailView: View {
    
    @State private var showingDeleteAlert = false
    @State private var cardToDelete: UUID?
    
    @State private var isEditing = false
    
    @Environment(\.dismiss) private var dismiss
    
    @State var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 15)
    ]
    
    
    @State private var newNavn = ""
    @State private var newKulhydrat = ""
    @State private var newMåleenhed = "Gram"
    @State private var newMængde = ""
    
    var body: some View {
        VStack { // Added a VStack to wrap the content
            ZStack{
                NavigationLink(
                    destination: OpretNytKort(
                        flashcardManager: flashcardManager,
                        selectedDeck: $selectedDeck,
                        deck: deck
                    ), label: {
                        VStack {
                            Text("Opret nyt billedkort")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                            
                        }
                        
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .padding(.bottom, 2)
                        .frame(width: 300, height: 50)
                        
                        
                    }
                )
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("BlåTilKnapper"), lineWidth: 4)
                    .frame(width: 300, height: 50)
                
            }
            .frame(width: 300, height: 50)
            .background(Color("BlåTilKnapper").opacity(0.6))
            .cornerRadius(10)
            .padding(.bottom, 30)
            .contentShape(Rectangle())
            
            
            
            
            Text("Mine Billedkort")
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(deck.cards) { card in
                        VStack {
                            
                            ZStack{
                                if isEditing {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color("RoyalBlue")) // Adjust color and opacity as needed
                                        .frame(width: 130, height: 175) // Adjust size as needed
                                        .padding(.leading, -19)
                                        .padding(.bottom, 28)
                                }
                                NavigationLink(destination: FlashcardDetailView(flashcard: card, flashcardManager: flashcardManager, selectedDeck: $selectedDeck, deck: deck)) {
                                    VStack {
                                        Text(card.navn)
                                            .foregroundColor(.black)
                                            .font(.system(size: 20))
                                            .padding(.top, 35)
                                        if let image = card.image {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 90, height: 90)
                                                .cornerRadius(10)
                                                .padding(.bottom, 40)
                                        } else {
                                            // Show a placeholder if no image exists
                                            Image("placeholder") // Make sure to have a placeholder image
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 90, height: 90)
                                                .cornerRadius(10)
                                                .padding(.bottom, 40)
                                        }
                                        
                                    }
                                    .frame(width: 150, height: 150)
                                    .background(Color("BlåTilKnapper")) // Ensure this color exists in your asset catalog
                                    .cornerRadius(10)
                                    .padding(.trailing, 20)
                                }
                                
                                if isEditing {
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color.red)
                                            .frame(width: 80, height: 20)
                                        Button(action: {
                                            // Logic to delete the card
                                            cardToDelete = card.id
                                            showingDeleteAlert = true
                                        }) {
                                            Text("Slet Kort")
                                            //Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14))
                                                .bold()
                                            
                                            
                                            
                                        }
                                        .alert(isPresented: $showingDeleteAlert) {
                                            Alert(
                                                title: Text("Bekræft sletning"),
                                                message: Text("Er du sikker på, at du vil slette dette kort?"),
                                                primaryButton: .destructive(Text("Slet")) {
                                                    if let index = deck.cards.firstIndex(where: { $0.id == cardToDelete }) {
                                                        deck.cards.remove(at: index)
                                                    }
                                                },
                                                secondaryButton: .cancel(Text("Annuller"))
                                            )
                                        }
                                    }
                                    .padding(.bottom, 175)
                                    .padding(.leading, -20)
                                }
                                
                            }
                            
                        }
                        
                    }
                    .padding(.leading, 20)
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Færdig" : "Rediger") {
                        isEditing.toggle()
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
    }
    
    /* struct MineKortNavigationLinkView: View {
     let destination: AnyView
     let title: String
     let imageName: String
     var isEditing: Bool
     
     var body: some View {
     
     NavigationLink(destination: destination) {
     VStack {
     Text(title)
     .foregroundColor(.black)
     .font(.system(size: 20))
     .padding(.top, 35)
     Image(imageName) // Make sure this image exists in your asset catalog
     .resizable()
     .frame(width: 90, height: 90)
     .cornerRadius(10)
     .padding(.bottom, 40)
     }
     }
     .frame(width: 150, height: 150)
     .background(Color.blue) // Example Color
     .cornerRadius(10)
     .padding(.trailing, 20)
     .contentShape(Rectangle())
     .clipped()
     }
     }
     }
     */
}
