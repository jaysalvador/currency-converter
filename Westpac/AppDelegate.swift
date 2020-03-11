//
//  AppDelegate.swift
//  Westpac
//
//  Created by Jay Salvador on 11/3/20.
//  Copyright © 2020 Jay Salvador. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    class var shared: AppDelegate? {
        
        return UIApplication.shared.delegate as? AppDelegate
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - UI
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = UIViewController()
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

