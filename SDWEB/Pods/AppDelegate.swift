//
//  AppDelegate.swift
//  CustomWallPaper
//
//  Created by Nirmal Prajapati on 09/02/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if Tokenservice.Tokenintence.checkorLogin()  {
            // User is not logged in, show the login view
           showLoginView()
            
        } else {
            // User is logged in, navigate to the main part of the app
            navigateToMainApp()
        }
        return true
    }

    private func showLoginView() {
        // Instantiate and show your login view controller
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
                let newViewController = storyboard.instantiateViewController(withIdentifier: "SlideOne") as! SlideOne// Replace "YourNewViewController" with your view controller's storyboard identifier

                // Set up a navigation controller if needed
                let navigationController = UINavigationController(rootViewController: newViewController)
                navigationController.navigationBar.isHidden = true
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func navigateToMainApp() {
            // Instantiate your main view controller or switch root view controller based on user's login state
            // You may also need to perform any necessary setup based on userIdentifier
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
                let newViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBar") as! MainTabBar // Replace "YourNewViewController" with your view controller's storyboard identifier

                // Set up a navigation controller if needed
                let navigationController = UINavigationController(rootViewController: newViewController)
                navigationController.navigationBar.isHidden = true
                window?.rootViewController = navigationController
                window?.makeKeyAndVisible()
        }

    
    
 

}

