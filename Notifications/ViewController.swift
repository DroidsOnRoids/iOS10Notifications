//
//  ViewController.swift
//  Notifications
//
//  Created by Piotr Sochalewski on 13.09.2016.
//  Copyright © 2016 Droids On Roids. All rights reserved.
//

import UIKit

import UserNotifications

class ViewController: UIViewController {
    
    static let dontTapActionIdentifier = "pleaseDontTap"
    static let categoryIdentifier = "category"
    static let myNotificationIdentifier = "myNotification"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        guard #available(iOS 10.0, *) else { return }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Notifications access granted: \(granted.description)")
        }
        
        // 0) Create and register an action and cateogry
        let action = UNNotificationAction(identifier: ViewController.dontTapActionIdentifier, title: "DON'T TAP ME", options: .destructive)
        let category = UNNotificationCategory(identifier: ViewController.categoryIdentifier, actions: [action], intentIdentifiers: [], options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // 1) Create a notification content
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Droids On Roids"
        notificationContent.body = "Notification"
        notificationContent.categoryIdentifier = ViewController.categoryIdentifier
        
        // 2) Create a DateComponents for every o'clock hour
        var dateComponents = DateComponents()
        dateComponents.second = 0
        
        // 3) Create a trigger based on the matching date
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        // 4) Create a request with given identifier content and trigger
        let request = UNNotificationRequest(identifier: ViewController.myNotificationIdentifier, content: notificationContent, trigger: trigger)
        
        // 5) Add the request to the UserNotificationCenter
        UNUserNotificationCenter.current().add(request) { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }
    }
}
