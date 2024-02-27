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
    
    @State var TyperAfBælgfrugt = [
        BælgfrugterTyper(kategori: "Bulgur"),
        BælgfrugterTyper(kategori: "Couscous"),
        BælgfrugterTyper(kategori: "Hummus"),
        BælgfrugterTyper(kategori: "Kikærter"),
        BælgfrugterTyper(kategori: "Linser"),
        BælgfrugterTyper(kategori: "Perlespelt"),
        BælgfrugterTyper(kategori: "Røde Bønner"),
        BælgfrugterTyper(kategori: "Quinoa")
    ]
    
    var body: some View {
        List(TyperAfBælgfrugt) { item in
                    NavigationLink(destination: ViewSelectorBælgfrugter.viewForCategory(item.kategori)) {
                        Text(item.kategori)
                    }
                    .listStyle(.insetGrouped)
                    //.padding(.bottom, 20)
                    .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                    //.background(.white)
                    .scrollContentBackground(.hidden)
                    .environment(\.defaultMinListRowHeight, 50)
                    .environment(\.defaultMinListHeaderHeight, 10)
                    //.multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .listRowSeparatorTint(.black)
                    .listRowBackground(Color("BlåTilKnapper"))
                    .listSectionSeparatorTint(.black)
                    .headerProminence(.increased)
                
                }
        .scrollContentBackground(.hidden)
        
      /*  .listStyle(.insetGrouped)
        .padding(.bottom, 20)
        .listRowInsets(.init(top: 0, leading: 60, bottom: 50, trailing: 60))
        .background(.white)
        .scrollContentBackground(.hidden)
        .environment(\.defaultMinListRowHeight, 50)
        .environment(\.defaultMinListHeaderHeight, 10) */
        
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

