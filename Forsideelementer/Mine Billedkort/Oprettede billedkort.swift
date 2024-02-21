//
//  Oprettede billedkort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/02/2024.
//

import SwiftUI

extension Formatter {
    static let lucNumberFormatBilledkort: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}

struct FlashcardDetailView: View {
    
    var calculatedTotalBilledkortKulhydrat: Double  {
            let billedkortKulhydratPr100Gram = flashcard.kulhydrat / flashcard.mængde * 100
            return billedkortKulhydratPr100Gram * mængdeværdiIndsatIndeIFlashcard / 100
        }
    

   
    @Environment(\.dismiss) private var dismiss
    
    var flashcard: Flashcard
    
    @StateObject var flashcardManager: FlashcardManager
    @Binding var selectedDeck: Deck?
    @ObservedObject var deck: Deck
    
    @State private var mængdeværdiIndsatIndeIFlashcard = 0.0
    
    @State private var BilledkortGram = 0
    @State private var newNavn = ""
    @State private var newKulhydrat = ""
    @State private var newMåleenhed = "Gram"
    let muligeMåleenheder = ["Gram", "mL", "Antal"]
    @State private var newMængde = 0
    @State private var totalBilledkortKulhydratAfrundetDouble = 0.0
    
    var formattedLucNumber: String {
        Formatter.lucNumberFormatBilledkort.string(from: NSNumber(value: Double(calculatedTotalBilledkortKulhydrat)))!
    }

    // Initialize newKulhydratDouble with a default value
    
    
    
    @State private var kulhydratDouble: Double = 0.0
    
    
    
    
    
    
    
    init(flashcard: Flashcard, flashcardManager: FlashcardManager, selectedDeck: Binding<Deck?>, deck: Deck) {
        self.flashcard = flashcard
        self._flashcardManager = StateObject(wrappedValue: flashcardManager)
        self._selectedDeck = selectedDeck
        self._deck = ObservedObject(wrappedValue: deck)  // Assuming deck is non-optional, replace it accordingly
    }
    
    
    var body: some View {
        
        ZStack{
            
            //Color("BlåTilKnapper").opacity(0.3)
              //  .ignoresSafeArea()
            
            VStack{
                
                ZStack{
                    Rectangle()
                        .frame(width: 240, height: 50)
                        .foregroundColor(Color("BlåTilKnapper").opacity(0.8))
                        .cornerRadius(20)
                        .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 240, height: 50)
                        .padding()
                    
                    Text("\(flashcard.navn)")
                        .bold()
                        .font(.title3)
                }
                .padding(.top, 200)
                .padding(.bottom, -50)
                
                
                
                ZStack{
                    Rectangle()
                        .frame(width: 330, height: 140)
                        .foregroundColor(Color("BlåTilKnapper").opacity(0.6))
                        .cornerRadius(20)
                        .padding(.bottom, 40)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 330, height: 140)
                        .padding(.bottom, 40)
                    
                    
                    HStack{
                        
                        VStack{
                            Text("\(flashcard.måleenhed):")
                                .bold()
                                .padding(.leading, -10)
                                .font(.system(size: 24))
                                .padding(.top, 40)
                                .padding(.bottom, -25)
                            
                            ZStack{
                                Rectangle()
                                    .frame(width: 100, height: 40)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                    .padding(.bottom, 50)
                                    .padding(.top, 25)
                                    .padding(.leading, -5)
                                    .padding(.trailing, 5)
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                    .frame(width: 100, height: 40)
                                    .padding(.bottom, 50)
                                    .padding(.top, 25)
                                    .padding(.leading, -5)
                                    .padding(.trailing, 5)
                                
                                
                                TextField("Mængde", value: $mængdeværdiIndsatIndeIFlashcard, formatter: Formatter.lucNumberFormatBilledkort)
                                    .keyboardType(.numberPad)
                                    .font(.title3)
                                    .frame(width: 120, height: 80)
                                    .clipped()
                                    .padding(.trailing, -20)
                                    .padding(.bottom, 50)
                                    .padding(.top, 25)
                                    .padding(.leading, 15)
                                
                                
                                
                            }
                            
                        }
                        .padding(.bottom, 50)
                        .padding(.top, 60)
                        
                        
                        VStack{
                            Text("Kulhydrater:")
                                .bold()
                                .font(.system(size: 24))
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 40)
                                .padding(.top, 30)
                            
                            
                            
                           /* let billedkortKulhydratPr100Gram = Double(flashcard.kulhydrat) / Double(flashcard.mængde)
                            let totalBilledkortKulhydrat = billedkortKulhydratPr100Gram * Double(mængdeværdiIndsatIndeIFlashcard)
                            let totalBilledkortKulhydratAfrundet = String (format: "%.0f", totalBilledkortKulhydrat.rounded(.toNearestOrAwayFromZero))
                            
                            var totalBilledkortKulhydratAfrundetDouble = Double(totalBilledkortKulhydratAfrundet) ?? 0 */
                            
                            switch calculatedTotalBilledkortKulhydrat {
                            case _ where calculatedTotalBilledkortKulhydrat > 1.0:
                                Text(String(format: "%.0f Gram", calculatedTotalBilledkortKulhydrat))
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.leading, 0)
                                    .padding(.bottom, 50)
                                    .padding(.top, -10)
                            case _ where calculatedTotalBilledkortKulhydrat < 1.0:
                                Text("0 Gram")
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.leading, 0)
                                    .padding(.bottom, 50)
                                    .padding(.top, -10)
                            default:
                                Text("0 Gram")
                                    .bold()
                                    .font(.system(size: 20))
                                    .padding(.leading, 0)
                                    .padding(.bottom, 50)
                                    .padding(.top, -10)
                                
                                
                            }
                            
                                
                            
                        }
                        
                        
                    }
                    .padding(.bottom, 60)
                    .padding(.top, 30)
                    .padding(.trailing, 20)
                    
                }
                
                
                .padding(.top, -30)
                //.padding(.bottom, 50)
                
                
                ZStack{
                    
                    Rectangle()
                        .frame(width: 330, height: 330)
                        .cornerRadius(10)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Image("Pære")
                        .resizable()
                        .cornerRadius(10)
                        .frame(width: 325, height: 325)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 4)
                        .frame(width: 330, height: 330)
                    
                    
                }
                .padding(.top, -80)
                .padding(.bottom, 320)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ForEach(deck.cards) { card in
                    NavigationLink(
                        destination: RedigerKort(
                            flashcard: card,
                            flashcardManager: flashcardManager,
                            selectedDeck: $selectedDeck,
                            deck: deck
                            
                        )
                    ) {
                        Text("Edit")
                    }
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "arrow.backward")
                        //Text("Back")
                    }
                }
            }
        }
        
        
        
    }
    }
