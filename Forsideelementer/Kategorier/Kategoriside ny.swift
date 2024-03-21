//
//  Kategorier.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 26/02/2024.
//

import SwiftUI

struct KategoriSide: View {
    // Array of NavigatableCategory
    let categories: [any NavigatableCategory]

       init(categories: [any NavigatableCategory]) {
           self.categories = categories
       }

    @Environment(\.dismiss) private var dismiss
   
    
    
    var body: some View {
        ZStack{
            Color("GrønBaggrund")
                .ignoresSafeArea()
                .opacity(0.4)

        ScrollView {
            VStack(spacing: 20) {
                ForEach(categories.indices, id: \.self) { index in
                    let category = categories[index]
                    NavigationLink(destination: category.destinationView) {
                        Text(category.title)
                            .frame(width: 300, height: 50)
                            .background(Color("GrønEmneBaggrund"))
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                            .cornerRadius(10)
                        /*.overlay(
                         RoundedRectangle(cornerRadius: 10)
                         .stroke(Color("RoyalBlue"), lineWidth: 4)
                         ) */
                        
                    }
                    
                }
            }
            .padding()
        }
        .navigationTitle("Kategorier")
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
