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
            createViewController(viewController: AllStoresController(), title: "Geschäfte", unfilledImageName: "shop", filledImageName: "shop-filled", hasNavController: true),
            createViewController(viewController: ProfileController(), title: "Profil", unfilledImageName: "contacts", filledImageName: "contacts-filled"),
        ]
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, unfilledImageName: String, filledImageName: String, hasNavController: Bool = false) -> UIViewController {
        viewController.view.backgroundColor = .white
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: unfilledImageName)
        viewController.tabBarItem.selectedImage = UIImage(named: filledImageName)
        
        if hasNavController {
            let navController = UINavigationController(rootViewController: viewController)
            viewController.navigationItem.title = title
            return navController
        }
        
        return viewController
    }
    
}
