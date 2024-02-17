//
//  Vindruer.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 25/11/2023.
//

import SwiftUI


extension Formatter {
    static let lucNumberFormatVindruer: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}



 struct Vindruer: View {
     
    
     
     
     
     @State private var VindruerGram = 0
    
     
     var formattedLucNumber : String {
             Formatter.lucNumberFormatVindruer.string(from: NSNumber(value: VindruerKulhydrat))!
         }
     
     
     let VindruerKulhydrat = 0.11
    
    var body: some View {
        
        ZStack{
            
            Color("BlåTilKnapper").opacity(0.3)
                .ignoresSafeArea()
            
            VStack{
                
                ZStack{
                    Rectangle()
                    .frame(width: 240, height: 50)
                    .foregroundColor(Color("BlåTilKnapper").opacity(0.6))
                    .cornerRadius(20)
                    .padding()
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 240, height: 50)
                        .padding()
                    
                    Text("Vandmelon")
                        .bold()
                        .font(.title3)
                                            
                }
                .padding(.top, 200)
                .padding(.bottom, -2)
                
                
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
                        Text("Vægt:")
                            .bold()
                            .padding(.leading, -10)
                            .font(.system(size: 24))
                            .padding(.top, 40)
                            .padding(.bottom, -25)
                            
                        ZStack{
                            Rectangle()
                            .frame(width: 80, height: 40)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.bottom, 50)
                            .padding(.top, 25)
                            .padding(.leading, -20)
                            .padding(.trailing, -10)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                                .frame(width: 80, height: 40)
                                .padding(.bottom, 50)
                                .padding(.top, 25)
                                .padding(.leading, -20)
                                .padding(.trailing, -10)
                            
                            
                            TextField("Gram", value: $VindruerGram, formatter: Formatter.lucNumberFormatVindruer)
                                .font(.title3)
                                .frame(width: 120, height: 80)
                                .clipped()
                                .padding(.trailing, -20)
                                .padding(.bottom, 50)
                                .padding(.top, 25)
                                .padding(.leading, 40)
                               
                            
                            
                            }
                            
                        }
                        .padding(.bottom, 50)
                        .padding(.top, 10)
                        .padding(.top, 20)
                        
                        VStack{
                            Text("Kulhydrater:")
                                .bold()
                                .font(.system(size: 24))
                                .padding(.leading)
                                .padding(.trailing)
                                .padding(.bottom, 40)
                                .padding(.top, 20)
                            
                            
                            
                            let TotalVindruerKulhydrat = Double(VindruerGram) * Double(VindruerKulhydrat)
                            
                            let TotalVindruerKulhydratAfrundet = String (format: "%.0f", TotalVindruerKulhydrat.rounded(.toNearestOrAwayFromZero))
                            
   
                            
                            Text("\(TotalVindruerKulhydratAfrundet) gram")
                                .bold()
                                .font(.system(size: 20))
                                .padding(.leading, 0)
                                .padding(.bottom, 50)
                                .padding(.top, -10)

                        }
                        .padding(.bottom, 60)
                        .padding(.top, 30)
                        .padding(.trailing, 20)
                       
                    }
                    
                }
                .padding(.top, -30)
                .padding(.bottom, 50)
                
                
                ZStack{
                
                    Rectangle()
                    .frame(width: 330, height: 330)
                    .cornerRadius(10)
                    .foregroundColor(.white.opacity(0.8))
                
                    Image("Vindruer")
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
        
        
        
       
    }
}
