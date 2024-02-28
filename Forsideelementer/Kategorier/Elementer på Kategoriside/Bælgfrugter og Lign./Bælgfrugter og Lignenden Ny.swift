//
//  Bælgfrugter og Lignenden Ny.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 27/02/2024.
//

import SwiftUI

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

struct BælgfrugterTyper: Identifiable {
    let id = UUID()
    let kategori: String
}

struct BælgfrugterOgLignendeNy: View {
    
    @Environment(\.dismiss) private var dismiss
    
    
    
    let TyperAfBælgfrugt = [("Bulgur", "Bulgur"), ("Couscous", "Couscous"), ("Hummus", "Hummus"), ("Kikærter", "Kikærter"), ("Linser", "Linser"), ("Perlespelt", "Perlespelt"), ("Kidneybønner", "Kidneybønner"), ("Quinoa", "Quinoa")]

    var body: some View {
        ScrollView {
                   LazyVStack {
                       let numberOfRows = (TyperAfBælgfrugt.count + 1) / 2
                       ForEach(0..<numberOfRows, id: \.self) { rowIndex in
                           HStack {
                               ForEach(0..<2, id: \.self) { columnIndex in
                                   let itemIndex = rowIndex * 2 + columnIndex
                                   if itemIndex < TyperAfBælgfrugt.count {
                                       let category = TyperAfBælgfrugt[itemIndex].0
                                       let bælgfrugt = bælgfrugterData.first { $0.bælgfrugtNavn == category } // Find corresponding Bælgfrugt instance
                                       if let bælgfrugt = bælgfrugt {
                                           NavigationLink(destination: BælgfrugtDetailView(bælgfrugt: bælgfrugt)) {
                                               VStack {
                                                   Text(category)
                                                       .foregroundColor(.black)
                                                       .font(.system(size: 20))
                                                       .padding(.top, 35)
                                                   Image(category)
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
                                           .contentShape(Rectangle())
                                           .clipped()
                                       } else {
                                           // Handle error or empty state
                                       }
                                   } else {
                                       // Empty space for alignment
                                   }
                               }
                               if rowIndex == numberOfRows - 1 && TyperAfBælgfrugt.count % 2 != 0 {
                                   Spacer().frame(width: 178) // Conditional spacer
                               }
                           }
                           .padding(.horizontal, 20)
                           .padding(.bottom, 20)
                       }
                   }
                   .padding(.top)
               }
               .navigationTitle("Bælgfrugter og Lign.")
               .padding(.leading, 20)
           }
       }
    




struct BælgfrugterNavigationLinkView: View {
    let destination: AnyView
    let title: String
    let imageName: String

    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Text(title)
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .padding(.top, 35)
                Image(imageName)
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
        .contentShape(Rectangle())
        .clipped()
    }
}
