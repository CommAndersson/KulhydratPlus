//
//  Kategorier.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 26/02/2024.
//

import SwiftUI

struct Kategorier: Identifiable {
    let id = UUID()
    let kategori: String
}

struct KategoriSide: View {
    @Environment(\.dismiss) private var dismiss
    
    @State var kategorier = [
        Kategorier(kategori: "Bælgfrugter og Lignende"),
        Kategorier(kategori: "Fast Food"),
        Kategorier(kategori: "Frugt"),
    ]
    
    var body: some View {
        VStack{
            ZStack{
                
                
                Rectangle()
                    .frame(width: 350, height: 55)
                    .foregroundColor(Color("BlåTilKnapper").opacity(0.6))
                    .cornerRadius(20)
                    .padding(.bottom, 10)
                    .padding(.top, -30)
                
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color("BlåTilKnapper"), lineWidth: 2)
                    .frame(width: 350, height: 55)
                    .padding(.bottom, 10)
                    .padding(.top, -30)
                
                
                Text("Kategorier:")
                    .bold()
                // .padding(.bottom)
                //.padding(.top, 40)
                    .foregroundColor(.black)
                    .font(.system(size: 30))
                    .padding(.bottom, 40)
                
            }
            //.padding(.top, -150)
            .padding(.bottom, 100)
            
            
            List{
                ForEach(kategorier) { item in
                        if item.kategori == "Bælgfrugter og Lignende" {
                            NavigationLink(destination: BælgfrugterOgLignendeNy()) {
                                Text(item.kategori)
                            }
                        } else if item.kategori == "Fast Food" {
                            NavigationLink(destination: FastFood()) {
                                Text(item.kategori)
                            }
                        } else if item.kategori == "Frugt" {
                            NavigationLink(destination: Frugt()) {
                                Text(item.kategori)
                            }
                        }
                    }          .foregroundColor(.black)
                .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 60))
                .listRowSeparatorTint(.black)
                .listRowBackground(Color("BlåTilKnapper"))
                .listSectionSeparatorTint(.black)
                .headerProminence(.increased)
            }
            .listStyle(.insetGrouped)
            .padding(.bottom, 20)
            .listRowInsets(.init(top: 0, leading: 60, bottom: 50, trailing: 60))
            .background(.white)
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListRowHeight, 50)
            .environment(\.defaultMinListHeaderHeight, 10)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                EditButton()
            }
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
