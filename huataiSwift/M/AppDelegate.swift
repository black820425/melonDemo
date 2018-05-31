//
//  AppDelegate.swift
//  huataiSwift
//
//  Created by Bryan on 2018/4/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//
import UIKit
import UserNotifications


class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  var window: UIWindow?
  
  var backgroundTask:UIBackgroundTaskIdentifier! = nil
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    LanguageTool.sharedInstance().initLanguage()
    
    UINavigationBar.appearance().tintColor = Singleton.sharedInstance().getThemeColorR140xG140xB143()
    UINavigationBar.appearance().titleTextAttributes =
      [NSAttributedStringKey.foregroundColor : Singleton.sharedInstance().getThemeColorR140xG140xB143()]
  

    //create the notificationCenter
    let center  = UNUserNotificationCenter.current()
    center.delegate = self
    // set the type as sound or badge
    center.requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
      //Enable or disable features based on authorization
      
    }
    application.registerForRemoteNotifications()
  
    return true
  }
  
  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    self.backgroundTask = application.beginBackgroundTask(expirationHandler: {
      application.endBackgroundTask(self.backgroundTask)
      self.backgroundTask = UIBackgroundTaskInvalid
    })
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})

    print("deviceTokenString --> \(deviceTokenString)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    UIApplication.shared.applicationIconBadgeNumber = userInfo["badge"] as! Int
    
    if(UserDefaults.standard.object(forKey: "NotificationContentArray") != nil) {
      
    }
  }
  
}
