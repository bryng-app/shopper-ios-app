//
//  UISeperator.swift
//  bryng
//
//  Created by Florian Woelki on 25.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

class UISeperator {
    
    static func create() -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.backgroundColor = .lightGray
        return view
    }
    
}
