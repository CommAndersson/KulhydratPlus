//
//  Frugt.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 21/11/2023.
//

import SwiftUI

struct Frugt: View {
    var body: some View {
        
        ScrollView{
        
        ZStack{
            
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
            
           // Color("Beige").opacity(0.8)
              //  .ignoresSafeArea()
            
                
                
        VStack{
            
            HStack{
        
                NavigationLink(destination: Abrikos(), label:{
                    VStack{
                        
                        Text("Abrikos")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                    
                        Image("Abrikos")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
                            
                
                    }
                })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 15)
                .contentShape(Rectangle())
                .clipped()
                
                
               NavigationLink(destination: Abrikos(), label:{
                    VStack{
                    
                        Text("Abrikos")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                        
                        Image("Couscous")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
            
                }
            })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 15)
                .contentShape(Rectangle())
                .clipped()
        
    
            }
            .padding(.bottom, 20)
            .padding(.leading, 15)
            
            
            
            HStack{
        
                NavigationLink(destination: Hummus(), label:{
                    VStack{
                        
                        Text("Hummus")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                    
                        Image("Hummus")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
                            
                            
                
                    }
                })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
               NavigationLink(destination: Kikærter(), label:{
                    VStack{
                    
                        Text("Kikærter")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                        
                        Image("Kikærter")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
            
                }
            })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
        
    
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            
            HStack{
        
                NavigationLink(destination: Linser(), label:{
                    VStack{
                        
                        Text("Linser")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                    
                        Image("Linser")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
                            
                            
                
                    }
                })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
             NavigationLink(destination: Perlespelt(), label:{
                    VStack{
                    
                        Text("Perlespelt")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                        
                        Image("Perlespelt")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
            
                }
            })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
        
    
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
            
            
            HStack{
        
                NavigationLink(destination: Kidneybønner(), label:{
                    VStack{
                        
                        Text("Røde Kidneybønner")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                    
                        Image("Kidneybønner")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
                            
                            
                
                    }
                })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
            NavigationLink(destination: Quinoa(), label:{
                    VStack{
                    
                        Text("Quinoa")
                           .foregroundColor(.black)
                           .font(.system(size: 20))
                           .padding(.top, 35)
                        
                        Image("Quinoa")
                            .resizable()
                            .frame(width: 90, height: 90)
                            .cornerRadius(10)
                            .padding(.bottom, 40)
            
                }
            })
                .frame(width: 150, height: 150)
                .background(Color("BlåTilKnapper"))
                .cornerRadius(10)
                .padding(.trailing, 20)
                .contentShape(Rectangle())
                .clipped()
                
                
        
    
            }
            .padding(.bottom, 20)
            .padding(.leading, 20)
             
            
            
        }
        .navigationTitle("Frugt")
        .padding(.leading, 10)
            }
        .padding(.top)
        }
          
    }
}

