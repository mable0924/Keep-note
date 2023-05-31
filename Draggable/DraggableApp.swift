//
//  DraggableApp.swift
//  Draggable
//
//  Created by Po hin Ma on 23/4/2023.
//

import SwiftUI

@main
struct DraggableApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
