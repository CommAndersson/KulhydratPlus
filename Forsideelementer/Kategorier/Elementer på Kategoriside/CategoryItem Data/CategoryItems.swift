//
//  CategoryItems.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 13/03/2024.
//

import SwiftUI

extension Formatter {
    static let lucNumberFormatCategoryItem: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""     // Show empty string instead of zero
        return formatter
    }()
}


protocol CategoryItem: Identifiable {
    var id: UUID { get }
    var Navn: String { get }
    var carbPer100g: Double { get }
    var Billede: String { get }
    func destinationView() -> AnyView
}

extension CategoryItem {
    func destinationView() -> AnyView {
        AnyView(CategoryItemView(categoryItem: self))
    }
}



struct FrugtData: CategoryItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    // Other properties and methods as needed
    
}

struct Bælgfrugt: CategoryItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    // Other properties and methods as needed
}

struct FastFoodData: CategoryItem {
    var id = UUID()
    var Navn: String
    var carbPer100g: Double
    var Billede: String
    
    // Other properties and methods as needed
}




