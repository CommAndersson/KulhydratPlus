//
//  Mine Billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 02/02/2024.
//

import SwiftUI

struct MineKort: View {
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    
    
    @Environment(\.dismiss) private var dismiss
    
    
        @StateObject var flashcardManager = FlashcardManager()
        @State private var newDeckName = ""
        @State private var selectedDeck: Deck?
        @StateObject var flashcardCreationManager = FlashcardCreationManager()
        
    var body: some View {
        ZStack{
            Color("GrønBaggrund")
                .ignoresSafeArea()
                .opacity(0.4)
        VStack {
            ZStack{
                Rectangle()
                    .frame(width: 360, height: 250)
                    .foregroundColor(Color("GrønEmneBaggrund"))
                    .cornerRadius(10)
                    .padding(.bottom, 70)
                    .padding(.top, 10)
                
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
                    .frame(width: 360, height: 250)
                    .padding(.bottom, 70)
                    .padding(.top, 10)
                VStack {
                    Section(header: Text("Tilføj Ny Kategori") .font(.title3) .bold())
                    {
                        VStack {
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(Color.white)
                                
                                TextField("Navngiv din kategori", text: $newDeckName)
                                    .multilineTextAlignment(.center)
                                //.foregroundStyle(.black)
                                    .font(.system(size: 20))
                                
                                Rectangle()
                                    .frame(width: 300, height: 50)
                                    .foregroundColor(.black.opacity(0))
                                
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 300, height: 50)
                                    .padding()
                            }
                            ZStack{
                                Button("Gem") {
                                    if flashcardManager.decks.contains(where: { $0.name == newDeckName }) {
                                        alertMessage = "En kategori med navnet '\(newDeckName)' findes allerede."
                                        showingAlert = true
                                    } else {
                                        flashcardManager.addDeck(name: newDeckName)
                                        newDeckName = ""
                                    }
                                }
                                .font(.system(size: 20))
                                .frame(width: 300, height: 50)
                                .background(Color("GrønBaggrund"))
                                .foregroundColor(Color("GrønTekst"))
                                .cornerRadius(10)
                                .padding(.bottom, 20)
                                .contentShape(Rectangle())
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                }
                                
                                
                                
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 300, height: 50)
                                    .padding(.bottom, 20)
                                
                            }
                        }
                    }
                }
                .padding(.bottom, 15)
                .padding(.top, -20)
                /* .frame(width: 360, height: 250)
                 .background(Color("OceanGreen"))
                 .cornerRadius(10)
                 .padding(.bottom, 70)
                 .contentShape(Rectangle())
                 .padding(.top, 10) */
                
                
                /*   RoundedRectangle(cornerRadius: 10)
                 .stroke(.black, lineWidth: 4)
                 .frame(width: 360, height: 250)
                 .padding(.bottom, 70)
                 .padding(.top, 10) */
            }
            
            ZStack{
                
                List {
                    Section{
                        ForEach(flashcardManager.decks) { deck in
                            NavigationLink(
                                destination: DeckDetailView(
                                    flashcardManager: flashcardManager,
                                    selectedDeck: $selectedDeck,
                                    deck: deck
                                )
                            ) {
                                
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
                //.background(Color("GrønBaggrund") .opacity(0.4))
                .scrollContentBackground(.hidden)
                .environment(\.defaultMinListRowHeight, 50)
                .environment(\.defaultMinListHeaderHeight, 10)
                
                Rectangle()
                    .fill(Color("GrønBaggrund") .opacity(0))
                    .frame(width: 400, height: 30)
                    .padding(.bottom, 390)
                
                
                Text("Mine Kategorier:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 22)
                    .bold()
                    .padding(.bottom, -20)
                    .padding(.top, -205)
                
                
            }
        }
    }
                .navigationTitle("")
                .padding(.top, 30)
            
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
        
