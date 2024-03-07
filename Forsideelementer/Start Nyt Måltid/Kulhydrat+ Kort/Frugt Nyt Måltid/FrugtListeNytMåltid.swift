//
//  FrugtListeNytMåltid.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/03/2024.
//

import SwiftUI

struct FrugtListNytMåltidView: View {
    var frugter: [FrugtData] // Adjust this to your actual data type
    
    var body: some View {
        List(frugter) { frugt in
            NavigationLink(destination: FrugtNytMåltidDetailView(frugt: frugt, categoryItem: frugt)) {
                Text(frugt.Navn) // Assuming 'name' is a property of FrugtData
            }
        }
    }
}
