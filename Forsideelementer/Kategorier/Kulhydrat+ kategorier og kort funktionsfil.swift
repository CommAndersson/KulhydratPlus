//
//  Kulhydrat+ kategorier og kort funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 02/03/2024.
//

import SwiftUI

protocol CategoryItem: Identifiable {
    var id: UUID { get }
    var Navn: String { get }
    var carbPer100g: Double { get }
    var Billede: String { get }
    func destinationView() -> AnyView
}




protocol NavigatableCategory {
    var title: String { get }
    var destinationView: AnyView { get }
}

let navigatableCategories: [NavigatableCategory] = [
    BælgfrugterCategory(),
   // FastFoodCategory(),
    FrugtCategory()
    // Add more categories here
]

struct FrugtData: CategoryItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    func destinationView() -> AnyView {
        AnyView(FrugtDetailView(frugt: self))
    }
}

struct Bælgfrugt: CategoryItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    func destinationView() -> AnyView {
        AnyView(BælgfrugtDetailView(bælgfrugt: self))
    }
}

struct FastFoodData: CategoryItem{
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    func destinationView() -> AnyView {
        AnyView(FastFood(fastFood: self))
    }
}

let combinedData = frugtData + bælgfrugterData

struct BælgfrugterCategory: NavigatableCategory {
    var title: String = "Bælgfrugter og Lignende"
    var destinationView: AnyView = AnyView(BælgfrugterOgLignendeNy())
}
/*
struct FastFoodCategory: NavigatableCategory {
    var title: String = "Fast Food"
    var destinationView: AnyView = AnyView(FastFood()) // Now works without requiring specific `fastFood` data
}
*/
struct FrugtCategory: NavigatableCategory {
    var title: String = "Frugt"
    var destinationView: AnyView = AnyView(Frugt()) // Replace FrugtView() with your actual view
}


extension Formatter {
    static let lucNumberFormatCategoryItem: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}




struct CategoryItemView: View {
    var categoryItem: any CategoryItem
    

    
    @State private var Gram = 0
   
    
    var formattedLucNumber : String {
        Formatter.lucNumberFormatCategoryItem.string(from: NSNumber(value: categoryItem.carbPer100g))!
        }
    
   
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
                   
                   Text(categoryItem.Navn)
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
                           
                           
                           TextField("Gram", value: $Gram, formatter: Formatter.lucNumberFormatBulgur)
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



