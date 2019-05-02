//
//  FinalCheckoutController.swift
//  bryng
//
//  Created by Florian Woelki on 02.05.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class FinalCheckoutController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = "Gesamtpreis"
    }
    
}
