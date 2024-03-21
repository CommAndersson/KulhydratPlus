//
//  Kulhydrat+ kategorier og kort funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 02/03/2024.
//

import SwiftUI



struct CategoryItemView: View {
    var categoryItem: any CategoryItem
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var Gram = 0
   
    
    var formattedLucNumber : String {
        Formatter.lucNumberFormatCategoryItem.string(from: NSNumber(value: categoryItem.carbPer100g))!
        }
    
   
   var body: some View {
       
       ZStack{
           
           Color("GrønBaggrund")
               .ignoresSafeArea()
           
           VStack{
               
               ZStack{
                   Rectangle()
                   .frame(width: 240, height: 50)
                   .foregroundColor(Color("GrønTekst").opacity(0.6))
                   .cornerRadius(10)
                   .padding()
                   
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color.black, lineWidth: 1)
                       .frame(width: 240, height: 50)
                       .padding()
                   
                   Text(categoryItem.Navn)
                       .bold()
                       .font(.title3)
                                           
               }
               .padding(.top, 200)
               .padding(.bottom, -2)
               
               
               ZStack{
                   Rectangle()
                   .frame(width: 330, height: 140)
                   .foregroundColor(Color("GrønTekst").opacity(0.6))
                   .cornerRadius(10)
                   .padding(.bottom, 40)
                   
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color.black, lineWidth: 1)
                       .frame(width: 330, height: 140)
                       .padding(.bottom, 40)
                   
                   
                   HStack{
                       
                       VStack{
                           Text(categoryItem.Enhed)
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
                           
                           
                           TextField(categoryItem.Enhed, value: $Gram, formatter: Formatter.lucNumberFormatBulgur)
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
                           
                           
                           
                           let TotalcategoryItemKulhydrat = Double(Gram) * Double(categoryItem.carbPer100g)
                           
                           let TotalcategoryItemKulhydratAfrundet = String (format: "%.0f", TotalcategoryItemKulhydrat.rounded(.toNearestOrAwayFromZero))
                           
  
                           
                           Text("\(TotalcategoryItemKulhydratAfrundet) gram")
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
               
                   Image(categoryItem.Billede)
                       .resizable()
                       .cornerRadius(10)
                       .frame(width: 329, height: 329)
                   
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color.black, lineWidth: 1)
                       .frame(width: 330, height: 330)
                   
               
               }
               .padding(.top, -80)
               .padding(.bottom, 320)
               
           }
           .padding(.top, 20)

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



