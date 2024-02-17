//
//  Kategoriside.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/11/2023.
//

import SwiftUI



    

struct KategoriSide: View {
    var body: some View {
            
        
        
        ZStack{
            //Color("BlåTilKnapper").opacity(0.3)
             // .ignoresSafeArea()
            
            VStack{
            
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
            
            
            VStack{
                
                
                NavigationLink(destination: BælgfrugterOgLignende(),label:{
                    ZStack{
                        Text("Bælgfrugter og Lignende")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                    
                        Rectangle()
                        .frame(width: 280, height: 50)
                        .foregroundColor(.black.opacity(0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("RoyalBlue"), lineWidth: 4)
                            .frame(width: 300, height: 50)
                            .padding()
                        
                      
            
                    }
                })
                        .frame(width: 300, height: 50)
                        .background(Color("BlåTilKnapper"))
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                
                
                    
                NavigationLink(destination: FastFood(), label:{
                    
                    ZStack{
                        Text("Fast Food")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                    
                        Rectangle()
                        .frame(width: 280, height: 50)
                        .foregroundColor(.black.opacity(0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("RoyalBlue"), lineWidth: 4)
                            .frame(width: 300, height: 50)
                            .padding()
                        
                        
            
                    }
                })
                
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .frame(width: 300, height: 50)
                        .background(Color("BlåTilKnapper"))
                        .cornerRadius(10)
                        .padding(.bottom, 20)
                
                
                NavigationLink(destination: Frugt(), label:{
                    
                    ZStack{
                        Text("Frugt")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                    
                        Rectangle()
                        .frame(width: 280, height: 50)
                        .foregroundColor(.black.opacity(0))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("RoyalBlue"), lineWidth: 4)
                            .frame(width: 300, height: 50)
                            .padding()
                        
            
                    }
                })
                
                        .foregroundColor(.black)
                        .font(.system(size: 20))
                        .frame(width: 300, height: 50)
                        .background(Color("BlåTilKnapper"))
                        .cornerRadius(10)
                       
                
            }
                
            }
            .navigationTitle("Kategorier")
            
            

            
        }
      
        }
        
    

      
