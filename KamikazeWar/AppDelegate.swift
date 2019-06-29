//
//  AppDelegate.swift
//  KamikazeWar
//
//  Created by Alberto García-Muñoz on 29/06/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = LandingRouter.getViewController()
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
        return true
    }
    
}

