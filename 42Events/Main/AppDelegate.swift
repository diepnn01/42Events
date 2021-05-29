//
//  AppDelegate.swift
//  42Events
//
//  Created by Diep Nguyen on 25/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupDefaultNavigationBarAppearance()
        return true
    }
    
    func setupDefaultNavigationBarAppearance() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().isTranslucent = false
    }
}

