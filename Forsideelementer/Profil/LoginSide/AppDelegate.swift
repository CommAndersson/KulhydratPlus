//
//  AppDelegate.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 23/10/2024.
//

import SwiftUI
import GoogleSignIn
import FBSDKCoreKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("AppDelegate: Starting initialization")
        
        // Configure Facebook SDK explicitly
        let facebookAppID = "3403701363093875"
        Settings.shared.appID = facebookAppID
        Settings.shared.clientToken = "90f56d859cbfc777b45435f5c4c793b2"
        Settings.shared.displayName = "Kulhydrat+"
        
        // Initialize Facebook SDK
        print("AppDelegate: Initializing Facebook SDK")
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        print("AppDelegate: Facebook SDK initialized")
        
        // Debug print Facebook configuration
        print("AppDelegate: Facebook App ID:", Settings.shared.appID ?? "Not set")
        print("AppDelegate: Facebook Client Token:", Settings.shared.clientToken ?? "Not set")
        
        // Existing Google Sign-In configuration
        if let clientID = Bundle.main.object(forInfoDictionaryKey: "GIDClientID") as? String {
            print("AppDelegate: Found GIDClientID: \(clientID)")
            // Explicitly configure GIDSignIn
            GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        } else {
            print("AppDelegate: ERROR: GIDClientID not found in Info.plist")
            // Print all keys to help debug
            if let infoDictionary = Bundle.main.infoDictionary {
                print("AppDelegate: Available Info.plist keys:")
                for (key, value) in infoDictionary {
                    print("\(key): \(value)")
                }
            }
        }
        
        return true
    }
    
    func application(_ app: UIApplication,
                    open url: URL,
                    options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("AppDelegate: Handling URL:", url)
        
        // Handle both Facebook and Google Sign-In URLs
        let facebookHandled = ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        let googleHandled = GIDSignIn.sharedInstance.handle(url)
        
        print("AppDelegate: URL handled by Facebook:", facebookHandled)
        print("AppDelegate: URL handled by Google:", googleHandled)
        
        return facebookHandled || googleHandled
    }
}
