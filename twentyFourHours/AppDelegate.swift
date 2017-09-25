//
//  AppDelegate.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        createSlidingMenu()
        // Override point for customization after application launch.
        return true
    }
    
    func createSlidingMenu(){
        
        let frontViewController = EnterViewController()
        let rearViewController = PopUpViewController()
        
        let swRevealVC = SWRevealViewController(rearViewController: rearViewController, frontViewController: frontViewController)
        swRevealVC?.toggleAnimationType = SWRevealToggleAnimationType.easeOut
        swRevealVC?.toggleAnimationDuration = 0.30
        
        self.window?.rootViewController = swRevealVC!
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        SocketIOManager.sharedInstance.closeConnection()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        SocketIOManager.sharedInstance.establishConnection()
        
           SocketIOManager.sharedInstance.getRoomId { (roomInfo) -> Void in
                SocketIOManager.sharedInstance.subscribe(room: roomInfo["room"]!)
                DispatchQueue.main.async(execute: { () -> Void in
                    print("------  -------  ------ knok room knok ------  -------")
            })
        }
        
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            print(messageInfo)
            DispatchQueue.main.async(execute: { () -> Void in
                print("------  -------  ------ knok message knok ------  -------")
            })
        }
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

