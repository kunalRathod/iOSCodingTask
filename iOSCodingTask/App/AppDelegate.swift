//
//  AppDelegate.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-22.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let configuration = UISceneConfiguration(
            name: "Default",
            sessionRole: connectingSceneSession.role
        )
        
        configuration.delegateClass = SceneDelegate.self
        
        return configuration
        
    }
}
