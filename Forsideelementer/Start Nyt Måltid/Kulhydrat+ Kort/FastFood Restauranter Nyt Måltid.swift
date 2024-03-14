//
//  FastFood Restauranter Nyt Måltid.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 14/03/2024.
//

import SwiftUI

struct McDonalds1NytMåltid: FastFoodRestaurantNytMåltid {
    var id: UUID = UUID()
    var title: String = "McDonald's"
    var menuItems: [any FastFoodItem] = McDonaldsMadData // Ensure this data is correctly populated

    var categoryItems: [any CategoryItem] {
        menuItems.map { $0 as (any CategoryItem) } // Ensure menuItems conforms to CategoryItem
    }

    // Here, destinationViewNytMåltid is implemented as a computed property, not a function.
    var destinationViewNytMåltid: AnyView {
        AnyView(NavigatableCategoryNytMåltidView(category: self)) // Adjust the NavigatableCategoryNytMåltidView initializer as needed.
    }
}
