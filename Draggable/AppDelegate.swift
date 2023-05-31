//
//  AppDelegate.swift
//  Draggable
//
//  Created by Po hin Ma on 28/5/2023.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("Did Finish Launching")
        NotificationCenter.default.post(name: Notification.Name("DidFinishLaunching"), object: nil)
        return true
    }

    
}
