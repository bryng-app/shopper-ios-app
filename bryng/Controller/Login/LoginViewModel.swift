//
//  LoginViewModel.swift
//  bryng
//
//  Created by Florian Woelki on 18.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class LoginViewModel {
    
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = email?.isEmpty == false && password?.isEmpty == false
        isFormValidObserver?(isFormValid)
    }
    
    var isFormValidObserver: ((Bool) -> ())?
    
}
