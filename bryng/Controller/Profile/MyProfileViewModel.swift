//
//  MyProfileViewModel.swift
//  bryng
//
//  Created by Florian Woelki on 14.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class MyProfileViewModel {
    
    var isFormValidObserver: ((Bool) -> ())?
    
    var name: String? { didSet { checkFormValidity() } }
    var email: String? { didSet { checkFormValidity() } }
    var phoneNumber: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        var isFormValid = false
        
        if name?.isEmpty == false && email?.isEmpty == false && phoneNumber?.isEmpty == false {
            isFormValid = true
        }
        
        isFormValidObserver?(isFormValid)
    }
    
}
