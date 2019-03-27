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
            createViewController(viewController: MapsController(), title: "Maps", unfilledImageName: "map-marker", filledImageName: "map-marker-filled"),
            createViewController(viewController: UIViewController(), title: "Store", unfilledImageName: "shop", filledImageName: "shop-filled"),
            createViewController(viewController: ProfileController(), title: "Profil", unfilledImageName: "contacts", filledImageName: "contacts-filled"),
        ]
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, unfilledImageName: String, filledImageName: String) -> UIViewController {
        
        viewController.view.backgroundColor = .white
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(named: unfilledImageName)
        viewController.tabBarItem.selectedImage = UIImage(named: filledImageName)
        return viewController
    }
    
}
