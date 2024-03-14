//
//  Vælg Fastfood Restaurant.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 13/03/2024.
//

import SwiftUI

struct VælgFastFoodRestaurant: View {
    let restaurants: [FastFoodRestaurant]

    /*
    var body: some View {
        List {
            ForEach(restaurants, id: \.restaurantName) { restaurant in
                NavigationLink(destination: RestaurantMenuView(restaurant: restaurant)) {
                    Text(restaurant.restaurantName)
                }
            }
        }
    }*/
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(restaurants.indices, id: \.self) { index in
                    let restaurants = restaurants[index]
                    NavigationLink(destination: restaurants.destinationView) {
                        Text(restaurants.title)
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
