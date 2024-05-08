//
//  AppDelegate.swift
//  Movies Fox
//
//  Created by Nirmal Prajapati on 17/04/24.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        return true
    }

    func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)

        if UserDefaults.standard.bool(forKey: "Moviefox") == true{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as? MainTabBar else { return }
            
            
            //navigationController
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.tabBarController?.tabBar.isHidden = false
            
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }else {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "FirstVC") as? FirstVC else { return }
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true            //navigationController
          
            window?.rootViewController = nav
        }
        window?.makeKeyAndVisible()
    }



}

