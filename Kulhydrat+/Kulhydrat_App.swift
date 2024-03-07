//
//  Kulhydrat_App.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 10/11/2023.
//

import SwiftUI
/*
import Firebase
 */

@main
struct Kulhydrat_App: App {
    @StateObject private var mealViewModel = MealViewModel()
    /*
    init(){
        FirebaseApp.configure()
    }
    */
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mealViewModel)
        }
    }
}

