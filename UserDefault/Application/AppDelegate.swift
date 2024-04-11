//
//  AppDelegate.swift
//  ProxPics
//
//  Created by Nirmal Prajapati on 05/04/24.
//

import UIKit
import SwiftyBeaver
import PopupDialog

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setRootVC()
        // configure logger
        //SwiftyBeaver.setup()

        // configure pop up dialogs
        PopupDialog.setup()
        return true
    }

    func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)

        if UserDefaults.standard.bool(forKey: "PicsLight") == true{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "OptionVC") as? OptionVC else { return }
            
            
            //navigationController
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }else {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "SliderVC") as? SliderVC else { return }
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true            //navigationController
          
            window?.rootViewController = nav
        }
        window?.makeKeyAndVisible()
    }

}

