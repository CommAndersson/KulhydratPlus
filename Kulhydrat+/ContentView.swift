//
//  ContentView.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 10/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
                
            ZStack{
                
                VStack{
                
               
                Text("Kulhydrat+")
                    .font(.system(size: 40, weight: .bold))
                    .padding()
                    .foregroundColor(Color("RoyalBlue"))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
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
                .overlay(Color("Beige").opacity(0.3))
            
                
                VStack{
                NavigationLink("Kategorier", destination: KategoriSide())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 300, height: 50)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                    .padding(.top, -100)
                    .padding()
                    
                
            
                
                NavigationLink("Mine Kort", destination: MineKort())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 300, height: 50)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                    .padding(.top, -50)
                
                }
                .navigationTitle("Menu")
                .navigationBarHidden(true)
                
            }
            
            
            }
        
            
            
            
        }
    }
struct KategoriSide: View {
    var body: some View {
            
        ZStack{
            Color("Beige").opacity(0.8)
                .ignoresSafeArea()
            
            VStack{
                Text("Kategorier Her")
                
                NavigationLink("Fast Food", destination: FastFood())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 300, height: 50)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                    .padding(.top, -50)
            }
            .navigationTitle("Kategorier")
            
        
            
        }
        
        
    }
}



struct FastFood: View {
    var body: some View {
        
        ZStack{
            Color("Beige").opacity(0.8)
                .ignoresSafeArea()
            
            VStack{
            NavigationLink("McDonalds", destination: McDonalds())
                .foregroundColor(.black)
                .font(.system(size: 20))
                .frame(width: 300, height: 50)
                .background(Color("MetallicGold"))
                .cornerRadius(10)
                .padding(.top, -100)
                .padding()
                
            
        
            
            NavigationLink("Burger King", destination: BurgerKing())
                .foregroundColor(.black)
                .font(.system(size: 20))
                .frame(width: 300, height: 50)
                .background(Color("MetallicGold"))
                .cornerRadius(10)
                .padding(.top, -50)
            
            }
            .navigationTitle("Fast Food")
        
            
        
            
        }
        
        
    }
}

// Kategorier af Fast Food
struct McDonalds: View {
    var body: some View {
        ZStack{
            Color("Beige").opacity(0.8)
                .ignoresSafeArea()
            
            VStack{
                
                HStack{
            
                    
                    VStack{
                        NavigationLink("Cheese Burger", destination: CheeseBurger())
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .padding(.top, 45)
                            
                            
                            
                        
                        Image("McDonaldsCheeseburger")
                            .resizable()
                            .frame(width: 100, height: 80)
                            .padding(.bottom, 40)
                        
                    
                        
                    }
                    .frame(width: 150, height: 150)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                    
                    
                        NavigationLink("Tasty Cheese", destination: TastyCheese())
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .frame(width: 150, height: 150)
                            .background(Color("MetallicGold"))
                            .cornerRadius(10)
                
                        
                        
                    
                    
            }
                .padding(.bottom, 20)
                
                
            HStack{
                
                NavigationLink("Hamburger", destination: Hamburger())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 150, height: 150)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                
                
                NavigationLink("Double Super Cheese", destination: DoubleSuperCheese())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 150, height: 150)
                    .background(Color("MetallicGold"))
                    .cornerRadius(10)
                
                
            }
            
        }
    }
}
}


struct BurgerKing: View {
    var body: some View {
        
        Text("Mine Kort")
    }
}

// Kategorier af mad hos McDonalds

struct CheeseBurger: View {
    var body: some View {
        
        Text("Cheeseburger")
    }
}


struct TastyCheese: View {
    var body: some View {
        
        Text("Tasty Cheese")
    }
}
    
    
struct Hamburger: View {
    var body: some View {
        
        Text("Hamburger")
    }
}


struct DoubleSuperCheese: View {
    var body: some View {
        
        Text("Double Super Cheese")
    }
}

    






//Kategorier af mad hos Burger King








struct MineKort: View {
    var body: some View {
        
        Text("Mine Kort")
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

