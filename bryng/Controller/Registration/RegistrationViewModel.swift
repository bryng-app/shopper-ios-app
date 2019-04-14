//
//  RegistrationViewModel.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var name: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = name?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    // Reactive programming
    var isFormValidObserver: ((Bool) -> ())?
    
}
