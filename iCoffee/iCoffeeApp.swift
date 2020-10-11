//
//  iCoffeeApp.swift
//  iCoffee
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct iCoffeeApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authVM = AuthViewModel()
    
    var body: some Scene {
       
        WindowGroup {
            ContentView().environmentObject(authVM)
        }
    }
}
