//
//  AppDelegate.swift
//  SqlDatabse
//
//  Created by Nirmal Prajapati on 04/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

var strpath = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dbcopypaste()
        return true
    }
func dbcopypaste()
    {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        strpath = path + "/DataDEmo.db"
        print(strpath)
        
        if !FileManager.default.fileExists(atPath: strpath)
        {
            let selectdb =  Bundle.main.path(forResource: "DataDEmo", ofType: "db")
            try? FileManager.default.copyItem(atPath: selectdb!, toPath: strpath)
            print("Database path copied")
        }
        else
        {
            print("Database path not copied")
        }
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

