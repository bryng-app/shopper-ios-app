//
//  BaseTabBarController.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .black
        
        viewControllers = [
            createViewController(viewController: MapController(), title: "Maps", unfilledImageName: "map-marker", filledImageName: "map-marker-filled"),
            createViewController(viewController: AllStoresController(), title: "Geschäfte", unfilledImageName: "shop", filledImageName: "shop-filled"),
            createViewController(viewController: ProfileController(), title: "Profil", unfilledImageName: "contacts", filledImageName: "contacts-filled"),
        ]
        
        selectedViewController = viewControllers![1]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !CoreDataManager.shared.isLoggedIn() {
            let navController = UINavigationController(rootViewController: RegistrationController())
            navController.isNavigationBarHidden = true
            present(navController, animated: true)
        }
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, unfilledImageName: String, filledImageName: String) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: unfilledImageName)
        viewController.tabBarItem.selectedImage = UIImage(named: filledImageName)
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = true
        
        /*if hasNavController {
            viewController.navigationItem.title = title
        } else {*
            navController.isNavigationBarHidden = true
        }*/
        
        return navController
    }
    
}
