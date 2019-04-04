//
//  UILabel.swift
//  bryng
//
//  Created by Florian Woelki on 04.04.19.
//  Copyright © 2019 bryng. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont = .systemFont(ofSize: 17), numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
    
}
