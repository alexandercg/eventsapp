//
//  AppDelegate.swift
//  Upcoming Events
//
//  Created by Alexander Camacho on 7/29/19.
//  Copyright © 2019 Alexander Camacho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        
        // make instance of the calendar api to be injected on the view controller
        let calendarAPI = CalendarAPI()
        
        // setup view controller
        window?.rootViewController = UINavigationController(rootViewController: EventsTableViewController(api: calendarAPI))
        window?.makeKeyAndVisible()
        return true
    }

}

