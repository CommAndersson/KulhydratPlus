//
//  Kategorier Data.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 02/03/2024.
//

import SwiftUI

struct NavigatableCategoryView: View {
    

    @Environment(\.dismiss) private var dismiss
    
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible(), spacing: 15)
    ]
    
    
    
    let navigatableCategory: NavigatableCategory
        var categoryItems: [any CategoryItem]

        init(navigatableCategory: NavigatableCategory) {
            self.navigatableCategory = navigatableCategory
            self.categoryItems = navigatableCategory.categoryItems // Use the specific data
        }

    var body: some View {
        ZStack{
            Color("GrønBaggrund")
                .ignoresSafeArea()
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
                    .background(Color("GrønEmneBaggrund"))
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                }
                .padding(.leading, 20)
            }
            .navigationTitle(navigatableCategory.title)
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
        
    }       }
    




