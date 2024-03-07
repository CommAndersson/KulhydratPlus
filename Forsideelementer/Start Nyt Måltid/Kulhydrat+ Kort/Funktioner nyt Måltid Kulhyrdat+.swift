//
//  Funktioner nyt Måltid Kulhyrdat+.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/03/2024.
//

import SwiftUI

protocol NavigatableCategoryNytMåltid {
    var title: String { get }
    func destinationView() -> AnyView
}

struct BælgfrugterCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Bælgfrugter og Lignende"
    
    func destinationView() -> AnyView {
        return AnyView(BælgfrugterListNytMåltidView(bælgfrugter: bælgfrugterData as! [Bælgfrugt]))
    }
}

struct FrugtCategoryNytMåltid: NavigatableCategoryNytMåltid {
    var title: String = "Frugt"
    
    func destinationView() -> AnyView {
        return AnyView(FrugtListNytMåltidView(frugter: frugtData as! [FrugtData]))
    }
}
