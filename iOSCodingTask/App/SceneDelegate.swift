//
//  SceneDelegate.swift
//  iOSCodingTask
//
//  Created by Kunal Rathod on 2026-09-22.
//

import Foundation
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        let window = UIWindow(windowScene: windowScene)
        let navigationController  = UINavigationController()
        
        let appCoordinator = AppCoordinator(
            navigationController: navigationController
        )
    
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
        self.appCoordinator = appCoordinator
        
        appCoordinator.start()
        
    }
    
    

    
}
