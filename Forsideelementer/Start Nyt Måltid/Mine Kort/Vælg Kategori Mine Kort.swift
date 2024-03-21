//
//  FlashcardPicker.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI

struct FlashcardPicker: View {
    @Environment(\.dismiss) private var dismiss
       @Binding var selectedFlashcards: [MealItem]
       @ObservedObject var flashcardManager: FlashcardManager
       @Binding var selectedDeck: Deck?
       @ObservedObject var deck: Deck
       @ObservedObject var flashcardCreationManager: FlashcardCreationManager
    @EnvironmentObject var mealViewModel: MealViewModel
        
        var body: some View {
            
                VStack {
                   
                    List {
                        Text("Vælg Kategori Fra Mine Kort")
                        Section{
                            ForEach(flashcardManager.decks) { deck in
                                NavigationLink(destination: VælgFødevarerMineKort(
                                    flashcardManager: flashcardManager,
                                    selectedDeck: $selectedDeck,
                                    deck: deck))
                                {
                                    Text(deck.name)
                                }
                                
                            }
                            
                            .onDelete { indexSet in
                                flashcardManager.decks.remove(atOffsets: indexSet)
                            }
                            .foregroundColor(.black)
                            .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                            .listRowSeparatorTint(.black)
                            .listRowBackground(Color("GrønEmneBaggrund"))
                            .listSectionSeparatorTint(.black)
                            .headerProminence(.increased)
                            
                        }
                    }
                    .listStyle(.insetGrouped)
                    .padding(.bottom, 20)
                    .listRowInsets(.init(top: 0, leading: 60, bottom: 50, trailing: 60))
                    .background(.white)
                    .scrollContentBackground(.hidden)
                    .environment(\.defaultMinListRowHeight, 50)
                    .environment(\.defaultMinListHeaderHeight, 10)
                    
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
               // .navigationTitle("")
                //.padding(.top, 0)
            
        }
