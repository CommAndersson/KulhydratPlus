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
    var carbohydratePer100g: Double  // Amount of carbohydrate per 100 grams or any other unit
    var måleenhed: String
    var mængde: Double // Amount or quantity that kulhydrat refers to
    var kulhydrat: Double
    
    init(name: String, kulhydrat: Double, måleenhed: String, mængde: Double) {
            self.name = name
            self.kulhydrat = kulhydrat
            self.måleenhed = måleenhed
            self.mængde = mængde
            self.carbohydratePer100g = kulhydrat / mængde // Calculate carbs per 100g based on given kulhydrat and mængde
        }
    
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
        switch flashcard.måleenhed {
         case "Gram", "mL":
             return (amount / 100.0) * flashcard.carbohydratePer100g
         case "Antal":
             return amount * flashcard.carbohydratePer100g
         default:
             return 0.0 // Handle unexpected unit or add more cases as needed
         }
     }
    
    
    @StateObject var flashcardManager = FlashcardManager()
    @State private var newDeckName = ""
    @State private var selectedDeck: Deck?
    @StateObject var flashcardCreationManager = FlashcardCreationManager()
}


struct StartNytMåltid: View {
    
    @EnvironmentObject var mealViewModel: MealViewModel
    
    @State private var isShowingVælgFødevarerMineKort = false
    
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
                
                ZStack{
                    
                    Rectangle()
                        .frame(width: 350, height: 150)
                        .foregroundColor(Color("BlåTilKnapper").opacity(0.6))
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                        .padding(.top, -30)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 350, height: 150)
                        .padding(.bottom, 10)
                        .padding(.top, -30)
                    
                    Rectangle()
                        .frame(width: 150, height: 40)
                        .foregroundColor(.white.opacity(0.9))
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                        .padding(.top, 42)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 150, height: 40)
                        .padding(.bottom, 10)
                        .padding(.top, 42)
                    
                    
                    VStack{
                        Text("Kulhydrater i Måltid:")
                            .bold()
                        // .padding(.bottom)
                        //.padding(.top, 40)
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                            .padding(.bottom, 30)
                        
                        switch mealViewModel.totalCarbs {
                        case _ where mealViewModel.totalCarbs > 0 :
                            Text("\(mealViewModel.totalCarbs, specifier: "%.0f")g")
                                .font(.system(size: 22))
                                .bold()
                            //.padding(.top, -30)
                                .padding(.bottom, 10)
                        default:
                            Text("0g")
                                .font(.system(size: 22))
                                .bold()
                            //.padding(.top, -30)
                                .padding(.bottom, 10)
                        }
                    }
                    .padding(.top, -30)
                }
                .padding(.top, 40)
                .padding(.bottom, 50)
                
                
                
                // Button to add food, which shows VælgOverblik
                ZStack{
                    Button("Tilføj Fødevare") {
                        showingVælgOverblik = true
                        
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.bottom, 2)
                    .frame(width: 300, height: 50)
                    
                    Rectangle()
                        .frame(width: 300, height: 50)
                        .foregroundColor(.black.opacity(0))
                    
                }
                .frame(width: 350, height: 50)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.bottom, 30)
                .contentShape(Rectangle())
                
                // Handling sheet presentation for VælgOverblik
                .sheet(isPresented: $showingVælgOverblik) {
                    VælgOverblik(flashcardManager: flashcardManager, selectedDeck: $selectedDeck, deck: deck, flashcardCreationManager: flashcardCreationManager)
                        .environmentObject(mealViewModel)
                }
                
                // Listening to changes for navigating back
                .onChange(of: mealViewModel.shouldNavigateBackToStartNytMåltid) { newValue in
                    if newValue {
                        showingVælgOverblik = false // This will dismiss the sheet
                        mealViewModel.shouldNavigateBackToStartNytMåltid = false // Reset the flag
                    }
                }
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 350, height: 400)
                        .padding(.bottom, 10)
                        .padding(.top, -30)
                    
                    
                    VStack{
                        
                        ZStack{
                            List {
                                
                                ForEach(mealViewModel.mealItems) { item in
                                    HStack {
                                        Text(item.flashcard.name) // Display the name of the flashcard
                                        Spacer()
                                        // Display the calculated carbs for each item, formatted to 2 decimal places
                                        Text("\(item.calculatedCarbs, specifier: "%.0f")g Kulhydrat")
                                    }
                                }
                                .onDelete(perform: deleteItems) // Enables swipe to delete functionality
                                .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                                .foregroundColor(.black)
                                .listRowSeparatorTint(.black)
                                .listRowBackground(Color("RoyalBlue"))
                                .listSectionSeparatorTint(.black)
                                .headerProminence(.increased)
                                
                                
                            }
                            .frame(height: 380)
                            .clipped()
                            .listStyle(.insetGrouped)
                            .scrollContentBackground(.hidden)
                            .padding(.horizontal, 20)
                            .padding(.top, -10)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 340, height: 30)
                                .padding(.bottom, 390)
                                .cornerRadius(10)
                            
                            Text("Fødevarer i Måltid:")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 40)
                                .bold()
                                .padding(.bottom, -20)
                                .padding(.top, -205)
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        .toolbar{
                            ToolbarItem(placement: .topBarTrailing){
                                EditButton()
                            }
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button(action: { dismiss() }) {
                                    Image(systemName: "arrow.backward")
                                }
                            }
                        }
                    }
                }
                
            }
            
            
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func calculateTotalCarbs() {
        DispatchQueue.main.async {
            self.totalCarbs = self.mealItems.reduce(0) { $0 + $1.calculatedCarbs }
        }
    }
        
        private func deleteItems(at offsets: IndexSet) {
            mealViewModel.mealItems.remove(atOffsets: offsets)
            calculateTotalCarbs() // Recalculate total carbs after deletion
        }}
    


