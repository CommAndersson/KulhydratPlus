//
//  Funktioner nyt Måltid Kulhyrdat+.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/03/2024.
//

import SwiftUI

protocol NavigatableCategoryNytMåltid {
    var title: String { get }
    var destinationViewNytMåltid: AnyView { get }
    var categoryItems: [any CategoryItem] { get }
}

protocol FastFoodRestaurantNytMåltid: NavigatableCategoryNytMåltid {
    var id: UUID { get }
    var title: String { get }
    var menuItems: [any FastFoodItem] { get }
    var destinationViewNytMåltid: AnyView { get } // Now as a property
}

/*let fastfoodRestaurantsNytMåltid: [FastFoodRestaurantNytMåltid] = [
    McDonalds1NytMåltid() // Since McDonalds1 already initializes its categoryItems with McDonaldsMadData, no need to pass it here
] */

let navigatableCategoriesNytMåltid: [NavigatableCategoryNytMåltid] = [
    BælgfrugterCategoryNytMåltid(),
    FastFoodCategoryNytMåltid(),
    FastFoodRestaurantsCategoryNytMåltid(),
    FrugtCategoryNytMåltid()
    // Add more categories here
]

struct BælgfrugterCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Bælgfrugter og Lignende"
    var categoryItems: [any CategoryItem] = bælgfrugterData // Assume this is correctly defined
    var destinationViewNytMåltid: AnyView {
        AnyView(NavigatableCategoryNytMåltidView(category: self)) // Pass 'self' as the category
    }
}

struct FastFoodCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Fast Food"
    var categoryItems: [any CategoryItem] = fastFoodData
    var destinationViewNytMåltid: AnyView {
        AnyView(NavigatableCategoryNytMåltidView(category: self))
    }
}

struct FastFoodRestaurantsCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Fast Food Restaurants"
    var categoryItems: [any CategoryItem] {
        return restaurants.flatMap { $0.categoryItems }
    }
    var restaurants: [FastFoodRestaurantNytMåltid] = [
        McDonalds1NytMåltid(),
    ]
    var destinationViewNytMåltid: AnyView {
        AnyView(VælgFastFoodRestaurantNytMåltid(restaurants: restaurants))
    }
}

struct FrugtCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Frugt"
    var categoryItems: [any CategoryItem] = frugtData // Assume this is correctly defined
    var destinationViewNytMåltid: AnyView {
        AnyView(NavigatableCategoryNytMåltidView(category: self)) // Pass 'self' as the category
    }
}

