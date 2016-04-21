//
//  AppDelegate.swift
//  NewBusiness
//
//  Created by lepjdk on 16/4/8.
//  Copyright © 2016年 lepjdk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        /*
        let str = "123456"
        let str2 = NBStringUtil.MD5Encrypt(str)
        NSLog("%@", str2)
        let dictM = NSMutableDictionary()
        dictM["account"] = "13800138001"
        dictM["password"]  = str2
        dictM["version_code"] = "20160421"
        */
        
        //设置tabbar全局外观
        setTabBarAppearance()
        //设置Navigation全局外观
        setNavigationAppearance()

//        let storyBoard = UIStoryboard.init(name: "Storyboard", bundle: nil)
//        let loginVC = storyBoard.instantiateInitialViewController()
        let tabbarVC = NBTabBarController()
        window =  UIWindow.init(frame: UIScreen.mainScreen().bounds)
        
//        window?.rootViewController = loginVC
        window?.rootViewController = tabbarVC
        
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    private func setTabBarAppearance()
    {
        //设置全局外观[UIColor colorWithRed:242/255.0f green:163/255.0f blue:58/255.0f alpha:1]
        UITabBar.appearance().tintColor = UIColor(red: 242/255.0, green: 163/255.0, blue: 58/255.0, alpha: 1)
        let rect : CGRect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let content : CGContextRef = UIGraphicsGetCurrentContext()!
        //[UIColor colorWithRed:255.0/256.0 green:159.0/256.0 blue:0.0 alpha:1.0].CGColor
        CGContextSetFillColorWithColor(content, UIColor(red: 255.0/256.0, green: 159.0/256.0, blue: 0.0, alpha: 1).CGColor)
        CGContextFillRect(content, rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = image
        UITabBar.appearance().barTintColor = UIColor.whiteColor()
    }
    
    private func setNavigationAppearance()
    {
        //设置全局外观
        UINavigationBar.appearance().tintColor = UIColor(red: 242/255.0, green: 163/255.0, blue: 58/255.0, alpha: 1)
        UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(15)]
        UINavigationBar.appearance().backIndicatorImage = UIImage(named: "ic_nav_back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(named: "ic_nav_back")
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
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

