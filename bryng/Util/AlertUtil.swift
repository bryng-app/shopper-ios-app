//
//  AlertUtil.swift
//  bryng
//
//  Created by Florian Woelki on 10.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class AlertUtil {
    
    static func showAlert(viewController: UIViewController, title: String, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak viewController] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}
