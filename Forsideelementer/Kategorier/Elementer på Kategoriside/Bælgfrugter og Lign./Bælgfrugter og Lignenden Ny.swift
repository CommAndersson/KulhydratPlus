//
//  Bælgfrugter og Lignenden Ny.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 27/02/2024.
//

import SwiftUI
/*
struct ViewSelectorBælgfrugter {
    static func viewForCategory(_ category: String) -> some View {
        switch category {
        case "Bulgur":
            return AnyView(Bulgur())
        case "Couscous":
            return AnyView(Couscous())
        case "Hummus":
            return AnyView(Hummus())
        case "Kikærter":
            return AnyView(Kikærter())
        case "Linser":
            return AnyView(Linser())
        case "Perlespelt":
            return AnyView(Perlespelt())
        case "Kidneybønner":
            return AnyView(Kidneybønner())
        case "Quinoa":
            return AnyView(Quinoa())
        // Add cases for each category with their corresponding views, wrapped in AnyView
        default:
            return AnyView(Text("Not Found"))
        }
    }
}
*/



struct BælgfrugterTyper: Identifiable {
    let id = UUID()
    let kategori: String
}

struct BælgfrugterOgLignendeNy: View {
    
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 15)
    ]
    
    @Environment(\.dismiss) private var dismiss
    
    
   /* let TyperAfBælgfrugt = [("Bulgur", "Bulgur"), ("Couscous", "Couscous"), ("Hummus", "Hummus"), ("Kikærter", "Kikærter"), ("Linser", "Linser"), ("Perlespelt", "Perlespelt"), ("Kidneybønner", "Kidneybønner"), ("Quinoa", "Quinoa"), ("test", "test")] */
    
    
    
    var categoryItems: [any CategoryItem] = []
    
    init() {
        // Assuming frugtData and bælgfrugterData are already populated as shown in your example
        categoryItems.append(contentsOf: bælgfrugterData)
        categoryItems.append(contentsOf: frugtData)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(categoryItems, id: \.id) { item in
                    NavigationLink(destination: CategoryItemView(categoryItem: item)) {
                        VStack {
                            Text(item.Navn)
                                .foregroundColor(.black)
                                .font(.system(size: 20))
                                .padding(.top, 35)
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
            .navigationTitle("Bælgfrugter og Lign.")
        }
        
    }
}
   
    







    
    

