//
//  Fastfood Restaurant Funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 13/03/2024.
//

import SwiftUI


protocol FastFoodRestaurant: NavigatableCategory {
    //var id: UUID { get }
    var title: String { get }
    var categoryItems: [any CategoryItem] { get }
    var destinationView: AnyView { get }
    
}

let fastfoodRestaurants: [FastFoodRestaurant] = [
    McDonalds1() // Since McDonalds1 already initializes its categoryItems with McDonaldsMadData, no need to pass it here
]
protocol FastFoodItem: CategoryItem {
    var id: UUID { get }
    var Navn: String { get }
    var carbPer100g: Double { get }
    var Billede: String { get }
}

// Example restaurant
struct McDonalds1: FastFoodRestaurant {
    var id: UUID = UUID()
    var title: String = "McDonald's"
    var menuItems: [any FastFoodItem] = McDonaldsMadData
    
    var categoryItems: [any CategoryItem] {
        menuItems // Casting menuItems to comply with the CategoryItem requirement
    }

    var destinationView: AnyView {
        // Pass both navigatableCategory and fastFoodItems to the initializer
        AnyView(FastFoodRestaurantNavigationView(navigatableCategory: self, fastFoodItems: menuItems))
    }
}

struct McDonaldsData: FastFoodItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    // Other properties and methods as needed
    
}

