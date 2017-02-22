//
//  AppDelegate.swift
//  Cars
//
//  Created by Kamal Jaiswal on 09/02/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit
import GoogleMaps



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey(MapConstants.apiKey)
        return true
    }
}

