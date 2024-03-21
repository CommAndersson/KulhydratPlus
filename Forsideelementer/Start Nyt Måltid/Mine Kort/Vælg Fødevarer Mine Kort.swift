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
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -20),
        GridItem(.flexible(), spacing: 15)
    ]
    
    @State private var newNavn = ""
    @State private var newKulhydrat = ""
    @State private var newMåleenhed = ""
    @State private var newMængde = ""
    
    var body: some View {
        //Text("Vælg Fødevare")
        

        ScrollView {
                
                
                
            LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(deck.cards) { card in
                        NavigationLink(
                            destination: IndtastMængdeMineKort(
                                flashcard: card,
                                flashcardManager: flashcardManager,
                                selectedDeck: $selectedDeck,
                                deck: deck
                            ).environmentObject(mealViewModel),
                            label: {
                                VStack {
                                    Text(card.navn)
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                        .padding(.top, 35)
                                    Image("PlaceholderImage")
                                        .resizable()
                                        .frame(width: 90, height: 90)
                                        .cornerRadius(10)
                                        .padding(.bottom, 40)
                                }
                                
                            }
                            
                        )
                        .frame(width: 150, height: 150)
                        .background(Color("GrønEmneBaggrund"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                        
                    }
                    .onDelete { indexSet in
                        deck.removeCard(at: indexSet.first!)
                    }
                    .padding(.leading, 20)
                }
            .navigationTitle(Text("Vælg fødevarer fra \(deck.name)"))
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
