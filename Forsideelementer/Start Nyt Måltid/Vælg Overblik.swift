//
//  Vælg Overblik.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI

struct VælgOverblik: View {
    @ObservedObject var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    @StateObject var flashcardCreationManager = FlashcardCreationManager()
    
    @State private var newDeckName = ""
    @State private var mealItems: [MealItem] = [] // To store selected flashcards with amounts
    @State private var showingFlashcardPicker = false // To show or hide the flashcard picker
    @State private var showingVælgOverblik = false
    @State private var totalCarbs = 0.0
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var mealViewModel: MealViewModel
    
    var body: some View {
       // Text("Vælg overblik")
        NavigationView{
            VStack{
                Text("Vælg Overblik")
                
                NavigationLink(destination: KategoriSide(), label:{
                    
                    ZStack{
                        Text("Kulhydrat+ Kategorier")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.bottom, 2)
                        
                        Rectangle()
                            .frame(width: 300, height: 50)
                            .foregroundColor(.black.opacity(0))
                        
                    }
                })
                .frame(width: 300, height: 50)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .contentShape(Rectangle())
                
                
                NavigationLink(destination: FlashcardPicker(selectedFlashcards: $mealItems, flashcardManager: flashcardManager, selectedDeck: $selectedDeck, deck: deck, flashcardCreationManager: flashcardCreationManager), label: {
                    
                    ZStack{
                        Text("Mine Kort")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.bottom, 2)
                        
                        Rectangle()
                            .frame(width: 300, height: 50)
                            .foregroundColor(.black.opacity(0))
                        
                    }
                })
                .frame(width: 300, height: 50)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .contentShape(Rectangle())
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward")
                        }
                    }
                }

            }
            
        }
        
    }
}
