//
//  UIStackView+Layout.swift
//  bryng
//
//  Created by Florian Woelki on 24.03.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], spacing: CGFloat, horizontal: Bool = false) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.spacing = spacing
        if (!horizontal) {
            axis = .vertical
        }
    }
    
}
