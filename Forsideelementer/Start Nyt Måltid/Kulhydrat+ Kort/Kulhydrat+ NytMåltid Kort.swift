//
//  Kulhydrat+ NytMåltid Kort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/03/2024.
//

import SwiftUI

struct KulhydratPlusKortNytMåltidDetailView: View {
    
    @State private var gramInput: Double = 0
    
    @EnvironmentObject var mealViewModel: MealViewModel

    @Environment(\.dismiss) private var dismiss
    
    var categoryItem: any CategoryItem
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
                            
                            
                            TextField("Gram", value: $gramInput, formatter: Formatter.lucNumberFormatBulgur)
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
                            
                            
                            
                            let TotalcategoryItemKulhydrat = Double(gramInput) * Double(categoryItem.carbPer100g)
                            
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

        }   .navigationBarBackButtonHidden(true)
   .toolbar {
       ToolbarItem(placement: .topBarLeading) {
           Button(action: {
               dismiss()
           }) {
               HStack {
                   Image(systemName: "arrow.backward")
                   //Text("Back")
               }
           }
       }
       ToolbarItem(placement: .topBarTrailing) {
           Button(action: {
               let carbsPerGram = categoryItem.carbPer100g // Calculate carbs per gram
               let totalCarbs = gramInput * carbsPerGram // Calculate total carbs based on input gram
               // Create a new FlashcardNytMåltid based on the details
               let newFlashcard = FlashcardNytMåltid(name: categoryItem.Navn, kulhydrat: totalCarbs, måleenhed: "Gram", mængde: gramInput)
               // Create a new MealItem with the FlashcardNytMåltid
               let newMealItem = MealItem(flashcard: newFlashcard, amount: gramInput)
               // Add the new MealItem to the mealItems array
               mealViewModel.addMealItem(newMealItem)
               mealViewModel.shouldNavigateBackToStartNytMåltid = true // Navigate back if needed
           }) {
               Text("Tilføj")
           }
       }
   }
        
   
   
   
  
}
    
    }
    


