//
//  Custom back button.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 09/02/2024.
//

import SwiftUI


@main
struct customBackButton: App {
    var body: some Scene {
        WindowGroup{
            ContentView()
                .onAppear{
                    UINavigationBar.appearance().backIndicatorImage = UIImage(systemName: "arrow.backward")
                    UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.backward")
                }
        }
    }
}

