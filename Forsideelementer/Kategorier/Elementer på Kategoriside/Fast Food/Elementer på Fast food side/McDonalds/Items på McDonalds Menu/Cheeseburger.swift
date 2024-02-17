//
//  Cheeseburger.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/11/2023.
//

import SwiftUI


struct CheeseBurger: View {
    
    @State private var McDonaldsCheeseburgerAntal = 1
    
     let McDonaldsCheeseburgerKulhydrat = 29
    
    var body: some View {
        
        ZStack{
            
            Color("Beige").opacity(0.8)
                .ignoresSafeArea()
            
            VStack{
                
                ZStack{
                    Rectangle()
                    .frame(width: 240, height: 50)
                    .foregroundColor(.white.opacity(0.8))
                    .cornerRadius(20)
                    .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("MetallicGold"), lineWidth: 2)
                        .frame(width: 240, height: 50)
                        .padding()
                    
                    Text("Cheeseburger")
                        .bold()
                        .font(.title3)
                    
                }
                .padding(.top, 200)
                .padding(.bottom)
                
                
                ZStack{
                    Rectangle()
                    .frame(width: 330, height: 140)
                    .foregroundColor(Color("MetallicGold").opacity(0.6))
                    .cornerRadius(20)
                    .padding(.bottom, 40)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("MetallicGold"), lineWidth: 2)
                        .frame(width: 330, height: 140)
                        .padding(.bottom, 40)
                    
                    
                    HStack{
                        
                        VStack{
                        Text("Antal:")
                            .bold()
                            .padding(.leading, 20)
                            .font(.system(size: 24))
                            .padding(.top, 45)
                            .padding(.bottom, -25)
                            
                        
                        Picker("Antal", selection: $McDonaldsCheeseburgerAntal, content: {
                            Group{
                                        Text("1").tag(1)
                                        Text("2").tag(2)
                                        Text("3").tag(3)
                                        Text("4").tag(4)
                                        Text("5").tag(5)
                                        Text("6").tag(6)
                            }
                            Group{
                                        Text("7").tag(7)
                                        Text("8").tag(8)
                                        Text("9").tag(9)
                                        Text("10").tag(10)
                                        Text("11").tag(11)
                                        Text("12").tag(12)
                            }
                            
                        })
                        .pickerStyle(.wheel)
                        .frame(width: 50, height: 80)
                        .clipped()
                        .padding(.leading)
                        .padding(.bottom, 50)
                        .padding(.top, 25)
                        }
                        .padding(.bottom, 50)
                        .padding(.top, 10)
                        
                        VStack{
                            Text("Kulhydrater:")
                                .bold()
                                .font(.system(size: 24))
                                .padding(.leading, 80)
                                .padding(.trailing, 20)
                                .padding(.bottom, 40)
                                .padding(.top, 20)
                            
                            
                            
                             let TotalMcDonaldsCheeseburgerKulhydrat = McDonaldsCheeseburgerAntal * McDonaldsCheeseburgerKulhydrat
                            
                            Text("\(TotalMcDonaldsCheeseburgerKulhydrat) gram")
                                .bold()
                                .font(.system(size: 20))
                                .padding(.leading, 50)
                                .padding(.bottom, 50)
                                .padding(.top, -10)

                        }
                        .padding(.bottom, 60)
                        .padding(.top, 10)
                       
                    }
                    
                }
                .padding(.top, -30)
                .padding(.bottom, 50)
                
                
                ZStack{
                
                    Rectangle()
                    .frame(width: 330, height: 390)
                    .cornerRadius(20)
                    .foregroundColor(.white.opacity(0.8))
                    
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("MetallicGold"), lineWidth: 2)
                        .frame(width: 330, height: 390)
                        
            
                
                    Image("McDonaldsCheeseburger")
                        .resizable()
                        .frame(width: 200, height: 160)
                    
                
                }
                .padding(.top, -80)
                .padding(.bottom, 380)
                
            }
        }
        
        
        
       
    }
}
