//
//  AppDelegate.swift
//  Study Flash
//
//  Created by Zarioiu Bogdan on 5/7/19.
//  Copyright © 2019 Zarioiu Bogdan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
//    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//
//        return false
//    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //delaying launch screen
        Thread.sleep(forTimeInterval: 2.0)
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        stateManager.checkState()

        //for overall testing
        let testing = true
        if testing {
            
            stateManager.state = .FirstLaunch
            UserDefaults.standard.set(false, forKey: "isTodayCourseFinished")
            UserDefaults.standard.set(false, forKey: "isCourseSelected")
            UserDefaults.standard.synchronize()
            
        }
        
        
        if stateManager.state == .FirstLaunch {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            let onboardingViewController = OnboardingViewController(collectionViewLayout: layout)
            
            window?.rootViewController = onboardingViewController
            
        } else {
            let story = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainViewController = story.instantiateViewController(withIdentifier: "NavigationController")
            
            window?.rootViewController = mainViewController
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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


    
    //Restortion
//    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
//        return true
//    }
//
//    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
//        return true
//    }

}
