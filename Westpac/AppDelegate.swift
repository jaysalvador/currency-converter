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
    
    var theme: Theme {
        
        let theme = Bundle.main.object(forInfoDictionaryKey: "Theme") as? String ?? "standard"
        
        return Theme(rawValue: theme) ?? .standard
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: - UI
        
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let nav = UINavigationController(rootViewController: CurrencyViewController())
        
        nav.setNavigationBarHidden(true, animated: false)
        
        self.window?.rootViewController = nav
        
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

