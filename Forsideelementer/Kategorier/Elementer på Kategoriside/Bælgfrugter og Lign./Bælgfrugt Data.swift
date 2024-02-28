//
//  Bælgfrugt Data.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 28/02/2024.
//

import SwiftUI

struct Bælgfrugt: Identifiable {
    let id = UUID()
    let bælgfrugtNavn: String
    let carbPer100g: Double
    let bælgfrugtBillede: String
}

// Sample data
let bælgfrugterData = [
    Bælgfrugt(bælgfrugtNavn: "Bulgur", carbPer100g: 0.25, bælgfrugtBillede: "Bulgur"),
    Bælgfrugt(bælgfrugtNavn: "Couscous", carbPer100g: 0.27, bælgfrugtBillede: "Couscous"),
    Bælgfrugt(bælgfrugtNavn: "Hummus", carbPer100g: 0.14, bælgfrugtBillede: "Hummus"),
    Bælgfrugt(bælgfrugtNavn: "Kikærter", carbPer100g: 0.25, bælgfrugtBillede: "Kikærter"),
    Bælgfrugt(bælgfrugtNavn: "Linser", carbPer100g: 0.21, bælgfrugtBillede: "Linser"),
    Bælgfrugt(bælgfrugtNavn: "Perlespelt", carbPer100g: 0.21, bælgfrugtBillede: "Perlespelt"),
    Bælgfrugt(bælgfrugtNavn: "Kidneybønner", carbPer100g: 0.16, bælgfrugtBillede: "Kidneybønner"),
    Bælgfrugt(bælgfrugtNavn: "Quinoa", carbPer100g: 0.21, bælgfrugtBillede: "Quinoa"),
    // Add more here
]
