//
//  AppDelegate.swift
//  Sofascore2025
//
//  Created by Ivan Dzanija on 03.03.2025..
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window:UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		self.window = UIWindow()
		self.window?.rootViewController = ViewController()
		self.window?.makeKeyAndVisible()
		return true
	}

	
	

}

