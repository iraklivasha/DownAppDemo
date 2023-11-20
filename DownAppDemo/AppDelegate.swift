//
//  AppDelegate.swift
//  DownAppDemo
//
//  Created by Irakli Vashakidze on 17.11.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().barTintColor = .orange
            UITabBar.appearance().tintColor = .green

        makeRootViewController(MainTabBarController())
        return true
    }

    private func makeRootViewController(_ controller: UIViewController) {
        guard let instance = UIApplication.shared.delegate as? AppDelegate else { return }
        instance.window = UIWindow(frame: UIScreen.main.bounds)
        instance.window?.rootViewController = controller
        instance.window?.makeKeyAndVisible()
    }
}

