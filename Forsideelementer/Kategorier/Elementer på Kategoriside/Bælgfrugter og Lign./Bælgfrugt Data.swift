//
//  Bælgfrugt Data.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 28/02/2024.
//

import SwiftUI
/*
struct Bælgfrugt: CategoryItem {
    let id = UUID()
    let Navn: String
    let carbPer100g: Double
    let Billede: String
}
 */

// Sample data
let bælgfrugterData: [any CategoryItem] = [
    Bælgfrugt(Navn: "Bulgur", carbPer100g: 0.25, Billede: "Bulgur"),
    Bælgfrugt(Navn: "Couscous", carbPer100g: 0.27, Billede: "Couscous"),
    Bælgfrugt(Navn: "Hummus", carbPer100g: 0.14, Billede: "Hummus"),
    Bælgfrugt(Navn: "Kikærter", carbPer100g: 0.25, Billede: "Kikærter"),
    Bælgfrugt(Navn: "Linser", carbPer100g: 0.21, Billede: "Linser"),
    Bælgfrugt(Navn: "Perlespelt", carbPer100g: 0.21, Billede: "Perlespelt"),
    Bælgfrugt(Navn: "Kidneybønner", carbPer100g: 0.16, Billede: "Kidneybønner"),
    Bælgfrugt(Navn: "Quinoa", carbPer100g: 0.21, Billede: "Quinoa"),
    Bælgfrugt(Navn: "test", carbPer100g: 0.80, Billede: "test"),
    // Add more here
]
