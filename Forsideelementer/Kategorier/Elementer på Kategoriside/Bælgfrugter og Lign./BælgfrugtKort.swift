//
//  BælgfrugtKort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 28/02/2024.
//

import SwiftUI

struct BælgfrugtDetailView: View {
    var bælgfrugt: Bælgfrugt
    @State private var gramInput: Double = 0

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
               
               Text(bælgfrugt.bælgfrugtNavn)
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
                       
                       
                       TextField("Gram", value: $gramInput, formatter: NumberFormatter())
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
                       
                       
                       
                    //   let TotalBulgurKulhydrat = Double($gramInput) * Double(BulgurKulhydrat)
                       
                     //  let TotalBulgurKulhydratAfrundet = String (format: "%.0f", TotalBulgurKulhydrat.rounded(.toNearestOrAwayFromZero))
                       

                       
                       Text("\(gramInput * bælgfrugt.carbPer100g, specifier: "%.0f") gram")
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
           
               Image(bælgfrugt.bælgfrugtBillede)
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

struct BælgfrugtDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample Bælgfrugt instance for previewing
        let sampleBælgfrugt = Bælgfrugt(bælgfrugtNavn: "bælgfrugtNavn", carbPer100g: 0.25, bælgfrugtBillede: "bælgfrugtBillede")
        BælgfrugtDetailView(bælgfrugt: sampleBælgfrugt)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
