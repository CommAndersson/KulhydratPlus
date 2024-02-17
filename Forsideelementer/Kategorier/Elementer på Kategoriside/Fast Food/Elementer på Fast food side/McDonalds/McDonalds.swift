//
//  McDonalds.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 13/11/2023.
//

import SwiftUI

struct McDonalds: View {
    var body: some View {
        ZStack{
           // Color("Beige").opacity(0.8)
               // .ignoresSafeArea()
            
            VStack{
                
                HStack{
        
                        NavigationLink(destination: CheeseBurger(), label:{
                            VStack{
                                
                                Text("Cheeseburger")
                                   .foregroundColor(.black)
                                   .font(.system(size: 20))
                                   .padding(.top, 45)
                            
                                Image("McDonaldsCheeseburger")
                                    .resizable()
                                    .frame(width: 100, height: 80)
                                    .padding(.bottom, 40)
                        
                            }
                        })
                        .frame(width: 150, height: 150)
                        .background(Color("BlåTilKnapper"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                        .contentShape(Rectangle())
                        .clipped()
                    
                    
                        NavigationLink(destination: TastyCheese(), label:{
                            VStack{
                            
                                Text("Tasty Cheese")
                                   .foregroundColor(.black)
                                   .font(.system(size: 20))
                                   .padding(.top, 45)
                    
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
                
                NavigationLink("Hamburger", destination: Hamburger())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 150, height: 150)
                    .background(Color("BlåTilKnapper"))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                
                NavigationLink("Double Super Cheese", destination: DoubleSuperCheese())
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 150, height: 150)
                    .background(Color("BlåTilKnapper"))
                    .cornerRadius(10)
                
            }
            
        }
    }
}
}
