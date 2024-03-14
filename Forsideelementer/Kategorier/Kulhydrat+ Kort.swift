//
//  Kulhydrat+ Kort.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/03/2024.
//

import SwiftUI


struct KulhydratPlusKort: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 15)
    ]
    
   /* let TyperAfFrugt = [("Abrikos", "Abrikos"), ("Ananas", "Anana"), ("Appelsin", "Appelsin"), ("Banan", "Banan"), ("Blomme", "Blomme"), ("Blåbær", "Blåbær"), ("Cantaloupe Melon", "Cantaloupe Melon"), ("Dadler", "Dadler"), ("Figen", "Figen"), ("Granatæble", "Granatæble"), ("Hindbær", "Hindbær"), ("Honningmelon", "Honningmelon"), ("Jordbær", "Jordbær"), ("Kirsebær", "Kirsebær"), ("Kiwi", "Kiwi"), ("Kokosnød", "Kokosnød"), ("Mandarin", "Mandarin"), ("Mango", "Mango"), ("Nektarin", "Nektarin"), ("Papaya", "Papaya"), ("Pære", "Pære"), ("Vandmelon", "Vandmelon"), ("Vindruer", "Vindruer"), ("Æble", "Æble")]
    */
  
    
    var categoryItems: [any CategoryItem]
        
        // Assuming you're passing the categories somehow, or it could be hardcoded for now
        let categories: [NavigatableCategory] // Initialize this if necessary, or pass through the initializer
        
        // Adjusted initializer
        init(categories: [NavigatableCategory]) {
            self.categories = categories
            // Directly initialize `categoryItems` with combined data if available
            self.categoryItems = frugtData + bælgfrugterData + fastFoodData
        }
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(categoryItems, id: \.id) { item in
                        NavigationLink(destination: item.destinationView()) {
                            VStack {
                                Text(item.Navn)
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                    .padding(.top, 35)
                                // Ensure your CategoryItem includes an image name or similar for displaying an image
                                Image(item.Billede)
                                    .resizable()
                                    .frame(width: 90, height: 90)
                                    .cornerRadius(10)
                                    .padding(.bottom, 40)
                            }
                        }
                        .frame(width: 150, height: 150)
                        .background(Color("BlåTilKnapper"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                    }
                    .padding(.leading, 20)
                }
                .navigationTitle("Kategorier")
            }
        }
    }
    




