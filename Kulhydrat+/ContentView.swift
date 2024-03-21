//
//  ContentView.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 10/11/2023.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_status") var logStatus: Bool = false

    @StateObject var flashcardManager = FlashcardManager() // Assuming FlashcardManager is correctly initialized
    @State var selectedDeck: Deck? = nil // This is fine as is
    @StateObject var deck = Deck() // Now works with the new parameterless init()
    
    
   
    
    var body: some View {
        /*
        if logStatus{
            Text("")
        }else{
            LoginSide()
        }
        */
        
        
        NavigationView{
            
            ZStack{
                
                
                
                VStack{
                    Text("Kulhydrat+")
                        .font(.system(size: 60, weight: .bold))
                        .padding()
                        .foregroundColor(Color("GrønTekst"))
                        .padding(.top, 60)
                        .padding(.bottom, 10)
                        .textFieldStyle(.plain)
                        .background(Color.white)
                    
                    
                    HStack{
                        Image("Brød")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-20))
                            .padding(.trailing, 100)
                            .padding()
                        
                        
                        Image("Banana")
                            .resizable()
                            .frame(width: 100, height: 80)
                            .rotationEffect(.degrees(-20))
                            .padding(.trailing)
                            .padding(.bottom, 80)
                        
                    }
                    
                    HStack{
                        Image("Spaghetti")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-20))
                            .padding(.trailing, 50)
                            .padding(.leading, -30)
                            .padding(.bottom)
                        
                        Image("Fries")
                            .resizable()
                            .frame(width: 120, height: 80)
                            .rotationEffect(.degrees(-20))
                            .padding(.trailing, 50)
                            .padding(.leading)
                            .padding(.bottom, -30)
                        
                    }
                    
                    HStack{
                        Image("Burger")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(20))
                            .padding(.trailing, 30)
                            .padding(.leading, 150)
                            .padding(.bottom)
                        
                        
                        Image("Pizza")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(30))
                            .padding(.trailing, 50)
                            .padding(.leading)
                            .padding(.bottom, 150)
                        
                    }
                    .padding(.bottom, -30)
                    
                    
                    HStack{
                        Image("Juice")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(-20))
                            .padding(.trailing, 50)
                            .padding(.leading, 100)
                            .padding(.bottom, 100)
                        
                        
                        Image("Candy")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(20))
                            .padding(.trailing, 50)
                            .padding(.leading, 100)
                            .padding(.bottom)
                            .padding(.top, -150)
                        
                    }
                    
                }
                //.overlay(Color("BlåTilKnapper").opacity(0))
                
                VStack{
                  /*  NavigationLink(destination: KategoriSideGammel(), label:{
                        
                        ZStack{
                            Text("Kategorier")
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
                    */
                    /*
                    NavigationLink(destination: LoginSide(), label:{
                        
                        ZStack{
                            Text("Login")
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
                    */
                    
                    NavigationLink(destination: MineKort(), label:{
                        
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
                    .background(Color("GrønEmneBaggrund"))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .contentShape(Rectangle())
                    
                    
                    NavigationLink(destination: StartNytMåltid(flashcardManager: flashcardManager, selectedDeck: $selectedDeck, deck: deck)) {
                        
                        ZStack{
                            Text("Start Nyt Måltid")
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .padding(.bottom, 2)
                            
                            Rectangle()
                                .frame(width: 300, height: 50)
                                .foregroundColor(.black.opacity(0))
                            
                        }
                    }
                    .frame(width: 300, height: 50)
                    .background(Color("GrønEmneBaggrund"))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .contentShape(Rectangle())
                    
                    NavigationLink(destination:KategoriSide(categories: navigatableCategories), label:{
                        
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
                    .background(Color("GrønEmneBaggrund"))
                    .cornerRadius(10)
                    .padding(.bottom, 20)
                    .contentShape(Rectangle())
                
                    
                }
            }
            
            
            /*  NavigationLink(destination: Profil(), label:{
             
             ZStack{
             Text("Min Profil")
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
             */
            
            
            
            
            
        }
        
        .navigationTitle("Menu")
        .navigationBarHidden(true)
        
        
    }
    
    
    
    
    
    
    
    /* struct ContentView_Previews: PreviewProvider {
     @State var flashcardManager: FlashcardManager
     @Binding var selectedDeck: Deck?
     @ObservedObject var deck: Deck
     
     static var previews: some View {
     ContentView(flashcardManager: FlashcardManager(), selectedDeck: .constant(nil), deck: Deck())
     }
     }
     }*/
    
}

