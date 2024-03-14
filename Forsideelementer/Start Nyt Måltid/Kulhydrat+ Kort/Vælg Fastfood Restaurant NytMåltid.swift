//
//  Vælg Fastfood Restaurant NytMåltid.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/03/2024.
//

import SwiftUI

struct VælgFastFoodRestaurantNytMåltid: View {
    let restaurants: [FastFoodRestaurantNytMåltid]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(restaurants, id: \.id) { restaurant in
                    NavigationLink(destination: restaurant.destinationViewNytMåltid) {
                            Text(restaurant.title)
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
        .navigationTitle("Vælg Restaurant")
    }
}
