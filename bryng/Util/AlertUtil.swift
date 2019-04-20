//
//  AlertUtil.swift
//  bryng
//
//  Created by Florian Woelki on 10.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit
import JGProgressHUD

class AlertUtil {
    
    static func showBasicAlert(viewController: UIViewController?, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }

    static func showBasicAlertWithDelay(viewController: UIViewController, title: String, message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) { [weak viewController] in
            showBasicAlert(viewController: viewController, title: title, message: message)
        }
    }
    
    static func showBasicActionSheet(viewController: UIViewController, title: String, message: String, actions: [UIAlertAction] = [UIAlertAction]()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach({alert.addAction($0)})
        alert.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showProgressAlert(view: UIView, text: String) {
        let progressHUD = JGProgressHUD(style: .dark)
        progressHUD.textLabel.text = text
        progressHUD.dismiss(afterDelay: 2, animated: true)
        progressHUD.show(in: view)
    }
    
}
