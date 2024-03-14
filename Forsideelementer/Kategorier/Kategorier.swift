//
//  Kategoriside.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/11/2023.
//

import SwiftUI

protocol NavigatableCategory {
    var title: String { get }
    var destinationView: AnyView { get }
    var categoryItems: [any CategoryItem] { get }
}

let navigatableCategories: [NavigatableCategory] = [
    BælgfrugterCategory(),
    FastFoodCategory(),
    FastFoodRestaurantsCategory(),
    FrugtCategory()
    // Add more categories here
]

struct BælgfrugterCategory: NavigatableCategory {
    var title: String = "Bælgfrugter og Lignende"
    var categoryItems: [any CategoryItem] = bælgfrugterData
    var destinationView: AnyView {
        // No need for `init` here, the view is created when accessed
        AnyView(NavigatableCategoryView(navigatableCategory: self))
    }
}

struct FastFoodCategory: NavigatableCategory {
    var title: String = "Fast Food"
    var categoryItems: [any CategoryItem] = fastFoodData
    var destinationView: AnyView {
        // No need for `init` here, the view is created when accessed
        AnyView(NavigatableCategoryView(navigatableCategory: self))
    }
}

struct FastFoodRestaurantsCategory: NavigatableCategory {
    var categoryItems: [any CategoryItem] {
        return restaurants.flatMap { $0.categoryItems }
    }
    
    var title: String = "Fast Food Restaurants"
    var restaurants: [FastFoodRestaurant] = [
        McDonalds1(), // Make sure McDonalds1() is initialized correctly.
        // Add other restaurants here...
    ]

    var destinationView: AnyView {
        AnyView(VælgFastFoodRestaurant(restaurants: restaurants))
    }
}


struct FrugtCategory: NavigatableCategory {
    var title: String = "Frugt"
    var categoryItems: [any CategoryItem] = frugtData
    var destinationView: AnyView {
        // No need for `init` here, the view is created when accessed
        AnyView(NavigatableCategoryView(navigatableCategory: self))
    }
}
