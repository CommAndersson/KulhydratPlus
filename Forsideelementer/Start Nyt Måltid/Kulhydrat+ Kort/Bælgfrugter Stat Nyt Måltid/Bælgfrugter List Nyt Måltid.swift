//
//  Bælgfrugter List Nyt Måltid.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/03/2024.
//

import SwiftUI

struct BælgfrugterListNytMåltidView: View {
    var bælgfrugter: [Bælgfrugt]
    
    var body: some View {
        List(bælgfrugter) { bælgfrugt in
            NavigationLink(destination: BælgfrugtDetailViewNytMåltid(bælgfrugt: bælgfrugt, categoryItem: bælgfrugt)) { // Adjust the destination view initializer as needed
                Text(bælgfrugt.Navn)
            }
        }
    }
}
