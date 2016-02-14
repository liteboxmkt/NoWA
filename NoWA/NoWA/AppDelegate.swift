//
//  AppDelegate.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 29/11/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().hidden = false
        UINavigationBar.appearance().barTintColor = UIColor.ribbonAltColor().colorWithAlphaComponent(0.5)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        //        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
        
        UINavigationBar.appearance().barStyle = .Black
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        let navigationController = UINavigationController()
        
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
        UIApplication.sharedApplication().registerForRemoteNotifications()
        
        
        if (NSUserDefaults.standardUserDefaults().boolForKey("loggeado")) == true {
//            navigationController.viewControllers = [ServicioViewController()]
            beginInTabbar()
        }else{
            if((NSUserDefaults.standardUserDefaults().valueForKey("firstTime")) != nil){
                navigationController.viewControllers = [RegisterViewController()]
            }else{
                navigationController.viewControllers = [TourViewController()]
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstTime")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
        

        
        
        self.window!.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        var token = deviceToken.description
        token = token.stringByReplacingOccurrencesOfString(" ", withString: "")
        token = token.stringByReplacingOccurrencesOfString(">", withString: "")
        token = token.stringByReplacingOccurrencesOfString("<", withString: "")
        
        print(token)
        
        NSUserDefaults.standardUserDefaults().setValue(token, forKey: "deviceToken")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //        print("Notification received: \(userInfo)")
        //        let notification = userInfo["aps"] as? NSDictionary
        //        let message = notification?.valueForKey("alert")
        //
        if ( application.applicationState == UIApplicationState.Active ) {
            let alarmNotification = UILocalNotification()
            alarmNotification.alertBody = "ALARMA SONANDO"
            alarmNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.sharedApplication().presentLocalNotificationNow(alarmNotification)
        }
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        if let userInfo = notification.userInfo {
            let customField1 = userInfo["CustomField1"] as! String
            print("didReceiveLocalNotification: \(customField1)")
        }
    }
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        FBSDKAppEvents.activateApp()
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func beginInTabbar(){
        let tabBarController = MainTabBarController()
        
        let servicio = ServicioViewController()
        let alarmas = AlarmasViewController()
        let torneos = TorneosViewController()
        let perfil = PerfilViewController()
        let controllers = [servicio,alarmas,torneos,perfil]
        
        tabBarController.viewControllers = controllers
        
        let firstImage = UIImage(named: "cloud")?.imageWithRenderingMode(.AlwaysOriginal)
        let firstImage_sel = UIImage(named: "cloud_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        let secondImage = UIImage(named: "clock")?.imageWithRenderingMode(.AlwaysOriginal)
        let secondImage_sel = UIImage(named: "clock_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        let thirdImage = UIImage(named: "team")?.imageWithRenderingMode(.AlwaysOriginal)
        let thirdImage_sel = UIImage(named: "team_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        let fourthImage = UIImage(named: "equalizer")?.imageWithRenderingMode(.AlwaysOriginal)
        let fourthImage_sel = UIImage(named: "equalizer_selected")?.imageWithRenderingMode(.AlwaysOriginal)
        
        
        servicio.tabBarItem = UITabBarItem(
            title: "Servicio",
            image: firstImage,
            selectedImage: firstImage_sel)
        alarmas.tabBarItem = UITabBarItem(
            title: "Alarmas",
            image: secondImage,
            selectedImage: secondImage_sel)
        torneos.tabBarItem = UITabBarItem(
            title: "Torneos",
            image: thirdImage,
            selectedImage: thirdImage_sel)
        perfil.tabBarItem = UITabBarItem(
            title: "Perfil",
            image: fourthImage,
            selectedImage: fourthImage_sel)
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [tabBarController]
        
    }
    
    
}


