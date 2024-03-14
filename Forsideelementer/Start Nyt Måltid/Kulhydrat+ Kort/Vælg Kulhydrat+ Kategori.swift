//
//  Vælg Kulhydrat+ Kategori.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 01/03/2024.
//

import SwiftUI

struct Kategorier: Identifiable {
    let id = UUID()
    let kategori: String
}

struct KategoriSideNytMåltidKulhydratPlus: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var kategorier = [
        Kategorier(kategori: "Bælgfrugter og Lignende"),
        Kategorier(kategori: "Fast Food"),
        Kategorier(kategori: "Frugt"),
    ]
    
    var categories: [any NavigatableCategoryNytMåltid]
    
    init(categories: [any NavigatableCategoryNytMåltid]) {
            self.categories = categories
        }
    
    var body: some View {
            VStack {
                ZStack {
                    Rectangle()
                        .frame(width: 350, height: 55)
                        .foregroundColor(Color("BlåTilKnapper").opacity(0.6))
                        .cornerRadius(20)
                        .padding(.bottom, 10)
                        .padding(.top, -30)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                        .frame(width: 350, height: 55)
                        .padding(.bottom, 10)
                        .padding(.top, -30)
                    
                    Text("Kategorier 2.0:")
                        .bold()
                        .foregroundColor(.black)
                        .font(.system(size: 30))
                        .padding(.bottom, 40)
                }
                .padding(.bottom, 100)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(categories, id: \.title) { category in
                            NavigationLink(destination: category.destinationViewNytMåltid) {
                                Text(category.title)
                                    .frame(width: 300, height: 50)
                                    .background(Color("BlåTilKnapper"))
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("RoyalBlue"), lineWidth: 4)
                                    )
                            }
                        }
                    }
                    .padding()
                }
                .background(.white)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
