//
//  Vælg Fødevarer Mine Kort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 22/02/2024.
//

import SwiftUI


struct VælgFødevarerMineKort: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var mealViewModel: MealViewModel
    
    @State var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    
    
    @State private var newNavn = ""
    @State private var newKulhydrat = ""
    @State private var newMåleenhed = ""
    @State private var newMængde = ""
    
    var body: some View {
        Text("VælgFødevarerMineKort")
        

            List {
                
                
                
                Section(header: Text("Mine Billedkort")) {
                    ForEach(deck.cards) { card in
                        NavigationLink(
                            destination: IndtastMængdeMineKort(
                                flashcard: card,
                                flashcardManager: flashcardManager,
                                selectedDeck: $selectedDeck,
                                deck: deck
                            ).environmentObject(mealViewModel),
                            label: {
                                VStack(alignment: .leading) {
                                    Text("Navn: \(card.navn)")
                                    //Text("Kulhydrat: \(card.navn)")
                                    //Text("Måleenhed: \(card.måleenhed)")
                                }
                                
                            }
                            
                        )
                        .listStyle(.insetGrouped)
                        //.padding(.bottom, 20)
                        .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                        //.background(.white)
                        .scrollContentBackground(.hidden)
                        .environment(\.defaultMinListRowHeight, 50)
                        .environment(\.defaultMinListHeaderHeight, 10)
                        //.multilineTextAlignment(.center)
                    }
                    .onDelete { indexSet in
                        deck.removeCard(at: indexSet.first!)
                    }
                    .foregroundColor(.black)
                    .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                    .listRowSeparatorTint(.black)
                    .listRowBackground(Color("BlåTilKnapper"))
                    .listSectionSeparatorTint(.black)
                    .headerProminence(.increased)
                }
        
            }
           
        
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
