//
//  Vælg Kulhydrat + Fødevare.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 01/03/2024.
//


import SwiftUI

struct NavigatableCategoryNytMåltidView: View {
    
    
    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -20),
        GridItem(.flexible(), spacing: 15)
    ]
    
    let category: NavigatableCategoryNytMåltid
    init(category: NavigatableCategoryNytMåltid) {
        self.category = category
    }
    var body: some View {
        ZStack{
            Color("GrønBaggrund")
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns, spacing: 30) {
                    ForEach(category.categoryItems, id: \.id) { item in
                        NavigationLink(destination: KulhydratPlusKortNytMåltidDetailView(categoryItem: item)) {
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
                        .background(Color("GrønEmneBaggrund"))
                        .cornerRadius(10)
                        .padding(.trailing, 20)
                    }
                    .padding(.leading, 20)
                }
                .navigationTitle(category.title)
            }
            
            
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
