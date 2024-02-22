//
//  Start Nyt Måltid.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI

struct FlashcardNytMåltid: Identifiable {
    let id = UUID()
    var name: String
    var carbohydratePer100g: Double // Amount of carbohydrate per 100 grams or any other unit
    
    @StateObject var flashcardManager = FlashcardManager()
    @State private var newDeckName = ""
    @State private var selectedDeck: Deck?
    @StateObject var flashcardCreationManager = FlashcardCreationManager()
}

struct MealItem: Identifiable {
    let id = UUID() // Unique identifier for each MealItem
    var flashcard: FlashcardNytMåltid
    var amount: Double
    var calculatedCarbs: Double {
        (amount / 100.0) * flashcard.carbohydratePer100g
    }
    
    @StateObject var flashcardManager = FlashcardManager()
    @State private var newDeckName = ""
    @State private var selectedDeck: Deck?
    @StateObject var flashcardCreationManager = FlashcardCreationManager()
}


struct StartNytMåltid: View {
    
    @EnvironmentObject var mealViewModel: MealViewModel
    
    // Correctly use @ObservedObject for externally initialized ObservableObjects
    @ObservedObject var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    @StateObject var flashcardCreationManager = FlashcardCreationManager()

    // @State and @StateObject properties can stay as is since they are correctly used
    @State private var newDeckName = ""
    @State private var mealItems: [MealItem] = [] // To store selected flashcards with amounts
    @State private var showingFlashcardPicker = false // To show or hide the flashcard picker
    @State private var showingVælgOverblik = false
    @State private var totalCarbs = 0.0
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack {
                Text("Total Mængde Kulhydrater i Måltid:")
                    .font(.title3)
                    .bold()
                    .padding(.bottom)
                
                if mealViewModel.totalCarbs > 0 {
                    Text("\(mealViewModel.totalCarbs, specifier: "%.0f")g")
                        .font(.headline)
                        .padding()
                }
                
              /*  List {
                    ForEach(mealViewModel.mealItems) { item in
                        HStack {
                            Text(item.flashcard.name)
                            Spacer()
                            Text("\(item.calculatedCarbs, specifier: "%.2f")g carbs")
                        }
                    }
                    .onDelete(perform: deleteItems)
                } */
                //}
                ZStack{
                    
                    Button("Tilføj Fødevare") {
                        showingVælgOverblik = true
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
                    
                    Rectangle()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.black.opacity(0))
                    
                    
                        .sheet(isPresented: $showingVælgOverblik) {
                            VælgOverblik(flashcardManager: flashcardManager, selectedDeck: $selectedDeck, deck: deck, flashcardCreationManager: flashcardCreationManager)
                        }
                }
                .frame(width: 300, height: 50)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .contentShape(Rectangle())
                
                List {
                    Section(header: Text("Mine Billedkort")) {
                        ForEach(deck.cards) { card in
                            VStack(alignment: .leading) {
                                Text("Navn: \(card.navn)")
                                // Optionally include additional details here
                                // Text("Kulhydrat: \(card.kulhydrat)")
                                // Text("Måleenhed: \(card.måleenhed)")
                            }
                            .padding(.vertical, 8) // Add padding for better tap target size if needed
                            .foregroundColor(.black) // Ensure text color is black for visibility
                            .listRowInsets(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)) // Adjust insets as needed
                            .listRowBackground(Color("BlåTilKnapper")) // Set the background color for the list row
                        }
                        .onDelete { indexSet in
                            deck.removeCard(at: indexSet.first!)
                        }
                    }
                }
                .listStyle(.insetGrouped)
                .padding(.bottom, 20)
                .background(.white)
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 50)
                .environment(\.defaultMinListHeaderHeight, 10)
                
                
              /*  ZStack{
                    Button("Beregn Kulhydrater") {
                        calculateTotalCarbs()
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
                    
                    Rectangle()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.black.opacity(0))
                }
                .frame(width: 300, height: 50)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.bottom, 20)
                .contentShape(Rectangle()) */
                
                if mealViewModel.totalCarbs > 0 {
                    Text("Total Mængde Kulhydrater: \(mealViewModel.totalCarbs, specifier: "%.0f")g")
                        .font(.headline)
                        .padding()
                }
                
                
            }
            .padding(.bottom, 500)
            
        }//
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
        
        
    private func calculateTotalCarbs() {
        mealViewModel.totalCarbs = mealViewModel.mealItems.reduce(0) { $0 + $1.calculatedCarbs }
    }
    
private func deleteItems(at offsets: IndexSet) {
    mealViewModel.mealItems.remove(atOffsets: offsets)
}
    }

    



    
