//
//  AppDelegate.swift
//  PrivateFriend
//
//  Created by Nirmal on 06/05/24.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setRootVC()
        return true
    }

    func setRootVC() {
        window = UIWindow(frame: UIScreen.main.bounds)

        if UserDefaults.standard.bool(forKey: "PrivateFriend") == true{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "AuthenticationVC") as? AuthenticationVC else { return }
            
            
            //navigationController
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.tabBarController?.tabBar.isHidden = false
            
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }else {
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "IntroOne") as? IntroOne else { return }
            
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true            //navigationController
          
            window?.rootViewController = nav
        }
        window?.makeKeyAndVisible()
    }
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PrivateFriend")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

