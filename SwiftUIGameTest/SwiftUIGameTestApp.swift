//
//  SwiftUIGameTestApp.swift
//  SwiftUIGameTest
//
//  Created by Edon Valdman on 3/22/24.
//

import SwiftUI

@main
struct SwiftUIGameTestApp: App {
    @AppDeleteAdaptor
    private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            GameView()
        }
    }
}

#if os(macOS)
typealias AppDelegateProtocol = NSApplicationDelegate
typealias AppDeleteAdaptor = NSApplicationDelegateAdaptor
#else
typealias AppDelegateProtocol = UIApplicationDelegate
typealias AppDeleteAdaptor = UIApplicationDelegateAdaptor
#endif

class AppDelegate: NSObject, AppDelegateProtocol, ObservableObject {
    
}

#if os(macOS)
extension AppDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
#else
extension AppDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
}
#endif
